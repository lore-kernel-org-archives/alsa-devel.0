From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: race conditions in alsa core
Date: Mon, 24 Sep 2007 18:30:33 +0200
Message-ID: <20070924183033.1045b7c2.krzysztof.h1@poczta.fm>
References: <Pine.LNX.4.58.0709221715360.22501@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.poczta.interia.pl (smtp35.poczta.interia.pl [80.48.65.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 348AB103843
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Sep 2007 18:22:36 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.58.0709221715360.22501@shell2.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 23 Sep 2007 03:14:47 -0700 (PDT)
Trent Piepho <xyzzy@speakeasy.org> wrote:

> My test program will call the HW_PARAMS ioctl twice from different threads
> running at the same time.  The first call will ask for the maximum number of
> periods with minimum size, the second call for the minimum number of periods
> of maximum size.
> 

I cannot compile your test_hwparams.c. The local.h is missing.

Regards,
Krzysztof


----------------------------------------------------------------------
Zaaresztuj ministra Koszmarka!
http://link.interia.pl/f1ba6
