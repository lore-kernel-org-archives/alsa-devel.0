From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH fixed bug 4032 1/1] Fixed bug 4032.
Date: Tue, 15 Dec 2009 10:35:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912151024170.2598@eeebox2.perex-int.cz>
References: <4B2686F3.8040001@gmail.com> <s5hskbdwfai.wl%tiwai@suse.de>
	<4B26A4DD.8010203@gmail.com> <s5h1viwk2xg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id D17FC103800
	for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2009 10:35:12 +0100 (CET)
In-Reply-To: <s5h1viwk2xg.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Steve Soule <sts11dbxr@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 15 Dec 2009, Takashi Iwai wrote:

> At Mon, 14 Dec 2009 13:49:33 -0700,
> Steve Soule wrote:
>>
>> On 12/14/2009 12:01 PM, Takashi Iwai wrote:
>>> At Mon, 14 Dec 2009 11:41:55 -0700,
>>> Steve Soule wrote:
>>>>
>>>>> From c3387a767f827f57a6b1f6b772d3d7a1b6b39942 Mon Sep 17 00:00:00 2001
>>>> From: Steve Soule <sts11dbxr@gmail.com>
>>>> Date: Mon, 14 Dec 2009 11:06:03 -0700
>>>> Subject: [PATCH fixed bug 4032 1/1] Fixed bug 4032.
>>>>
>>>>
>>>> Signed-off-by: Steve Soule <sts11dbxr@gmail.com>
>>>
>>> Could you give a bit more changelog text?
>>> It's not sure what bug 4032 indicates, and more importantly, why this
>>> change is needed for fixing what.
>>
>> Okay.  Here is a thorough changelog:
>>
>> This is a fix of a bug in ac97_codec.c. This bug has existed for many
>> years in many versions of alsa and versions of the kernel.  The bug
>> appears with a Soundblaster 16PCI sound card.  With this card, sometimes
>> the driver works correctly, and sometimes it doesn't.  When it doesn't
>> work correctly, the driver prints the error message:
>>
>> AC'97 0 analog subsections not ready
>>
>> and fails to detect the complete set of sound controls.  In particular,
>> the driver fails to detect the "Master Playback Volume" control, and so
>> the sound card volume level is arbitrary--usually very low.
>>
>> As far as I can tell, the problem is in the function snd_ac97_mixer() in
>> ac97_codec.c, in the lines immediately before the error message is
>> printed.  These lines appear to be waiting for the card to come out of
>> powerdown mode.  If the card does not come up within a timeout, the
>> error message is printed, and the controls are not detected correctly.
>>
>> The timeout in the latest version is 120 ms (though it was 100 ms when I
>> first reported this bug a year and a half ago).  I experimented with
>> different timeout values, and found that 1 second was not sufficient,
>> and that 5 seconds is sufficient.
>
> Hrm, usually 1 second is really long enough for any operations.
> And 5 seconds is already a history since genesis.  If it takes so
> long, something other is fishy.
>
> Although extending the timeout would be relatively harmless, I still
> don't think this is the point to fix.  More likely the problem is in
> the codec accessor side...

Maybe, but ens1371 chip is really old and it might be that the initial 
codec link synchronization is not ideal.

What about to add the timeout variable to ac97 structure?

Something like this:

diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
index 4940045..2ff650a 100644
--- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -381,6 +381,7 @@
  #define AC97_SCAP_NO_SPDIF	(1<<9)	/* don't build SPDIF controls */
  #define AC97_SCAP_EAPD_LED	(1<<10)	/* EAPD as mute LED */
  #define AC97_SCAP_POWER_SAVE	(1<<11)	/* capable for aggresive power-saving */
+#define AC97_SCAP_LONGANALOGTMO	(1<<12)	/* long timeout for analog subsect */

  /* ac97->flags */
  #define AC97_HAS_PC_BEEP	(1<<0)	/* force PC Speaker usage */
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index c119206..ec22a9a 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2122,7 +2122,10 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
  		}
  		/* nothing should be in powerdown mode */
  		snd_ac97_write_cache(ac97, AC97_GENERAL_PURPOSE, 0);
-		end_time = jiffies + msecs_to_jiffies(5000);
+		end_time = 120;
+		if (ac97->scaps & AC97_SCAP_LONGANALOGTMO)
+			end_time = 5000;
+		end_time = jiffies + msecs_to_jiffies(end_time);
  		do {
  			if ((snd_ac97_read(ac97, AC97_POWERDOWN) & 0x0f) == 0x0f)
  				goto __ready_ok;
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 2b82c5c..8afe173 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -1631,7 +1631,7 @@ static int __devinit snd_ensoniq_1371_mixer(struct ensoniq *ensoniq,
  	ac97.private_data = ensoniq;
  	ac97.private_free = snd_ensoniq_mixer_free_ac97;
  	ac97.pci = ensoniq->pci;
-	ac97.scaps = AC97_SCAP_AUDIO;
+	ac97.scaps = AC97_SCAP_AUDIO|AC97_SCAP_LONGANALOGTMO;
  	if ((err = snd_ac97_mixer(pbus, &ac97, &ensoniq->u.es1371.ac97)) < 0)
  		return err;
  	if (has_spdif > 0 ||

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
