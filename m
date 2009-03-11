From: Gregorio Guidi <gregorio.guidi@gmail.com>
Subject: Re: [PATCH] fix headphone settings and master
	volume	(Conexant CX20551 0x103c30b2)
Date: Wed, 11 Mar 2009 22:22:39 +0100
Message-ID: <200903112222.40445.gregorio.guidi@gmail.com>
References: <200903082119.41670.gregorio.guidi@gmail.com>
	<200903092019.36312.gregorio.guidi@gmail.com>
	<s5hmybtigal.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay2.tre.it (mail.tre.it [62.13.171.46])
	by alsa0.perex.cz (Postfix) with ESMTP id 047971038A2
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 22:22:52 +0100 (CET)
In-Reply-To: <s5hmybtigal.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 10 March 2009 15:49:38 Takashi Iwai wrote:
> At Mon, 9 Mar 2009 20:19:35 +0100,
>
> ...
>
> Thanks, that helps for debugging.
>
> Looking through the current patch_conexant.c, there are other messy
> codes there, too.  So I cleaned up and fixed it on sound git tree
> now.  Any chance to try it out?  The GIT tree is found at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

I managed to test a kernel snapshot with the latest changes, thanks for taking 
the time to refactor and clean up the code there.
There are still issues, though: at the moment, the "Speaker" control does not 
work. Consequently, automute does not work and Master only controls 
headphones.

I think there is a problem with this changeset:
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=commitdiff;h=5b3a7440cbabdda07cfb3dcf4a07e0115a3dff9a

Specifically, I had to revert part of that patch to get all the functionality 
back. The bits I reverted are in the patch at the end of the mail.

It looks like these two lines:
	static hda_nid_t cxt5047_dac_nids[2] = { 0x10, 0x1c };
	...
	{0x1d, AC_VERB_SET_CONNECT_SEL, 0x0}

are needed to have a working "Speaker" control, you probably know better than 
me what it means. 
I also readded the "PCM-2" lines. While not strictly necessary, if they are 
not there the speaker volume is stuck at a very low level and cannot be 
raised, as if the PCM-2 volume starts at a low value at boot. Actually, if I 
recall correctly the low speaker volume was a problem in early versions of the 
driver and the "PCM-2" controls were introduced for that reason.
But obviously if there is a way to avoid the widget 0x1c and have a working 
"Speaker" control that would be best.

Hope this makes some sense to you.

Gregorio

--- patch_conexant.c.orig       2009-03-11 22:02:44.000000000 +0100
+++ patch_conexant.c    2009-03-11 22:03:09.000000000 +0100
@@ -1165,7 +1165,7 @@
 /* Conexant 5047 specific */
 #define CXT5047_SPDIF_OUT      0x11

-static hda_nid_t cxt5047_dac_nids[1] = { 0x10 }; /* 0x1c */
+static hda_nid_t cxt5047_dac_nids[2] = { 0x10, 0x1c };
 static hda_nid_t cxt5047_adc_nids[1] = { 0x12 };
 static hda_nid_t cxt5047_capsrc_nids[1] = { 0x1a };

@@ -1263,6 +1263,8 @@
        HDA_CODEC_MUTE("Capture Switch", 0x12, 0x03, HDA_INPUT),
        HDA_CODEC_VOLUME("PCM Volume", 0x10, 0x00, HDA_OUTPUT),
        HDA_CODEC_MUTE("PCM Switch", 0x10, 0x00, HDA_OUTPUT),
+       HDA_CODEC_VOLUME("PCM-2 Volume", 0x1c, 0x00, HDA_OUTPUT),
+       HDA_CODEC_MUTE("PCM-2 Switch", 0x1c, 0x00, HDA_OUTPUT),
        {
                .iface = SNDRV_CTL_ELEM_IFACE_MIXER,
                .name = "Master Playback Switch",
@@ -1294,7 +1296,7 @@
        /* HP, Speaker  */
        {0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP },
        {0x13, AC_VERB_SET_CONNECT_SEL, 0x0}, /* mixer(0x19) */
-       {0x1d, AC_VERB_SET_CONNECT_SEL, 0x1}, /* mixer(0x19) */
+       {0x1d, AC_VERB_SET_CONNECT_SEL, 0x0}, /* mixer(0x19) */
        /* Record selector: Mic */
        {0x12, AC_VERB_SET_CONNECT_SEL,0x03},
        {0x19, AC_VERB_SET_AMP_GAIN_MUTE,
