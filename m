From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Suppress restore of default register
 values for rbtree cache sync
Date: Mon, 6 Jun 2011 10:26:12 +0100
Message-ID: <20110606092612.GA12190@opensource.wolfsonmicro.com>
References: <1307115435-18213-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110606091807.GA18786@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 561DD1037E3
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 11:26:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110606091807.GA18786@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 06, 2011 at 10:18:07AM +0100, Dimitris Papastamos wrote:

> There should be a check for reg_def_copy being NULL, the soc-cache code
> is also built around the idea that the driver might not provide a
> register defaults cache at all so this change needs to cope with that.

Hrm, at this point I'm rather inclined to say that if you're using a
fancy cache method you should be providing defaults.

> Also I'd expect the reg_def_copy cache to be freed sooner rather than
> while unregistering the codec, this is not happening at the moment,
> which is wasting significant space.  This is the case because it is only
> used during initialization.

That's the bit I was saying at the bottom of the commit message about
putting it into the node itself; since we're currently never freeing it
we can use it but we should really be copying it into the tree.  The
memory wasted is a *much* less severe problem than the I/O bandwidth
consumed rewriting the entire register map on every sync.
