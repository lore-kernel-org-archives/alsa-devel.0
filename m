From: roiman@rambler.ru
Subject: X-Fi Surround 5.1 USB Remote Control LIRC config file
Date: Sun, 15 May 2011 18:36:39 +0600
Message-ID: <20110515183639.21bbc405@amilo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailc.rambler.ru (mailc.rambler.ru [81.19.66.27])
	by alsa0.perex.cz (Postfix) with ESMTP id 72BEC10380A
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 14:41:49 +0200 (CEST)
Received: from amilo (unknown [95.78.131.5])
	(Authenticated sender: roiman@rambler.ru)
	by mailc.rambler.ru (Postfix) with ESMTP id 81D7D2C34B8
	for <alsa-devel@alsa-project.org>; Sun, 15 May 2011 16:41:48 +0400 (MSD)
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

Hi, all.

Here is content of LIRC config file lircd.conf with IR-codes for X-Fi
Surround 5.1 USB remote control.

All buttons (include volume knob) works fine with Alsa driver 1.0.24
and LIRC 0.9.0.

Wiki-page
(http://alsa.opensrc.org/Usb-audio#Creative_USB_X-Fi_Surround_5.1) for
this card presents information about button codes only for volume knob
on this card. Because of this information may be useful, I think.

Thanks, guys, for your work.

Roman.

-----------------------------------------------
-----------------------------------------------
begin remote

	name	X-F.Surround-5.1.Remote.Control
	bits	8
	gap 300000

	begin codes
		knob-mute	0x0d
		knob-vol-	0x0f
		knob-vol+	0x10
		power		0x29
		mute		0x2a
		vol+		0x2b
		vol-		0x2c
		menu-back	0x2d
		display		0x2e
		play-pause	0x2f
		ok		0x30
		up		0x31
		down		0x32
		prev		0x33
		next		0x34
		cmss3d-on	0x37
		cmss3d-off	0x38
		cryst-on	0x39
		cryst-off	0x3a
		shuffle		0x3b
		repeat		0x3c
	end codes

end remote
-----------------------------------------------
-----------------------------------------------
