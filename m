From: Stephen Warren <swarren@nvidia.com>
Subject: WM8903 WM8903_CLK_SYS_ENA vs. MCLK availability
Date: Fri, 7 Jan 2011 15:31:36 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310567DFA@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 2340B24142
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2011 00:36:15 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark,

wm8903_set_bias_level() sets register bit WM8903_CLK_SYS_ENA
when entering SND_SOC_BIAS_STANDBY from _OFF. This requires
that MCLK is running to the codec for register access to
work per the datasheet (and in practice, I hear no sound if
MCLK was not running then. Since this _BIAS_ transition
happens during wm8903_probe, it happens before any code in
the Harmony ASoC machine driver has had a chance to enable
the Tegra cdev1 clock output, fed to the WM8903 MCLK.

In practice, this means:

* arch/arm/mach-tegra/board-harmony.c must contain the
  following to enable cdev1/MCLK early enough:

static __initdata struct tegra_clk_init_table harmony_clk_init_table[] = {
...
	{ "pll_a",	"pll_p_out1",	56448000,	true},
	{ "pll_a_out0",	"pll_a",	11289600,	true},
	{ "cdev1",	"pll_a_out0",	11289600,	true},

* The Harmony driver probably shouldn't ever disable the cdev1
  clock output, except for short durations within a single
  function, since the WM8903 may need this clock for register
  access at arbitrary times.

This means the Harmony machine driver can't really disable/
enable cdev1/MCLK solely when an audio stream is open or
actively streaming, as I was intending.

Is this intended; should the WM8903 driver not be enabling
SYS_ENA so broadly. Perhaps e.g. it should only be enabled
during SND_SOC_BIAS_ON/_PREPARE, and not during _STANDBY?

Alternatively, would having the Harmony machine driver
implement a set_bias function help working around this?

Thanks.

-- 
nvpublic
