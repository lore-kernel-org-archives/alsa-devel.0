From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Fix 'Beep Playback Switch'
 with no underlying mute switch
Date: Tue, 14 Aug 2012 09:02:38 +0200
Message-ID: <5029F80E.3070001@canonical.com>
References: <1344871813-26650-1-git-send-email-david.henningsson@canonical.com>
 <s5hvcgmu7hg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050508030109010809080608"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 06F3726529D
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 08:32:52 +0200 (CEST)
In-Reply-To: <s5hvcgmu7hg.wl%tiwai@suse.de>
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
--------------050508030109010809080608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 08/13/2012 05:39 PM, Takashi Iwai wrote:
> At Mon, 13 Aug 2012 17:30:13 +0200,
> David Henningsson wrote:
>>
>> Some conexant devices has no mute capability on their Beep widgets.
>> This patch makes sure we don't try setting mutes on those widgets.
>>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
>>
>> Another Beep fix. It's not that I'm suddenly obsessed with beeping; it's my automated
>> test tool that finds them :-)
>
> Good that you can demonstrate the results ;)

Yes, I'm still working on the test tool. Got to have something to show 
at Plumber's :-)

>> I admit "knew->info == snd_hda_mixer_amp_switch_info" and "kctl->private_value = 0x10000"
>> looks a bit hacky, feel free to suggest something more elegant if you wish.
>
> Checking the amp out caps in snd_hda_mixer_amp_switch_*_beep() would
> be better, IMO.  It's not necessarily limited to patch_conexant.c.

Ok, here comes a second version of the patch. What do you think?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------050508030109010809080608
Content-Type: text/x-patch;
 name="0001-ALSA-hda-Fix-Beep-Playback-Switch-with-no-underlying.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-Fix-Beep-Playback-Switch-with-no-underlying.pa";
 filename*1="tch"

>From 82710da74aa51e3fa1c19f1d575cbe124327e501 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 13 Aug 2012 17:10:46 +0200
Subject: [PATCH] ALSA: hda - Fix 'Beep Playback Switch' with no underlying
 mute switch

Some Conexant devices (e g CX20590) have no mute capability on
their Beep widgets.
This patch makes sure we don't try setting mutes on those widgets.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_beep.c |   26 ++++++++++++++++++++++++--
 sound/pci/hda/hda_beep.h |    1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index d26ae65..815dc88 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -231,15 +231,33 @@ void snd_hda_detach_beep_device(struct hda_codec *codec)
 }
 EXPORT_SYMBOL_HDA(snd_hda_detach_beep_device);
 
+static void verify_amp_has_mute(struct snd_kcontrol *kcontrol)
+{
+	unsigned int caps;
+	int dir;
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_beep *beep = codec->beep;
+	if (snd_BUG_ON(!beep))
+		return;
+
+	dir = get_amp_direction(kcontrol) == HDA_INPUT ? AC_PAR_AMP_IN_CAP : AC_PAR_AMP_OUT_CAP;
+	caps = snd_hda_param_read(codec, get_amp_nid(kcontrol), dir);
+	if (!(caps & AC_AMPCAP_MUTE))
+		kcontrol->private_value &= 0xffff0000; /* No NID to set */
+	beep->amp_verified = 1;
+}
+
 /* get/put callbacks for beep mute mixer switches */
 int snd_hda_mixer_amp_switch_get_beep(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct hda_beep *beep = codec->beep;
-	if (beep && !beep->enabled) {
+	if (beep && !beep->amp_verified)
+		verify_amp_has_mute(kcontrol);
+	if (beep && (!get_amp_nid(kcontrol) || !beep->enabled)) {
 		ucontrol->value.integer.value[0] =
-			ucontrol->value.integer.value[1] = 0;
+			ucontrol->value.integer.value[1] = beep->enabled;
 		return 0;
 	}
 	return snd_hda_mixer_amp_switch_get(kcontrol, ucontrol);
@@ -262,7 +280,11 @@ int snd_hda_mixer_amp_switch_put_beep(struct snd_kcontrol *kcontrol,
 		if (chs & 2)
 			enable |= *valp;
 		snd_hda_enable_beep_device(codec, enable);
+		if (!beep->amp_verified)
+			verify_amp_has_mute(kcontrol);
 	}
+	if (!get_amp_nid(kcontrol))
+		return 0;
 	return snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
 }
 EXPORT_SYMBOL_HDA(snd_hda_mixer_amp_switch_put_beep);
diff --git a/sound/pci/hda/hda_beep.h b/sound/pci/hda/hda_beep.h
index 4dc6933..923e91a 100644
--- a/sound/pci/hda/hda_beep.h
+++ b/sound/pci/hda/hda_beep.h
@@ -36,6 +36,7 @@ struct hda_beep {
 	hda_nid_t nid;
 	unsigned int enabled:1;
 	unsigned int linear_tone:1;	/* linear tone for IDT/STAC codec */
+	unsigned int amp_verified:1;  /* Have we verified that the node has a mute switch? */
 	struct work_struct beep_work; /* scheduled task for beep event */
 	struct mutex mutex;
 };
-- 
1.7.9.5


--------------050508030109010809080608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050508030109010809080608--
