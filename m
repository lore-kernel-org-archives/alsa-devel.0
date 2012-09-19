From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: imx-audmux: remove null check of
 audmux_base in audmux_read_file
Date: Tue, 18 Sep 2012 22:53:47 -0400
Message-ID: <20120919025345.GL8832@opensource.wolfsonmicro.com>
References: <1347957510-20590-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2E76326514A
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 04:53:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347957510-20590-1-git-send-email-richard.zhao@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 18, 2012 at 04:38:30PM +0800, Richard Zhao wrote:
> When audmux_read_file is called, it means the driver is already
> initialised successfully, so we don't need to check audmux_base.
> 
> It also fix smatch warning:
> sound/soc/fsl/imx-audmux.c:78 audmux_read_file() warn: possible memory leak of 'buf'

Applied, though it doesn't seem like the best fix to remove an error
check even if it should be redundant.
