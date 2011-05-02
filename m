From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: soc-cache: block based	rbtree
	compression
Date: Mon, 2 May 2011 15:42:56 +0100
Message-ID: <20110502144256.GA1656@opensource.wolfsonmicro.com>
References: <1304339309-28820-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<s5hoc3lrxaq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 25DB11037E3
	for <alsa-devel@alsa-project.org>;
	Mon,  2 May 2011 16:42:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hoc3lrxaq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Liam Girdwood <lrg@ti.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 02, 2011 at 04:29:01PM +0200, Takashi Iwai wrote:
> At Mon,  2 May 2011 13:28:28 +0100,
> Dimitris Papastamos wrote:
> > 
> > This patch prepares the ground for the actual rbtree optimization patch
> > which will save a pointer to the last accessed register block that was used
> > in either the read() or write() functions.
> > 
> > Each node manages a block of up to RBTREE_BLOCK_NUM registers.  There can be
> > no two nodes with overlapping blocks.  Currently there is no check in the code
> > to scream in case that ever happens.  Each block has a base and top register,
> > all others lie in between these registers.  Note that variable length blocks
> > aren't supported.  So if you have an interval [8, 15] and only some of those
> > registers actually exist on the device, the block will have the non-existent
> > registers as zero.  There is also no way of reporting that any of those
> > non-existent registers were accessed/modified.
> > 
> > The larger the block size, the more probable it is that one of the
> > managed registers is non-zero, and therefore the node will need to be
> > allocated at initialization time and waste space.
> > 
> > If register N is accessed and it is not part of any of the current
> > blocks in the rbtree, a new node is created with a base register
> > which is floor(N / RBTREE_BLOCK_NUM) * RBTREE_BLOCK_NUM and a top
> > register as base_register + RBTREE_BLOCK_NUM - 1.  All other registers
> > in the block are initialized as expected and the node is inserted into
> > the tree.
> > 
> > Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> 
> Looking through the patch, I wonder whether it gives a performance
> gain enough for the additional complexity.  Did you measure somehow?

This patch might still provide a performance benefit by itself since by
increasing the block size we decrease the number of nodes in the rbtree
that need to be looked up everytime we touch the cache.

Thanks,
Dimitris
