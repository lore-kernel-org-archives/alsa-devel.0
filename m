From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: hdsp multiface.
Date: Wed, 2 Jul 2003 10:25:58 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGOEEICKAB.mknecht@controlnet.com>
References: <3F02D644.4070106@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vivaldi.controlnet.com (hidden-user@mail.controlnet.com [199.108.40.159])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA06211
	for <alsa-devel@alsa-project.org>; Wed, 2 Jul 2003 19:26:12 +0200
In-Reply-To: <3F02D644.4070106@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Card 1 : RME Hammerfall DSP (Multiface) at 0xe9000000, irq 11
> Upload firmware for card hw:1
> Error opening hwdep device on card hw:1.
>
> Either way I still get this message from aplay:
>
> aplay -f cd -D hw:1,0 /art/1REC/020403-studio.wav
> Playing WAVE '/art/1REC/020403-studio.wav' : Signed 16 bit Little
> Endian, Rate 44100 Hz, Stereo
> aplay: set_params:800: Access type not available
>

Partick,

Sorry for butting in...

Is this similar to the problems Jesse Chappell was having? If so, his
'solution' ;-) was to boot Windows to get the firmware loaded, and then to
warm boot into Linux to actually use the card.

- Mark




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
