From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: cs4270: Check that we can enable
 regulators on resume
Date: Mon, 19 Mar 2012 17:53:55 +0000
Message-ID: <20120319175355.GC12384@opensource.wolfsonmicro.com>
References: <1332173777-9786-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F6770F0.70002@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C71E81041B0
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 18:53:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F6770F0.70002@freescale.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 19, 2012 at 12:46:24PM -0500, Timur Tabi wrote:

> When I add 'int ret;', it compiles and works.  Note, however, that I have
> no regular support on this board, so I don't know what I'm really testing.

Oh, bah - I have that locally but not in the commit.
