From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2 v3] ASoC: soc-cache: Block based rbtree
	compression
Date: Fri, 20 May 2011 09:45:02 +0100
Message-ID: <4DD62A0E.1010905@ti.com>
References: <1305809130-18410-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D919103A5E
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 10:45:07 +0200 (CEST)
In-Reply-To: <1305809130-18410-1-git-send-email-dp@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 19/05/11 13:45, Dimitris Papastamos wrote:
> This patch prepares the ground for the actual rbtree optimization patch
> which will save a pointer to the last accessed rbnode that was used
> in either the read() or write() functions.
> 
> Each rbnode manages a variable length block of registers.  There can be no
> two nodes with overlapping blocks.  Each block has a base register and a
> currently top register, all the other registers, if any, lie in between these
> two and in ascending order.
> 
> The reasoning behind the construction of this rbtree is simple.  In the
> snd_soc_rbtree_cache_init() function, we iterate over the register defaults
> provided by the driver.  For each register value that is non-zero we
> insert it in the rbtree.  In order to determine in which rbnode we need
> to add the register, we first look if there is another register already
> added that is adjacent to the one we are about to add.  If that is the case
> we append it in that rbnode block, otherwise we create a new rbnode
> with a single register in its block and add it to the tree.
> 
> In the next patch, where a cached rbnode is used by both the write() and the
> read() functions, we also check if the register we are about to add is in the
> cached rbnode (the least recently accessed one) and if so we append it in that
> rbnode block.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>
Both

Acked-by: Liam Girdwood <lrg@ti.com>
