From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Fix 'Beep Playback Switch'
 with no underlying mute switch
Date: Tue, 14 Aug 2012 10:04:05 +0200
Message-ID: <502A0675.8070100@canonical.com>
References: <1344871813-26650-1-git-send-email-david.henningsson@canonical.com>
 <s5hvcgmu7hg.wl%tiwai@suse.de> <5029F80E.3070001@canonical.com>
 <s5hd32t9aud.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050509070709010307010106"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FC1F265294
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 09:34:20 +0200 (CEST)
In-Reply-To: <s5hd32t9aud.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050509070709010307010106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 08/14/2012 09:44 AM, Takashi Iwai wrote:
>>>> I admit "knew->info == snd_hda_mixer_amp_switch_info" and "kctl->private_value = 0x10000"
>>>> looks a bit hacky, feel free to suggest something more elegant if you wish.
>>>
>>> Checking the amp out caps in snd_hda_mixer_amp_switch_*_beep() would
>>> be better, IMO.  It's not necessarily limited to patch_conexant.c.
>>
>> Ok, here comes a second version of the patch. What do you think?
>
> Better to use query_amp_caps().  It's cached, so the succeeding call
> is cheap.  For example:

Ok, third version attached.



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------050509070709010307010106
Content-Type: text/x-patch;
 name="0001-ALSA-hda-Fix-Beep-Playback-Switch-with-no-underlying.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-Fix-Beep-Playback-Switch-with-no-underlying.pa";
 filename*1="tch"

>From 885d5e0f099b089ebec7b61d6caeb7e751d1f6e7 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 13 Aug 2012 17:10:46 +0200
Subject: [PATCH] ALSA: hda - Fix 'Beep Playback Switch' with no underlying
 mute switch

Some Conexant devices (e g CX20590) have no mute capability on
their Beep widgets.
This patch makes sure we don't try setting mutes on those widgets.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_beep.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index d26ae65..e22413e 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -231,15 +231,22 @@ void snd_hda_detach_beep_device(struct hda_codec *codec)
 }
 EXPORT_SYMBOL_HDA(snd_hda_detach_beep_device);
 
+static bool ctl_has_mute(struct snd_kcontrol *kcontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	return query_amp_caps(codec, get_amp_nid(kcontrol),
+			      get_amp_direction(kcontrol)) & AC_AMPCAP_MUTE;
+}
+
 /* get/put callbacks for beep mute mixer switches */
 int snd_hda_mixer_amp_switch_get_beep(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct hda_beep *beep = codec->beep;
-	if (beep && !beep->enabled) {
+	if (beep && (!ctl_has_mute(kcontrol) || !beep->enabled)) {
 		ucontrol->value.integer.value[0] =
-			ucontrol->value.integer.value[1] = 0;
+			ucontrol->value.integer.value[1] = beep->enabled;
 		return 0;
 	}
 	return snd_hda_mixer_amp_switch_get(kcontrol, ucontrol);
@@ -263,6 +270,8 @@ int snd_hda_mixer_amp_switch_put_beep(struct snd_kcontrol *kcontrol,
 			enable |= *valp;
 		snd_hda_enable_beep_device(codec, enable);
 	}
+	if (!ctl_has_mute(kcontrol))
+		return 0;
 	return snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
 }
 EXPORT_SYMBOL_HDA(snd_hda_mixer_amp_switch_put_beep);
-- 
1.7.9.5


--------------050509070709010307010106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050509070709010307010106--
