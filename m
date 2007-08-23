From: "Michael Bourgeous" <sts.nitrogen@gmail.com>
Subject: Re: Tascam US-428 USB Problems
Date: Wed, 22 Aug 2007 23:02:55 -0600
Message-ID: <8e4fc8270708222202j3a3098beu8faf4597530d1876@mail.gmail.com>
References: <8e4fc8270708152345k450c8460la0eb17e33d50fdd7@mail.gmail.com>
	<200708161154.49018.fzu@wemgehoertderstaat.de>
	<8e4fc8270708161635v8c164e7j311439c2e2f7d3bd@mail.gmail.com>
	<200708170919.37627.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 802FE10380E
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Aug 2007 07:02:57 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so348685fka
	for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2007 22:02:56 -0700 (PDT)
In-Reply-To: <200708170919.37627.fzu@wemgehoertderstaat.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 8/17/07, Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:
> Am Freitag, 17. August 2007 schrieb Michael Bourgeous:
>
> Try to only disable cpu speed changes.
> You can "preselect" fixed speed by doing i.e.:
>         $ echo 1800000>/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
>         $ echo 1800000>/sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
>         $ echo 1800000>/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
>         $ echo 1800000>/sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
> Is that enough to stabilize things?

Yes, this eliminates the error messages in the kernel log.  The other
big boost in stability came from switching from Ubuntu's jackd 102.20
to jackd 103.0 compiled from source.

> > Still, performance is less than I would expect, with occasional xruns
>
> USB 1.1 transfers happen at 1ms bounderies. Setting 64Frames/period period
> interrupts will happen within 1ms or 2ms distances.

I was not aware of the 1ms granularity for USB interrupts.  Would USB
2.0 or Firewire offer a better granularity?

> I set 128Frames/period, 3periods here.

That seems to be a nice balance for me as well, considering that 64 is
out of the question.  Thanks for the assistance.

Mike Bourgeous
