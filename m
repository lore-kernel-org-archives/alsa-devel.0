From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Increasing maximum sampling frequency?
Date: Thu, 28 May 2009 08:52:44 +0200
Message-ID: <4A1E34BC.1070505@ladisch.de>
References: <4A1DED36.4030008@cse.unsw.edu.au>
	<75b66ecd0905271934m7299c4x43be0b79af24300d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B0A841037EA
	for <alsa-devel@alsa-project.org>;
	Thu, 28 May 2009 08:52:37 +0200 (CEST)
In-Reply-To: <75b66ecd0905271934m7299c4x43be0b79af24300d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org, Cameron Stone <camerons.lists@cse.unsw.edu.au>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Wed, May 27, 2009 at 9:47 PM, Cameron Stone
> <camerons.lists@cse.unsw.edu.au> wrote:
> > I've got a USB microphone application that I want to sample at 256000 8
> > bit samples per second so I can listen to bats. I know that my device
> > can get close to that rate, but alsa seems to restrict sampling rates to
> > 192kHz.
> > 
> > Is it possible to push the maximum sampling frequency higher? If so,
> > where should I start looking?
> 
> For starters, try adding a 256K sample rate to include/sound/pcm.h:
> and sound/core/pcm_native.c:

This is not necessary; drivers can define whatever sample rate they
want.  1,792,000 Hz works just fine with the Bt878 driver.

> $ arecord -v -Dplughw:1,0 test.wav -d 1 -r 256
> Recording WAVE 'test.wav' : Unsigned 8 bit, Rate 256000 Hz, Mono
> ...
> Slave: Hardware PCM card 1 '8-Mic AVR Adaptor' device 0 subdevice 0
> Its setup is:
> ...
>   rate         : 256000

This indicates that the record PCM stream _does_ use the correct rate.

> $ aplay -r 256 test.wav
> Playing WAVE 'test.wav' : Unsigned 8 bit, Rate 256000 Hz, Mono
> Warning: rate is not accurate (requested = 256000Hz, got = 192000Hz)

The automatic sample rate converter never uses a frequency higher than
192 kHz.

This maximum frequency is defined in alsa-lib/include/pcm_plugin.h, but
you cannot change it without changing LINEAR_DIV and the algorithm in
alsa-lib/src/pcm_pcm_rate_linear.c.

Try resampling the .wav file before with sox.


Best regards,
Clemens
