From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsamixertest
Date: Thu, 21 Oct 2010 12:36:59 +0800
Message-ID: <AANLkTinJnCQvQmQL16-pWBhmaZjW1_nUayHVa-yaC3FO@mail.gmail.com>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
	<4CA0221D.6030208@aknet.ru> <i7qltg$bph$1@dough.gmane.org>
	<AANLkTi=9gcs0A6s55wSS-RP4NucvUqkxCoYynezdF+5g@mail.gmail.com>
	<4CA306CB.1090305@canonical.com>
	<AANLkTi=h+ZKXNdhmC1BtTbBaGF6_V+uD2ZO7sx4WMJMW@mail.gmail.com>
	<4CA9877F.7060009@canonical.com> <4CA9C22A.2010104@ladisch.de>
	<4CA9C7BE.7020804@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 769FF1037FF
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 06:37:05 +0200 (CEST)
Received: by eyz10 with SMTP id 10so1108863eyz.38
	for <alsa-devel@alsa-project.org>; Wed, 20 Oct 2010 21:37:01 -0700 (PDT)
In-Reply-To: <4CA9C7BE.7020804@canonical.com>
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

2010/10/4 David Henningsson <david.henningsson@canonical.com>

>
>
> Exactly, this is a test tool that checks whether the mixer control names
> and dB information live up to PulseAudio's expectations. That's the
> tool's purpose.
>
> What's PulseAudio' s expectation ?

PA 's developer seem expect max_dB of all HDA codec are 0dB

Your alsamixertest program does not test any dB range above 0dB

How does PA handle the mixer control when the dB range of the "Master
Front"  volume control is -34.5dB to +12dB (e.g. vt1708b HDA codec ) is not
live up to PA 's expectation

e.g. No Master Volume Control

http://launchpadlibrarian.net/54333151/Card0.Codecs.codec.0.txt


http://launchpadlibrarian.net/37147347/Card0.Codecs.codec.0.txt

Node 0x16 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
0x00] [0x9f 0x9f] [0x97 0x97]
  Power: setting=D0, actual=D0
  Connection: 7
     0x10 0x1f 0x1a 0x1b 0x1e 0x1d 0x25
