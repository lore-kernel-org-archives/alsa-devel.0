From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 3 Feb 2009 17:09:14 +0100
Message-ID: <74d0deb30902030809v5c71ccc6j4401599da38696f5@mail.gmail.com>
References: <200901271519.47119.anarsoul@gmail.com>
	<200902031357.12297.anarsoul@gmail.com>
	<20090203120504.GC23827@sirena.org.uk>
	<200902031553.03024.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D5E310384F
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 17:09:15 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so868966ywk.2
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 08:09:14 -0800 (PST)
In-Reply-To: <200902031553.03024.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

2009/2/3 Vasily Khoruzhick <anarsoul@gmail.com>:
> On Tuesday 03 February 2009 14:05:08 Mark Brown wrote:
>
>> Please do.  You should at least include some text in the patch
>> description explaining what you're doing.
>
> One more version of patch, I've fixed patch description, but didn't removed
> FIXME's, just fixed one comment.
>
> Btw, it would be nice to hear Philipp's opinion :)

Yes, that patch is correct - thanks!

The FIXMEs are there because on magician flushing the interpolator
registers only seems to succeed when it is clocked by SYSCLK (see also
the comment in uda1380_mute).
I think this might be because at the time I flush the registers (in
uda1380_pcm_prepare), the SSP link is not yet running.

regards
Philipp
