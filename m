From: Christian Esken <esken@kde.org>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Mon, 24 Aug 2009 21:43:20 +0200
Message-ID: <200908242143.20046.esken@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42]) by alsa0.perex.cz (Postfix) with ESMTP id A2D7B244B5
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Aug 2009 21:43:07 +0200 (CEST)
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net
	[151.189.8.13]) by mx.arcor.de (Postfix) with ESMTP id DD08F3FE3B0
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Aug 2009 21:43:06 +0200 (CEST)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net
	[151.189.21.54])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id D5D1D2BF81B
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Aug 2009 21:43:06 +0200 (CEST)
Received: from firefly.localnet (dslb-092-072-198-176.pools.arcor-ip.net
	[92.72.198.176])
	by mail-in-14.arcor-online.net (Postfix) with ESMTPS id 4882028B023
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Aug 2009 21:43:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 05 August 2009 23:21:53 Christian Esken wrote:

> > All in all, I can produce a working environment with recent 32 and 64 bit
> > kernels. This is good news.  :-)
> >
> > Below is the summary on the tested distributions.
> >
> >   Christian
> >
> >
> > So we got this:
> > Kubuntu Karmic Alpha-2 32 Bit, 2.6.30 (works)
> > Kubuntu Karmic Alpha-2 64 Bit, 2.6.30 (works)
> > SuSE 11.1 64 Bit,  2.6.27 (does not work)
> > SuSE 11.1 64 Bit,  2.6.27 XEN (does not work)
> > SuSE 11.2 Milestone3  64Bit, 2.6.30 (test canceled, due to unrelated
> > problems) => I'll see whether I can redo the SuSE11.2 tests, after doing
> > a bugreport at openSuSE.
OK, that last issue was solved, and I now redid the test:

SuSE 11.2 Milestone6 64Bit, 2.6.31-rc6   (works)

I succesfully tested all analog (5.1) channels, using: speaker-test -D 
surround51 -c 6

I used ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-
driver-snapshot.tar.bz2 from 24.08.2009. I am just wondering, whether the new 
ALSA driver is it still planned for the 2.6.31 kernel?!?

  Christian
