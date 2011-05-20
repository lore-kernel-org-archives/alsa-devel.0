From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2 v3] ASoC: soc-cache: Block based rbtree
	compression
Date: Fri, 20 May 2011 11:22:28 +0100
Message-ID: <20110520102228.GC22711@opensource.wolfsonmicro.com>
References: <1305809130-18410-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 310E3103855
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 12:22:25 +0200 (CEST)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, May 19, 2011 at 01:45:29PM +0100, Dimitris Papastamos wrote:
> This patch prepares the ground for the actual rbtree optimization patch
> which will save a pointer to the last accessed rbnode that was used
> in either the read() or write() functions.

Applied both, thanks.
