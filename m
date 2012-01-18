From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: sgtl5000: Fix wrong register name
	in restore
Date: Wed, 18 Jan 2012 10:55:27 +0000
Message-ID: <20120118105527.GF8732@opensource.wolfsonmicro.com>
References: <1326866287-16283-1-git-send-email-zengzm.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 93EB5103ABB
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 11:55:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326866287-16283-1-git-send-email-zengzm.kernel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: zengzm.kernel@gmail.com
Cc: alsa-devel@alsa-project.org, festevam@gmail.com, w.sang@pengutronix.de, julia.lawall@lip6.fr, shawn.guo@linaro.org, B29396@freescale.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 18, 2012 at 01:58:07PM +0800, zengzm.kernel@gmail.com wrote:
> From: Zeng Zhaoming <zengzm.kernel@gmail.com>
> 
> Correct SGTL5000_CHIP_CLK_CTRL to SGTL5000_CHIP_REF_CTRL in
> sgtl5000_restore_regs(), and add comment to explain the
> restore order.

Applied, thanks.
