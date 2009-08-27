From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH 1/1] sound: usb-audio: support for
	Digidesign Mbox 2
Date: Thu, 27 Aug 2009 13:16:51 +1000
Message-ID: <98ec50f0908262016p53c17e32nebde7b1bbab44bfa@mail.gmail.com>
References: <4A8EBB35.2010604@gmail.com> <4A92B95E.9090905@ladisch.de>
	<98ec50f0908261822m3d5bb75aw347c858efef7c8cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com
	[209.85.219.220])
	by alsa0.perex.cz (Postfix) with ESMTP id ECCCB24483
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Aug 2009 05:16:51 +0200 (CEST)
Received: by ewy20 with SMTP id 20so841778ewy.46
	for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2009 20:16:51 -0700 (PDT)
In-Reply-To: <98ec50f0908261822m3d5bb75aw347c858efef7c8cc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Digidesign Mbox 2:
(altsettings & magic codes)
----------------------------

Analogue I/O: 	
Altsettings:
	2:3 (0x03), playback 	- no sr control in desc
	4:3 (0x85), capture @ 44.1/48
	5:3 (0x86), capture @ 44.1/48 ---- spdif ext clock?

Analogue I/O with S/PDIF external clock:
Altsettings:
	? - spdif light flashes in windows
	
S/PDIF I/O:
Altsettings:
	2:2 (0x03), playback 	- no sr control in desc
				- spdif light flashes in linux
	4:2 (0x85), capture  	- no sr control in desc
				- spdif light flashes in linux
		
IEC1937_AC3:
	3:6 (0x04), playback @ 44.1/48

Bit & Sample rate modes:
(Hex commands)
- All of these modes are definitely available on the Analogue altsettings
- Digidesign website claims SPDIF is capable of 24 bit samples,
  assume all modes are available on SPDIF altsettings.

44/16

22 01 00 01 03 00 03 00
44 ac 00

22 01 00 01 85 00 03 00
44 ac 00

22 01 00 01 86 00 03 00
44 ac 00


48/16

22 01 00 01 03 00 03 00
80 bb 00

22 01 00 01 85 00 03 00
80 bb 00

22 01 00 01 86 00 03 00
80 bb 00


44/24

a2 81 00 01 03 00 03 00
44 ac 00

a2 81 00 01 85 00 03 00
44 ac 00

a2 81 00 01 86 00 03 00
44 ac 00


48/24

a2 81 00 01 03 00 03 00
80 bb 00

a2 81 00 01 85 00 03 00
80 bb 00

a2 81 00 01 86 00 03 00
80 bb 00
