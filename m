From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/8] sound/soc: introduce missing kfree
Date: Sat, 12 Sep 2009 12:50:30 +0100
Message-ID: <20090912115029.GA14300@sirena.org.uk>
References: <Pine.LNX.4.64.0909111822480.10552@pc-004.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D0AB51037EA
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Sep 2009 13:50:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0909111822480.10552@pc-004.diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 11, 2009 at 06:23:04PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>

> Error handling code following a kzalloc should free the allocated data.
> Error handling code following an ioremap should iounmap the allocated data.

This doesn't seem to be a complete fix for the issue.  There are several
other places where the function can fail but which don't do this cleanup
- this may indicate a problem with the automatic analysis if it fails to
spot the problem in the fixed code?

In general for this sort of issue I'd suggest considering adding the
error handling using the goto unwind block style since that tends to be
a bit more robust against forgotten error handling than adding unwind
code at each error site.  It's also a bit more managable when the code
is doing a series of allocations like this is.
