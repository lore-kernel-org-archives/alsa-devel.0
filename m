From: onlyfever <onlyfever@gmail.com>
Subject: Re: HELP:How to power down TWL5030 Voice/Bluetooth sidetone PGA?
Date: Sat, 11 Jun 2011 11:25:41 +0800
Message-ID: <BANLkTikMO-VYQxauMQ8wh=L4P=VO6SOJ0g@mail.gmail.com>
References: <BANLkTik0mX5wSYNdBwhjxuaKa6908fmazQ@mail.gmail.com>
	<201106101048.45966.peter.ujfalusi@ti.com>
	<BANLkTi=9sg-WL+OXeA4J9rcH7c6zg+R3Pw@mail.gmail.com>
	<201106101716.14008.peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <201106101716.14008.peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> Can you check with:
> amixer | grep -A 6 =A0Loopback
>
Simple mixer control 'Left Digital Loopback',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%] [-99999.99dB]
Simple mixer control 'Left1 Analog Loopback',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Left2 Analog Loopback',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'PreDriv',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
--
Simple mixer control 'Right Digital Loopback',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 7
  Mono: 0 [0%] [-99999.99dB]
Simple mixer control 'Right1 Analog Loopback',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Right2 Analog Loopback',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'TX1',0
  Capabilities: cenum
  Items: 'Analog' 'Digimic0'
--
Simple mixer control 'Voice Analog Loopback',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Voice Digital Loopback',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 41
  Mono: 0 [0%] [-99999.99dB]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
