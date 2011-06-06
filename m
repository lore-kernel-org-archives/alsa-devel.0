From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Suppress restore of default register
 values for rbtree cache sync
Date: Mon, 6 Jun 2011 11:39:01 +0100
Message-ID: <20110606103900.GA8286@opensource.wolfsonmicro.com>
References: <1307115435-18213-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110606091807.GA18786@opensource.wolfsonmicro.com>
	<20110606092612.GA12190@opensource.wolfsonmicro.com>
	<20110606092949.GA19456@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0429B10385D
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 12:39:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110606092949.GA19456@opensource.wolfsonmicro.com>
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

On Mon, Jun 06, 2011 at 10:29:49AM +0100, Dimitris Papastamos wrote:

> Yes, in the previous version of the rbtree code, it was saving it in
> the node itself.  I was planning to have a separate block with the
> default values for the block based version but haven't yet got around
> to that.

Oh, good - I was wondering how I'd missed this when doing initial
testing on rbtree code.  If you're removing features like this you
really need to call it out in the changelog, this is quite a nasty
regression as we can easily end up doing a couple of orders of magnitude
more I/O on a slow bus than we were expecting to.
