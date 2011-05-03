From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: soc-cache: block based rbtree
	compression
Date: Tue, 3 May 2011 12:24:24 +0100
Message-ID: <20110503112424.GA2057@opensource.wolfsonmicro.com>
References: <1304339309-28820-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<20110503112124.GF1762@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F250A103899
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 13:24:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110503112124.GF1762@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, May 03, 2011 at 12:21:25PM +0100, Mark Brown wrote:
> On Mon, May 02, 2011 at 01:28:28PM +0100, Dimitris Papastamos wrote:
> 
> > Each node manages a block of up to RBTREE_BLOCK_NUM registers.  There can be
> > no two nodes with overlapping blocks.  Currently there is no check in the code
> > to scream in case that ever happens.  Each block has a base and top register,
> > all others lie in between these registers.  Note that variable length blocks
> > aren't supported.  So if you have an interval [8, 15] and only some of those
> > registers actually exist on the device, the block will have the non-existent
> > registers as zero.  There is also no way of reporting that any of those
> > non-existent registers were accessed/modified.
> 
> As we discussed verbally I'd really rather see this support variable
> length blocks and figure out (ideally at init time) which registers
> exist.  This avoids all the fiddling around working out what to set the
> block size to which seems a lot clearer and cleaner.

Yes, I will look into that.  The block size will still need to be to set
to determine the maximum size of the variable length block.  Otherwise
there is no way to determine if we need to allocate a new node for the
rbtree or not.

Thanks,
Dimitris
