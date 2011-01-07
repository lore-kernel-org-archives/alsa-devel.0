From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Tegra audio clocking
Date: Fri, 7 Jan 2011 21:01:48 +0000
Message-ID: <20110107210148.GA9482@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310567D81@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 238E810382A
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 22:01:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310567D81@HQMAIL01.nvidia.com>
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

On Fri, Jan 07, 2011 at 12:48:29PM -0800, Stephen Warren wrote:

> Does this sound sane to you? It will mean turning the clocks
> on/off a lot, which goes against something you'd mentioned
> above not glitching the clocks every time. However, the
> following explains why:

It'll only glitch the clocks if you allow them to be be reconfigured
while audio is active but since this would presumably cause the active
streams to be reconfigured which would disrupt them.

> Hence, I believe the machine driver needs to control both of
> those (although using utility code to avoid cut/paste of all
> the clock calls into each machine driver).

That's fine.

> I can see 3 ways to co-ordinate this:

> 1) Have all clocks off, except between two well-defined API
>    calls (e.g. trigger START/STOP) such that the machine
>    driver has a well-defined time the clock can be
>    reconfigured without explicit calls to co-ordinate with the
>    I2S driver.

It'd seem best from a power point of view to disable the clocks wherever
possible anyway so this seems like a good option.
