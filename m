From: Stephan =?iso-8859-1?q?J=E4necke?= <stejae@arcor.de>
Subject: Re: Alsamixer isn't working properly with HDA VIA
	VT82xx with Realtek ALC888 Codec
Date: Mon, 25 May 2009 17:27:12 +0200
Message-ID: <200905251727.13242.stejae@arcor.de>
References: <200901301910.54906.stejae@arcor.de>
	<200904261307.58085.stejae@arcor.de> <s5hocuih151.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RjrGKX/QQwJ9iD4"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-17.arcor-online.net (mail-in-17.arcor-online.net
	[151.189.21.57]) by alsa0.perex.cz (Postfix) with ESMTP id 190D62435C
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 17:27:22 +0200 (CEST)
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net
	[151.189.8.32]) by mx.arcor.de (Postfix) with ESMTP id A8B8E3B24BC
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 17:27:19 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 932AC724B8F
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 17:27:19 +0200 (CEST)
Received: from amd32os110.localnet (p57B76ADE.dip.t-dialin.net
	[87.183.106.222]) (Authenticated sender: stejae@arcor.de)
	by mail-in-05.arcor-online.net (Postfix) with ESMTPSA id 455B3332A6B
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 17:27:19 +0200 (CEST)
In-Reply-To: <s5hocuih151.wl%tiwai@suse.de>
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

--Boundary-00=_RjrGKX/QQwJ9iD4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> After a long time the drivers shipped with Ubuntu 9.04 worked, it suddenly
> died today and pulseaudio just outputed the sound to the null device. So I
> compiled the driver-snapshot again, Takashi gave me, and now it magically
> works including alsamixer.

I'm back at the beginning. *sign*
Neither the ALSA Device nor alsamixer works. Additionally it depends on your 
luck if the OSS device shows up or not.

PS: parts of /var/log/messages are attached.
-- 
Powered by openSUSE 11.0 and KMail 1.11

--Boundary-00=_RjrGKX/QQwJ9iD4
Content-Type: text/plain;
  charset="UTF-8";
  name="messages"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="messages"

May 25 16:59:11 intel32ub904 kernel: [   27.065800] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.067130] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.067169] hda_codec: num_steps = 0 for NID=0xe (ctl = LFE Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.067213] hda_codec: num_steps = 0 for NID=0xf (ctl = Side Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.068396] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.068400] hda_codec: num_steps = 0 for NID=0xe (ctl = LFE Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.068404] hda_codec: num_steps = 0 for NID=0xf (ctl = Side Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.075212] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.075690] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.075695] hda_codec: num_steps = 0 for NID=0xe (ctl = LFE Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.075699] hda_codec: num_steps = 0 for NID=0xf (ctl = Side Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.076424] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.076457] hda_codec: num_steps = 0 for NID=0xe (ctl = LFE Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.076480] hda_codec: num_steps = 0 for NID=0xf (ctl = Side Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.076788] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.076802] hda_codec: num_steps = 0 for NID=0xe (ctl = LFE Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.076807] hda_codec: num_steps = 0 for NID=0xf (ctl = Side Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.096891] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.103955] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.110013] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.117644] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.123343] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.131861] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.137786] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.144951] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.151709] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.159245] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.166439] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.178120] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.185268] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.193483] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.200223] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.207043] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.214600] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.220563] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.227632] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.235366] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.241649] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.247538] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.255060] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.260984] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.267067] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.274915] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.281005] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.288331] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.294797] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.300693] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.308095] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.316277] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.322097] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.329484] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.336886] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.342981] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.350376] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.357327] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.364602] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.490203] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.490752] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.490757] hda_codec: num_steps = 0 for NID=0xe (ctl = LFE Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.490761] hda_codec: num_steps = 0 for NID=0xf (ctl = Side Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.491612] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.491688] hda_codec: num_steps = 0 for NID=0xe (ctl = LFE Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.491750] hda_codec: num_steps = 0 for NID=0xf (ctl = Side Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.492102] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.492113] hda_codec: num_steps = 0 for NID=0xe (ctl = LFE Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.492126] hda_codec: num_steps = 0 for NID=0xf (ctl = Side Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.498826] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.499309] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.499314] hda_codec: num_steps = 0 for NID=0xe (ctl = LFE Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.499318] hda_codec: num_steps = 0 for NID=0xf (ctl = Side Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.500188] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.500233] hda_codec: num_steps = 0 for NID=0xe (ctl = LFE Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.500269] hda_codec: num_steps = 0 for NID=0xf (ctl = Side Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.500553] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.500567] hda_codec: num_steps = 0 for NID=0xe (ctl = LFE Playback Volume)
May 25 16:59:11 intel32ub904 kernel: [   27.500580] hda_codec: num_steps = 0 for NID=0xf (ctl = Side Playback Volume)

May 25 16:59:37 intel32ub904 pulseaudio[3877]: alsa-util.c: Unable to load mixer: Invalid argument
May 25 16:59:37 intel32ub904 kernel: [   53.112306] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)
May 25 16:59:37 intel32ub904 pulseaudio[3877]: alsa-util.c: Unable to load mixer: Invalid argument
May 25 16:59:37 intel32ub904 kernel: [   53.200277] hda_codec: num_steps = 0 for NID=0xe (ctl = Center Playback Volume)

--Boundary-00=_RjrGKX/QQwJ9iD4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_RjrGKX/QQwJ9iD4--
