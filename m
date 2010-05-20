From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: First 50 milliseconds of audio clipping with dmix
Date: Thu, 20 May 2010 08:55:03 +0300
Message-ID: <20100520085503.2f34ba75.jhnikula@gmail.com>
References: <FB2A216B-BAA3-4E07-828A-218F9855D418@taser.com>
	<AANLkTineIe45MEv8juotPw_wOaDu79islnJeplkgj42I@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.144])
	by alsa0.perex.cz (Postfix) with ESMTP id A07941038F9
	for <alsa-devel@alsa-project.org>;
	Thu, 20 May 2010 07:54:59 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 5so75426eyb.16
	for <alsa-devel@alsa-project.org>; Wed, 19 May 2010 22:54:59 -0700 (PDT)
In-Reply-To: <AANLkTineIe45MEv8juotPw_wOaDu79islnJeplkgj42I@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 20 May 2010 12:04:06 +0800
Raymond Yau <superquad.vortex2@gmail.com> wrote:

> 2010/5/20 Tyler Conant <tconant@taser.com>
> 
> > I'm trying to use dmix on an OMAP processor. I'm experiencing the first 50
> > ms of the sample getting clipped. When I aplay directly to the hw:0 I don't
> > get the clipping. The difference I see between the alsa configuration
> > between dmix and hw:0 is the start_threshold, stop_threshold and
> > silence_size. When it's direct to hw:0 the start and stop threshold are
> > equal to the buffer size. For dmix the start threshold is 1 and the stop
> > threshold is 1445199872. Is this dmix which is setting the start and stop or
> > is this aplay. I'm only guessing this is the reason why the first part is
> > clipping. The only bug which seem similar is
> > http://bugs.gentoo.org/show_bug.cgi?id=218641 and it's already been closed
> > out. I'm using alsa lib 1.0.23
> >
...
> >
> The major difference is  access       : MMAP_INTERLEAVED
>
I think I hear the same problem with OMAP3 BeagleBoard. These play fine:

aplay -D hw:0 48k_1kHz0dB100ms.wav
aplay -D hw:0 -M 48k_1kHz0dB100ms.wav

But with this there is some crack etc. if played after playing directly
to HW device:

aplay -D dmix 48k_1kHz0dB100ms.wav

But I don't hear this crack sound if repeating the command above.
Problem appears only when playing to dmix after playing to HW device.

And no, ASoC DAPM is not explaining this. Time between the commands
doesn't have any other effect than power up/-down pops.


-- 
Jarkko
