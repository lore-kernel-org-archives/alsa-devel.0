From: Matthias Dahl <ml_alsa@mortal-soul.de>
Subject: Re: snd-hda-intel,
	AD 1988b: SPDIF output not working correctly,
	volume low for analog output
Date: Mon, 23 Jul 2007 22:58:23 +0200
Message-ID: <200707232258.24771.ml_alsa@mortal-soul.de>
References: <200707170832.01976.ml_alsa@mortal-soul.de>
	<200707200829.03682.ml_alsa@mortal-soul.de>
	<s5hd4ynnq44.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dd15922.kasserver.com (dd15922.kasserver.com [85.13.137.18])
	by alsa0.perex.cz (Postfix) with ESMTP id 85DDD103899
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 22:58:10 +0200 (CEST)
Received: from marvin (unknown [88.134.217.11])
	by dd15922.kasserver.com (Postfix) with ESMTP id 87D5B18118D96
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 22:58:11 +0200 (CEST)
In-Reply-To: <s5hd4ynnq44.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi.

On Friday 20 July 2007 15:47:55 Takashi Iwai wrote:

> This is expected behavior.  The PCM volume is implemented via softvol
> plugin, and it creates dynamically at the first run.  But, usually,
> it's restored via alsactl at the next boot.

It is. Thanks for the info.

> Yes, it'll involve with patch_analog.c deeply.  Basically you need to
> modify init verb table and the mixer element table.  Check the AD1988B
> datasheet, and try to assign the different PIN (and corresponding
> mixer / selector widgets) in init verb and mixer tables.  Then,
> rebuild driver, and try the driver until you get the complete mapping
> of pin widgets.

I am currently a bit limited in time (end of semester exams) but after a few 
hours of playing around (and reading the specs) I figured the following:

1) From time to time no analog output is routed to the spdif anymore. The only
   clue I could get is the "IEC958 Playback Default" which is set to

   06820002 [... many more zeros ...]

   and thus restored to that value after reboots. When things work like they
   should (analog output is routed to spdif), its value is

   04820002 [... many more zeros ...]

   Manually setting it to this value naturally solves the problem. I have yet
   to figure out how to trigger this problem?! It seems to happen rather
   randomly. In both cases, ac3 passthrough works just fine btw.


2) I have come a step closer in solving the analog-to-spdif volume/distortions
   problem... at least I hope. 

   The following patch fixes the volume problem for me. Without it, I had to
   set the IEC958 volume somewhere around 58... increasing it would result in
   noticable clipping and even short audio gaps (noise).

   Honestly, I don't quite understand the purpose of the code I removed in the
   first place. From what I figured reading the specs and the code, the spdif
   in is mixed with the spdif out stream... but that's all I could gather. But
   still it doesn't seem quite right to me.

--- patch_analog.c.orig 2007-07-23 22:44:25.000000000 +0200
+++ patch_analog.c      2007-07-23 22:45:15.000000000 +0200
@@ -2037,12 +2037,8 @@
 static struct hda_verb ad1988_spdif_init_verbs[] = {
        /* SPDIF out sel */
        {0x02, AC_VERB_SET_CONNECT_SEL, 0x0}, /* PCM */
-       {0x0b, AC_VERB_SET_CONNECT_SEL, 0x0}, /* ADC1 */
-       {0x1d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-       {0x1d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(1)},
        /* SPDIF out pin */
        {0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x27}, /* 0dB */
-       {0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0) | 0x17}, /* 0dB */

        { }
 };

    The audio distortions in the background have become a little less noisy
    but are still there. (a bass-like pumping, some white noise and sometimes
    some high frequency tone) But the volume works just fine now... (iec958
    vol at 100%) and the audio sounds somewhat "clearer"!

Sorry I couldn't get any further so far. I hope this maybe gives some clues to 
you what else could be wrong after all. The chip works just fine under win, 
if it weren't for that, I'd blame the hw.

Best regards,
Matthias Dahl
