From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: model needed for Clevo P150HM (Realtek ALC892)
Date: Mon, 18 Jul 2011 13:15:14 +0200
Message-ID: <4E2415C2.8020600@gmail.com>
References: <itumu8$r5k$1@dough.gmane.org> <s5hk4cbzj6s.wl%tiwai@suse.de>
	<4E047441.4010003@gmail.com> <s5hpqm2v0zq.wl%tiwai@suse.de>
	<4E05C1B1.50302@gmail.com> <4E05C704.4080806@gmail.com>
	<4E05CE02.1070801@gmail.com> <s5hei2fvmgw.wl%tiwai@suse.de>
	<4E082166.5060902@gmail.com> <s5hpqlz3a3b.wl%tiwai@suse.de>
	<s5hhb7b315l.wl%tiwai@suse.de> <4E08E33D.3060608@gmail.com>
	<s5htybaton8.wl%tiwai@suse.de> <4E0B62B6.6000007@gmail.com>
	<4E0B6BE0.1010003@gmail.com> <4E0B7D22.3040009@gmail.com>
	<s5hei2bsxdv.wl%tiwai@suse.de> <4E0C17F2.5070704@gmail.com>
	<s5hzkkzreqr.wl%tiwai@suse.de> <4E0CABBC.3070801@gmail.com>
	<s5hwrg3i5eb.wl%tiwai@suse.de> <4E0CBBED.9050501@gmail.com>
	<s5hsjqri0eo.wl%tiwai@suse.de> <4E0CD984.9050408@gmail.com>
	<s5hpqluinj5.wl%tiwai@suse.de> <4E1243C3.5040302@gmail.com>
	<CAN8cciZX_Fzm5ZOR+aZ5BXpEw89Nmk6WqTs3VOTbo1jwQuRyuA@mail.gmail.com>
	<4E22CDC0.6090007@gmail.com> <4E22D2D2.4040208@gmail.com>
	<s5hei1o59dm.wl%tiwai@suse.de> <s5haacckm1k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020404070604040707060103"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50]) by alsa0.perex.cz (Postfix) with ESMTP id 3339B24476
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jul 2011 13:15:19 +0200 (CEST)
Received: by fxh2 with SMTP id 2so6388330fxh.9
	for <alsa-devel@alsa-project.org>; Mon, 18 Jul 2011 04:15:19 -0700 (PDT)
In-Reply-To: <s5haacckm1k.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------020404070604040707060103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

W dniu 18.07.2011 10:52, Takashi Iwai pisze:
> And I can't reproduce your problem with the alsa-info.sh output above.
> Give more exact information what you did and what is the problem.
>
>
> thanks,
>
> Takashi
I'm sorry for the confusion - let me sum up the current situation. With 
the fixes you pushed to sound-2.6/master I was able to get 5.1 sound out 
of my laptop. The only missing bit was the 7.1 sound. And the last 
channel goes via a jack/optical spdif hybrid. The problem is that the 
BIOS does not announce that and as such alsa is unaware of the side 
surround channel.
Using Raymond's advice, I was able to make the sound come out of the 
last jack, by changing some values for pin 0x17 (described as sidesurr 
in the datasheet), diff is attached. I basically checked what was the 
difference in alsa-info.sh output when I was changing number of channels 
with alsamixer, and then did the same for pin 0x17.
Since, from what I understood, you wanted me to figure out which pin is 
connected to the last jack [1], I thought this information would be 
useful to fix BIOS shortcomings.
Other problem is that the volume on that jack is controlled by center 
and lfe sliders (in alsamixer), which is probably caused by the fact 
that alsa is unaware of the 7.1 sound.
If more information is needed, please let me know what do you need in 
addition to alsa-info.sh output.

Regards,
Julian

[1] http://article.gmane.org/gmane.linux.alsa.devel/86749

--------------020404070604040707060103
Content-Type: text/x-patch;
 name="hda-analyze.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hda-analyze.diff"

Diff for codec 0/0 (0x10ec0892):
--- 
+++ 
@@ -223,23 +223,23 @@
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=0x00, enabled=0
   Power: setting=D0, actual=D0
   Connection: 1
      0x0e
 Node 0x17 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
-  Amp-Out vals: [0x00 0x00]
+  Amp-Out vals: [0x80 0x80]
   Pincap 0x00000036: IN OUT Detect Trigger
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
-  Pin-ctls: 0x40: OUT
+  Pin-ctls: 0x20: IN
   Unsolicited: tag=0x00, enabled=0
   Power: setting=D0, actual=D0
   Connection: 1
      0x0f
 Node 0x18 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
   Control: name="Center Playback Switch", index=0, device=0
     ControlAmp: chs=1, dir=1, idx=0, ofs=0
   Control: name="LFE Playback Switch", index=0, device=0

--------------020404070604040707060103
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020404070604040707060103--
