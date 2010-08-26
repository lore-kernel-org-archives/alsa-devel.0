From: David Santamauro <david.santamauro@gmail.com>
Subject: Re: ice1712 and the delta 1010
Date: Thu, 26 Aug 2010 12:22:55 -0400
Message-ID: <20100826122255.33e18696@debussy>
References: <20100826065854.519ee1d3@debussy> <4C7665CC.5080302@ladisch.de>
	<20100826092713.3debd6c1@debussy> <4C768064.5050207@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6C66324962
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 18:26:07 +0200 (CEST)
Received: by qwj9 with SMTP id 9so1793813qwj.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2010 09:26:06 -0700 (PDT)
In-Reply-To: <4C768064.5050207@ladisch.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 26 Aug 2010 16:55:32 +0200
Clemens Ladisch <clemens@ladisch.de> wrote:

> > > If yes, then it's possible that the 32-bit and 64-bit kernels
> > > configure the PC differently; for example, there might be noise on
> > > the power line due to a different kind of power management.  
> > 
> > another interesting angle... I thought it might be power or some
> > kind
> > of internal noise. How could I pursue that further?  
> > 
> > Try running something on all CPU cores so that it doesn't switch
> > into
> > power saving mode.

I wrote a small cpu-hog to exercise all 8 cores. I didn't notice any
difference with the metering on jkmeter. My CPU fans increased speed
though.

Now that I'm thinking about it, wouldn't any type of interference
register under windows as well?

Have there been any other reports of this nature regarding 32 vs 64-bit
anomalies?
