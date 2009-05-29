From: Cameron Stone <camerons.lists@cse.unsw.edu.au>
Subject: Re: Increasing maximum sampling frequency?
Date: Fri, 29 May 2009 12:58:18 +1000
Message-ID: <4A1F4F4A.508@cse.unsw.edu.au>
References: <4A1DED36.4030008@cse.unsw.edu.au>
	<75b66ecd0905271934m7299c4x43be0b79af24300d@mail.gmail.com>
	<4A1E34BC.1070505@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from note.orchestra.cse.unsw.EDU.AU (note.orchestra.cse.unsw.EDU.AU
	[129.94.242.24]) by alsa0.perex.cz (Postfix) with ESMTP id C707A24156
	for <alsa-devel@alsa-project.org>;
	Fri, 29 May 2009 04:58:42 +0200 (CEST)
In-Reply-To: <4A1E34BC.1070505@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
>> $ aplay -r 256 test.wav
>> Playing WAVE 'test.wav' : Unsigned 8 bit, Rate 256000 Hz, Mono
>> Warning: rate is not accurate (requested = 256000Hz, got = 192000Hz)
> 
> The automatic sample rate converter never uses a frequency higher than
> 192 kHz.
> 
> This maximum frequency is defined in alsa-lib/include/pcm_plugin.h, but
> you cannot change it without changing LINEAR_DIV and the algorithm in
> alsa-lib/src/pcm_pcm_rate_linear.c.
> 
> Try resampling the .wav file before with sox.

This works. Likewise, playing with "/usr/bin/play" from the sox toolkit
also works fine.

It seems that the only limiting going on is during playback, so I'm not
terribly worried by this, as we're going to be looking at and processing
 these samples, not trying to listen to them. Humans can't hear above
20kHz anyway, right?

Thanks to everyone for their help on this.

Cameron.
