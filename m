From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v4 1/3] clk: zte: add i2s clocks for
	zx296718
Date: Thu, 9 Feb 2017 11:20:29 +0800
Message-ID: <20170209032027.GP3407@dragon>
References: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id B5E47267174
 for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2017 04:20:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, xie.baoyou@zte.com.cn, mathieu.poirier@linaro.org, vinod.koul@intel.com, linux-kernel@vger.kernel.org, mturquette@baylibre.com, tiwai@suse.com, sboyd@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, jun.nie@linaro.org, shawn.guo@linaro.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 09, 2017 at 11:12:56AM +0800, Baoyou Xie wrote:
> The i2s related clock support is missing from the existing zx296718
> clock driver. This patch adds it, so that the upstream ZX I2S driver
> can work out.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>

There is no compile-time dependency between this clk patch and I2S
driver one, so it can just go via clk tree, I think.

Shawn
