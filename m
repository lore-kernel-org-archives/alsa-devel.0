From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v5 3/7] clk: at91: add audio pll clock drivers
Date: Fri, 1 Sep 2017 15:55:14 -0700
Message-ID: <20170901225514.GE21656@codeaurora.org>
References: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
 <f1c7acbfec384c2c33bf340464a98b731dac8c0c.1502346448.git-series.quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f1c7acbfec384c2c33bf340464a98b731dac8c0c.1502346448.git-series.quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, boris.brezillon@free-electrons.com, alsa-devel@alsa-project.org, thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, tiwai@suse.com, Nicolas Ferre <nicolas.ferre@atmel.com>, lgirdwood@gmail.com, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, broonie@kernel.org, cyrille.pitchen@wedev4u.fr, linux@armlinux.org.uk, perex@perex.cz, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 08/10, Quentin Schulz wrote:
> This new clock driver set allows to have a fractional divided clock that
> would generate a precise clock particularly suitable for audio
> applications.
> 
> The main audio pll clock has two children clocks: one that is connected
> to the PMC, the other that can directly drive a pad. As these two routes
> have different enable bits and different dividers and divider formulas,
> they are handled by two different drivers. Each of them could modify the
> rate of the main audio pll parent.
> 
> The main audio pll clock can output 620MHz to 700MHz.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
