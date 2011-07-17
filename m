From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: model needed for Clevo P150HM (Realtek ALC892)
Date: Sun, 17 Jul 2011 13:55:44 +0200
Message-ID: <4E22CDC0.6090007@gmail.com>
References: <itumu8$r5k$1@dough.gmane.org> <s5h39j0zpnc.wl%tiwai@suse.de>
	<4E036C8F.3080709@gmail.com> <s5hvcvvzkzq.wl%tiwai@suse.de>
	<s5hk4cbzj6s.wl%tiwai@suse.de> <4E047441.4010003@gmail.com>
	<s5hpqm2v0zq.wl%tiwai@suse.de> <4E05C1B1.50302@gmail.com>
	<4E05C704.4080806@gmail.com> <4E05CE02.1070801@gmail.com>
	<s5hei2fvmgw.wl%tiwai@suse.de> <4E082166.5060902@gmail.com>
	<s5hpqlz3a3b.wl%tiwai@suse.de> <s5hhb7b315l.wl%tiwai@suse.de>
	<4E08E33D.3060608@gmail.com> <s5htybaton8.wl%tiwai@suse.de>
	<4E0B62B6.6000007@gmail.com> <4E0B6BE0.1010003@gmail.com>
	<4E0B7D22.3040009@gmail.com> <s5hei2bsxdv.wl%tiwai@suse.de>
	<4E0C17F2.5070704@gmail.com> <s5hzkkzreqr.wl%tiwai@suse.de>
	<4E0CABBC.3070801@gmail.com> <s5hwrg3i5eb.wl%tiwai@suse.de>
	<4E0CBBED.9050501@gmail.com> <s5hsjqri0eo.wl%tiwai@suse.de>
	<4E0CD984.9050408@gmail.com> <s5hpqluinj5.wl%tiwai@suse.de>
	<4E1243C3.5040302@gmail.com>
	<CAN8cciZX_Fzm5ZOR+aZ5BXpEw89Nmk6WqTs3VOTbo1jwQuRyuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50]) by alsa0.perex.cz (Postfix) with ESMTP id 2A8C624435
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Jul 2011 13:55:48 +0200 (CEST)
Received: by fxh2 with SMTP id 2so5117925fxh.9
	for <alsa-devel@alsa-project.org>; Sun, 17 Jul 2011 04:55:47 -0700 (PDT)
In-Reply-To: <CAN8cciZX_Fzm5ZOR+aZ5BXpEw89Nmk6WqTs3VOTbo1jwQuRyuA@mail.gmail.com>
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

W dniu 05.07.2011 03:31, Raymond Yau pisze:
> 2011/7/5 Julian Sikorski<belegdol@gmail.com>:
>
>>  From what I was able to decipher, 0x1e is a jack, external rear, with
>> spdif out default output and optical connection. It is black. The same
>> physical socket is used for the last 2 surround channels. Could you
>> please clarify? Thanks in advance.
>
> Take a look at Block Diagram of alc892 datasheet
>
> http://www.realtek.com/products/productsView.aspx?Langid=1&PNid=24&PFid=28&Level=5&Conn=4&ProdID=284
>
> if you can confirmed the internal mic, mic jack ,line in , line out
> and internal speaker work as expected
>
> the only pin complex which can be connected to rear [Audio Output] 0x0d is 0x15
>
> seem that the pin complex for 4 jack 8-ch notebook are different from
> desktop with 6 jacks at rear panel
>
> a 10 channel codec is able to provide volume control for internal
> speaker and 4 jacks

Thanks to Raymond's advice I was finally able to make the sound come out 
of the copper part of the spdif/side surround jack. I am pasting the 
diff created with hda-analyzer, please let me know if this gives you 
enough information to add proper 7.1 sound support for this laptop.
Here is the alsa-info.sh with all jacks playing sound:
http://www.alsa-project.org/db/?f=8f23e499727ec612ed925b81d3f38928e8f6aebb
Of course, there is still no specific volume control for the side channel.

Julian

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
-  Amp-Out vals: [0x80 0x80]
+  Amp-Out vals: [0x00 0x00]
    Pincap 0x00000036: IN OUT Detect Trigger
    Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
      Conn = 1/8, Color = Black
      DefAssociation = 0xf, Sequence = 0x0
      Misc = NO_PRESENCE
-  Pin-ctls: 0x20: IN
+  Pin-ctls: 0x40: OUT
    Unsolicited: tag=0x00, enabled=0
    Power: setting=D0, actual=D0
    Connection: 1
       0x0f
  Node 0x18 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
    Control: name="Center Playback Switch", index=0, device=0
      ControlAmp: chs=1, dir=1, idx=0, ofs=0
    Control: name="LFE Playback Switch", index=0, device=
