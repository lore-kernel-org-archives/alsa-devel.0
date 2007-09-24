From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: race conditions in alsa core
Date: Mon, 24 Sep 2007 10:54:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709241049570.22501@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0709221715360.22501@shell2.speakeasy.net>
	<20070924183033.1045b7c2.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.sea5.speakeasy.net (mail1.sea5.speakeasy.net
	[69.17.117.3]) by alsa0.perex.cz (Postfix) with ESMTP id ECA13103843
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Sep 2007 19:54:37 +0200 (CEST)
In-Reply-To: <20070924183033.1045b7c2.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Sep 2007, Krzysztof Helt wrote:
> On Sun, 23 Sep 2007 03:14:47 -0700 (PDT)
> Trent Piepho <xyzzy@speakeasy.org> wrote:
>
> > My test program will call the HW_PARAMS ioctl twice from different threads
> > running at the same time.  The first call will ask for the maximum number of
> > periods with minimum size, the second call for the minimum number of periods
> > of maximum size.
> >
>
> I cannot compile your test_hwparams.c. The local.h is missing.

You must have the alsa-lib source to compile it, that is where local.h
comes from.  Headers for using the alsa devices directly aren't provided
from any other place.

gcc -I /path/to/alsa-lib/include -pthread test_hwparams.c
