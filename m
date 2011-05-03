From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v2] ASoC: soc-cache: block based rbtree
	compression
Date: Tue, 3 May 2011 14:44:28 +0100
Message-ID: <20110503134427.GN1762@opensource.wolfsonmicro.com>
References: <1304339309-28820-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<20110503112124.GF1762@opensource.wolfsonmicro.com>
	<20110503112424.GA2057@opensource.wolfsonmicro.com>
	<20110503112651.GH1762@opensource.wolfsonmicro.com>
	<20110503114618.GA2215@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 229A3103821
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 15:44:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110503114618.GA2215@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, May 03, 2011 at 12:46:18PM +0100, Dimitris Papastamos wrote:

> We can do this yes.  One possible problem is that if we start merging
> blocks like that, in the long run we might end-up having one node with a
> very large block.  This will happen for example if we write to the
> entire register map.  In that case looking up a register will require
> O(n) time in the worst case where n is the number of registers.  If we
> however have a constant limit k on the block size, we can cut this down to
> O(klogn) in the worst case.

Summarising offline discussion for the list: if we use an array for the
data and realloc it if we need to change the node size then we keep the
O(klogn) for these cases
