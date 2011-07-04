From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: model needed for Clevo P150HM (Realtek ALC892)
Date: Tue, 05 Jul 2011 00:50:43 +0200
Message-ID: <4E1243C3.5040302@gmail.com>
References: <itumu8$r5k$1@dough.gmane.org>
	<s5h39j0zpnc.wl%tiwai@suse.de>	<4E036C8F.3080709@gmail.com>
	<s5hvcvvzkzq.wl%tiwai@suse.de>	<s5hk4cbzj6s.wl%tiwai@suse.de>
	<4E047441.4010003@gmail.com>	<s5hpqm2v0zq.wl%tiwai@suse.de>
	<4E05C1B1.50302@gmail.com>	<4E05C704.4080806@gmail.com>
	<4E05CE02.1070801@gmail.com>	<s5hei2fvmgw.wl%tiwai@suse.de>
	<4E082166.5060902@gmail.com>	<s5hpqlz3a3b.wl%tiwai@suse.de>
	<s5hhb7b315l.wl%tiwai@suse.de>	<4E08E33D.3060608@gmail.com>
	<s5htybaton8.wl%tiwai@suse.de>	<4E0B62B6.6000007@gmail.com>
	<4E0B6BE0.1010003@gmail.com>	<4E0B7D22.3040009@gmail.com>
	<s5hei2bsxdv.wl%tiwai@suse.de>	<4E0C17F2.5070704@gmail.com>
	<s5hzkkzreqr.wl%tiwai@suse.de>	<4E0CABBC.3070801@gmail.com>
	<s5hwrg3i5eb.wl%tiwai@suse.de>	<4E0CBBED.9050501@gmail.com>
	<s5hsjqri0eo.wl%tiwai@suse.de>	<4E0CD984.9050408@gmail.com>
	<s5hpqluinj5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50]) by alsa0.perex.cz (Postfix) with ESMTP id 3E7C92439E
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 00:50:49 +0200 (CEST)
Received: by fxh2 with SMTP id 2so5972835fxh.9
	for <alsa-devel@alsa-project.org>; Mon, 04 Jul 2011 15:50:47 -0700 (PDT)
In-Reply-To: <s5hpqluinj5.wl%tiwai@suse.de>
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

W dniu 01.07.2011 07:21, Takashi Iwai pisze:
> It's a BIOS bug.  It doesn't tell SPDIF is available.
> Ditto for the 4th stereo out.  No pin is exposed by BIOS.
> 
> 
> thanks,
> 
> Takashi
I finally managed to figure out what these numbers mean. But then I got
confused by your statement:

$ cat /sys/class/sound/card0/hwC0D0/init_pin_configs
0x11 0x411111f0
0x12 0x411111f0
0x14 0x99130110
0x15 0x411111f0
0x16 0x411111f0
0x17 0x411111f0
0x18 0x01a11c30
0x19 0x99a30931
0x1a 0x0181143f
0x1b 0x0121101f
0x1c 0x411111f0
0x1d 0x598301f0
0x1e 0x01451120
0x1f 0x411111f0

>From what I was able to decipher, 0x1e is a jack, external rear, with
spdif out default output and optical connection. It is black. The same
physical socket is used for the last 2 surround channels. Could you
please clarify? Thanks in advance.

Julian
