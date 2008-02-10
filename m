From: "M G" <lists.mg@googlemail.com>
Subject: Re: snd-hda-intel: Fix volume-wheel and microphone on
	Fujitsu-Siemens Amilo M3438G
Date: Sun, 10 Feb 2008 19:48:34 +0100
Message-ID: <74d457500802101048t2b92cb98qe6290a0186a00585@mail.gmail.com>
References: <74d457500802060814j64532e95v8c689cbb491c6b46@mail.gmail.com>
	<s5hir12kpne.wl%tiwai@suse.de>
	<74d457500802061502m31d412dap15009aad087b1b75@mail.gmail.com>
	<s5h8x1vy87l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BED7103820
	for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2008 19:48:36 +0100 (CET)
Received: by py-out-1112.google.com with SMTP id w49so6145580pyg.36
	for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2008 10:48:34 -0800 (PST)
In-Reply-To: <s5h8x1vy87l.wl%tiwai@suse.de>
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

Connecting a headphone automatically mutes the speakers; it has always
been this way.

The effects of your patch are the same as with mine, i.e. good.

I think this might also need to be changed then?
--- a/pci/hda/patch_realtek.c	Fri Feb 08 12:45:40 2008 +0100
+++ b/pci/hda/patch_realtek.c	Sun Feb 10 18:49:57 2008 +0100
@@ -1320,8 +1320,8 @@ static struct snd_kcontrol_new alc880_f1
 	HDA_BIND_MUTE("Speaker Playback Switch", 0x0d, 2, HDA_INPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
