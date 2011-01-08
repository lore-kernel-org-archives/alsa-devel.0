From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: WM8903 WM8903_CLK_SYS_ENA vs. MCLK availability
Date: Sat, 8 Jan 2011 00:04:29 +0000
Message-ID: <20110108000429.GA23676@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310567DFA@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4661424343
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2011 01:04:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310567DFA@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 07, 2011 at 03:31:36PM -0800, Stephen Warren wrote:

> Is this intended; should the WM8903 driver not be enabling
> SYS_ENA so broadly. Perhaps e.g. it should only be enabled
> during SND_SOC_BIAS_ON/_PREPARE, and not during _STANDBY?

It's enabled because the initial bringup of the device uses the write
sequencer which relies on the MCLK, and more practically because devices
of the era that the driver was written were rarely able to manage the
external clock.

For the initial driver submission I suggest fixing the MCLK rate for
44.1kHz and leaving it on all the time under the control of the machine
driver, I'll make sure someone from Wolfson enhances the WM8903 driver
so that the machine driver can be made more flexible.
