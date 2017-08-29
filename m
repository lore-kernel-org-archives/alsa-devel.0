From: Mark Hills <mark@xwax.org>
Subject: Re: "alsactl store" fails to save Echo Gina3G mixer
Date: Tue, 29 Aug 2017 21:36:44 +0100 (BST)
Message-ID: <1708292129400.21841@stax.localdomain>
References: <d8d6d07c-ade6-1ccc-7111-ed367fccf0f9@gmail.com>
 <1fa01cef-7159-b1b2-8ec6-5eab7f2a7e29@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jazz.pogo.org.uk (jazz.pogo.org.uk [213.138.114.167])
 by alsa0.perex.cz (Postfix) with ESMTP id D9BED266E37
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 22:36:46 +0200 (CEST)
In-Reply-To: <1fa01cef-7159-b1b2-8ec6-5eab7f2a7e29@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, "S. Christian Collins" <s.chriscollins@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 29 Aug 2017, Takashi Sakamoto wrote:

> On Aug 29 2017 00:34, S. Christian Collins wrote:
> > However, when I try to save the Gina3G mixer:
> > 
> >    alsactl -f ~/asound1.state store 1
> > 
> > ...I get the following error:
> > 
> > alsactl: control.c:2513: snd_ctl_elem_value_get_integer: Assertion `idx <
> > sizeof(obj->value.integer.value) / sizeof(obj->value.integer.value[0])'
> > failed.
> > Aborted
> > 
> > I have tried to find any info on this error online, but to no avail. Does
> > anybody know what is going on here?
> 
> The value of 'sizeof(obj->value.integer.value) /
> sizeof(obj->value.integer.value[0])' has fixed value (=128), therefore the
> value of 'idx' is greater than 128, against expectation.
> 
> Would you get output from below command line for your Gina 3G?
> 
> $ amixer scontrols
> 
> And typically state data is stored into '/var/lib/alsa/asound.state' as a
> default. For my information, could you disclose it if possible?

I think you're suffering the same problem I am with my Echo Layla 3G. Does 
'echomixer' work?

For some time now I have been running with commit 275353bb6 (copied below) 
reverted.

I did my most recent tests on kernel 4.10.3, resulting in the revert of 
that commit. I with the reverted commit. I recall that alsactl, alsamier 
were also affected.

I have been intending to make a 'proper' report to the list, or even 
investigate more myself. But priorities did not permit that yet. I also 
wasn't able to find information on what these fields actually mean. As far 
as I could tell, some of these attributes are unique to the echo3g and 
echomixer.

Thanks

-- 
Mark


>From 275353bb684ecfeb42f7a353fead81d43a01c519 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Sat, 16 Jul 2016 22:24:32 +0900
Subject: [PATCH] ALSA: echoaudio: purge contradictions between dimension
 matrix members and total number of members

Currently, sound device drivers for PCI cards produced by Echo Audio
support dimension parameter of element information. But the information
has contradictions to the number of members of each element. I guess that
this comes from the assumption that these sound cards are used only by
'echomixer' in userspace. But ideally, they should be used with usual ALSA
control applications.

This commit removes the contradiction. As a result, 'Monitor Mixer Volume'
and 'VMixer Volume' elements are shown in usual ALSA control applications
such as 'amixer' and 'alsamixer' in series.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/echoaudio/echoaudio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 1cb85aeb0cea..3a8e8d5a5617 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1272,11 +1272,11 @@ static int snd_echo_mixer_info(struct snd_kcontrol *kcontrol,
 
 	chip = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 1;
 	uinfo->value.integer.min = ECHOGAIN_MINOUT;
 	uinfo->value.integer.max = ECHOGAIN_MAXOUT;
 	uinfo->dimen.d[0] = num_busses_out(chip);
 	uinfo->dimen.d[1] = num_busses_in(chip);
+	uinfo->count = uinfo->dimen.d[0] * uinfo->dimen.d[1];
 	return 0;
 }
 
@@ -1344,11 +1344,11 @@ static int snd_echo_vmixer_info(struct snd_kcontrol *kcontrol,
 
 	chip = snd_kcontrol_chip(kcontrol);
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 1;
 	uinfo->value.integer.min = ECHOGAIN_MINOUT;
 	uinfo->value.integer.max = ECHOGAIN_MAXOUT;
 	uinfo->dimen.d[0] = num_busses_out(chip);
 	uinfo->dimen.d[1] = num_pipes_out(chip);
+	uinfo->count = uinfo->dimen.d[0] * uinfo->dimen.d[1];
 	return 0;
 }
 
@@ -1728,7 +1728,6 @@ static int snd_echo_vumeters_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
-	uinfo->count = 96;
 	uinfo->value.integer.min = ECHOGAIN_MINOUT;
 	uinfo->value.integer.max = 0;
 #ifdef ECHOCARD_HAS_VMIXER
@@ -1738,6 +1737,7 @@ static int snd_echo_vumeters_info(struct snd_kcontrol *kcontrol,
 #endif
 	uinfo->dimen.d[1] = 16;	/* 16 channels */
 	uinfo->dimen.d[2] = 2;	/* 0=level, 1=peak */
+	uinfo->count = uinfo->dimen.d[0] * uinfo->dimen.d[1] * uinfo->dimen.d[2];
 	return 0;
 }
 
-- 
2.14.1
