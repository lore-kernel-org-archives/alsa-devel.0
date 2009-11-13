From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] soc-core: let suspend/resume not called if
 the card is not instantiated
Date: Fri, 13 Nov 2009 13:38:24 +0000
Message-ID: <20091113133824.GD21516@rakim.wolfsonmicro.main>
References: <1258087878-18679-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C4F0124420
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2009 14:38:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1258087878-18679-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 13, 2009 at 12:51:18PM +0800, Barry Song wrote:
> It doesn't make sense to call suspend/resume of all cpu/codec dais even
> they are not initialized and registered. This will cause many problems
> foraudio PM.
> The condition card is not instantiated covers codec is null, so delete
> the check that codec is null.

Hrm.  It's not clear that this is the best approach here - it'd mean
that things like the CODEC drivers would need to have two suspend and
resume paths, one for use before the card comes up and one for use
afterwards.  As things stand this will fix whatever problem you are
seeing but will create problems for other systems where we'll stop
suspending devices that need it.

As with your TDM port issue pm_link is going to be really helpful here
once it hits mainline.  Let me have a think about what (if anything) we
can do in the meantime, this area is a little fragile.
