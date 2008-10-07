From: ext-jukka.hynninen@vaisala.com
Subject: Re: ASoC WM8510 Mic PGA problem
Date: Tue, 7 Oct 2008 17:21:48 +0300
Message-ID: <B9D3C48C98930741A166756A50C44A610F17B55E@helx1.corp.vaisala.com>
References: <B9D3C48C98930741A166756A50C44A610F17B555@helx1.corp.vaisala.com>
	<20081003133936.GD26035@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B556@helx1.corp.vaisala.com>
	<20081006100522.GB14087@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B55A@helx1.corp.vaisala.com>
	<20081007121144.GA5119@rakim.wolfsonmicro.main>
	<B9D3C48C98930741A166756A50C44A610F17B55D@helx1.corp.vaisala.com>
	<20081007134318.GF19835@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw.vaisala.com (mailgw.vaisala.com [192.81.123.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 8063F245DB
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 16:22:03 +0200 (CEST)
Received: from helsrv02.vaisala.com (helsrv02.vaisala.com [192.81.123.16])
	by mailgw.vaisala.com (8.13.6/8.13.6) with SMTP id m97ELnZV016858
	for <alsa-devel@alsa-project.org>; Tue, 7 Oct 2008 17:21:49 +0300
Content-class: urn:content-classes:message
In-Reply-To: <20081007134318.GF19835@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Quoting Mark Brown:

> Could you please rebuild ASoC with debug enabled and send the kernel
> output produced from a failing record?  Depending on your kernel
version

I'm sorry, It seems to be the switch connecting MICN to negative PGA
terminal that does not stay on (register 0x2c bit 1)

Here's the result with my remarks inline:

>$ amixer sget 'Mic PGA'
Simple mixer control 'Mic PGA',0
  Capabilities: switch
  Playback channels: Mono
  Capture channels: Mono
  Mono: [on]
>$ arecord -c 1 --rate=48000 --format=S16_LE |aplay
asoc: WM8510 HiFi <-> at91-ssc1 info:
asoc: rate mask 0xde
asoc: min ch 1 max ch 2
asoc: min rate 8000 max rate 48000
asoc: WM8510 HiFi <-> at91-ssc1 info:
asoc: rate mask 0xde
asoc: min ch 1 max ch 2
asoc: min rate 8000 max rate 48000
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz,
Mono
WM8510 register write: 0x04: 10
WM8510 register write: 0x06: d
WM8510 register write: 0x06: d
WM8510 register write: 0x24: 8
WM8510 register write: 0x25: c
WM8510 register write: 0x26: 93
WM8510 register write: 0x27: e9
WM8510 register write: 0x01: 3a
WM8510 register write: 0x06: 10d
WM8510 register write: 0x06: d
WM8510 register write: 0x04: 10
WM8510 register write: 0x07: 0
WM8510 register write: 0x01: 39
WM8510 register write: 0x02: 10
WM8510 register write: 0x02: 14
WM8510 register write: 0x2c: 2  <-- This line missing right after
bootup!
WM8510 register write: 0x02: 15
WM8510 register write: 0x01: 39
WM8510 register write: 0x0a: 0
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
WM8510 register write: 0x04: 10
WM8510 register write: 0x06: d
WM8510 register write: 0x06: d
WM8510 register write: 0x24: 8
WM8510 register write: 0x25: c
WM8510 register write: 0x26: 93
WM8510 register write: 0x27: e9
WM8510 register write: 0x01: 39
WM8510 register write: 0x06: 10d
WM8510 register write: 0x06: d
WM8510 register write: 0x04: 10
WM8510 register write: 0x07: 0
WM8510 register write: 0x03: 1
WM8510 register write: 0x03: 9
WM8510 register write: 0x03: d
WM8510 register write: 0x03: 8d
WM8510 register write: 0x03: cd
WM8510 register write: 0x03: ed
WM8510 register write: 0x0a: 0
Aborted by signal Interrupt... <-- Pressed ctrl-c
WM8510 register write: 0x02: 14
WM8510 register write: 0x02: 10
WM8510 register write: 0x02: 0
WM8510 register write: 0x01: 29
Aborted by signal Interrupt...
>$ pop wq checking: Playback status: inactive waiting: yes
pop wq D1 WM8510 Playback
WM8510 register write: 0x01: 29
WM8510 register write: 0x03: 6d
WM8510 register write: 0x03: 2d
WM8510 register write: 0x03: d
WM8510 register write: 0x03: 5
WM8510 register write: 0x03: 1
WM8510 register write: 0x03: 0
pop wq D3 WM8510 Playback
WM8510 register write: 0x01: 3a
>$
