From: Matej Laitl <strohel@gmail.com>
Subject: Re: [ALSA] HDA: no sound in headphone-out caused by
	commit f889fa91ad47e (2.6.25-rc1 regression)
Date: Wed, 13 Feb 2008 16:00:21 +0100
Message-ID: <200802131600.21841.strohel@gmail.com>
References: <200802112158.41989.strohel@gmail.com>
	<200802131305.48471.strohel@gmail.com>
	<s5h63wtt38z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D3B324398
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2008 16:00:27 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id q2so1055212uge.50
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2008 07:00:26 -0800 (PST)
In-Reply-To: <s5h63wtt38z.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 13 of February 2008 14:06:20 Takashi Iwai wrote:
> > This patch did not have any effect. (i haven't tested suspend-to-ram)
> >
> > alsa-info before powersaving (speaker silent, mixer says: Speaker=3DMM):
> > http://pastebin.ca/902330
> >
> > alsa-info after powersaving (speaker loud, mixer says: Speaker=3DMM):
> > http://pastebin.ca/902332
>
> Oh, it's my thinko. =A0The init routine shouldn't update the amp cache.
>
> The patch below should fix this problem. =A0Actually it reverts the code
> to my first patch.

Eh, this one wasn't successful. The symptoms are the same, and the diff =

between alsa-info before and after powersaving remained also the same:
--- alsa-info.1.txt     2008-02-13 15:56:18.000000000 +0100
+++ alsa-info.2.txt     2008-02-13 15:58:15.000000000 +0100
@@ -3,7 +3,7 @@
 !!ALSA Information Script v 0.4.36
 !!################################

-!!Script ran on: St =FAno 13 15:56:18 CET 2008
+!!Script ran on: St =FAno 13 15:58:14 CET 2008


 !!Linux Distribution
@@ -200,7 +200,7 @@
   Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
-  Amp-Out vals:  [0x80 0x80]
+  Amp-Out vals:  [0x00 0x00]
   Pincap 0x083e: IN OUT HP Detect Trigger
   Pin Default 0x99130120: [Fixed] Speaker at Int ATAPI
     Conn =3D ATAPI, Color =3D Unknown
@@ -356,7 +356,7 @@

 crw-rw---- 1 root audio 116,  0 2008-02-13 15:48 /dev/snd/controlC0
 crw-rw---- 1 root audio 116, 24 2008-02-13 15:48 /dev/snd/pcmC0D0c
-crw-rw---- 1 root audio 116, 16 2008-02-13 15:55 /dev/snd/pcmC0D0p
+crw-rw---- 1 root audio 116, 16 2008-02-13 15:58 /dev/snd/pcmC0D0p
 crw-rw---- 1 root audio 116, 30 2008-02-13 15:48 /dev/snd/pcmC0D6c
 crw-rw---- 1 root audio 116, 22 2008-02-13 15:48 /dev/snd/pcmC0D6p
 crw-rw---- 1 root audio 116,  1 2008-02-13 15:49 /dev/snd/seq
