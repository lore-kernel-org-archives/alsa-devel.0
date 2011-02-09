From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: ALC861-VD bad recording issue
Date: Wed, 9 Feb 2011 14:27:10 +0800
Message-ID: <AANLkTimqH9Rb3PMyp8p9-CH2kfYe710O+bYGbNH9bhAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 80500243E6
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 07:27:12 +0100 (CET)
Received: by ewy19 with SMTP id 19so3203606ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Feb 2011 22:27:11 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> This is the output of the alsa script to ge information about my system
and the driver


http://www.alsa-project.org/db/?f=9871b38d99bdd4cc91e398b60eb31361eb305395

Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Input Source", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00
0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b

if Input source is using [Audio Mixer], the driver may need to unmute
only the seleted source and the other sources may need to be muted
