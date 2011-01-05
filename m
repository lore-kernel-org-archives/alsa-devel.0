From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: soc-cache: Use reg_def_copy
 instead of reg_cache_default
Date: Wed, 5 Jan 2011 23:51:16 +0000
Message-ID: <20110105235115.GB5714@opensource.wolfsonmicro.com>
References: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1291306266-4907-2-git-send-email-dp@opensource.wolfsonmicro.com>
	<AANLkTi=yFRw-c+LeQGEUkKuAGCV+tkEYEpo=q22F0ZUq@mail.gmail.com>
	<20110105230339.GB5476@opensource.wolfsonmicro.com>
	<4D24F9E4.1080704@freescale.com>
	<20110105232947.GA8514@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 97A4924464
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 00:51:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20110105232947.GA8514@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 05, 2011 at 11:29:47PM +0000, Mark Brown wrote:

> > So are you saying that there's a bug in this patch?  Perhaps that code should
> > look like this:

> Perhaps it should, though my immediate question (without looking at the
> existing code again) is why the existing tests are being removed.

Having looked slightly further it does look like something I'd expect to
work.

More generally though what I'm trying to say is more about the approach
that's being taken here; with things like this it's generally much
better to at least have a dig into what's not working for you and have
an idea of what's going on rather than just stopping and asking.  This
is normally easier all round, either you'll be able to sort stuff out
yourself or you'll be able to ask a much better question.
