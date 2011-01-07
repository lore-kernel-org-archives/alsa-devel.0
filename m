From: Stephen Warren <swarren@nvidia.com>
Subject: Tegra audio clocking
Date: Fri, 7 Jan 2011 12:48:29 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310567D81@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id B5F8D10382A
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 21:55:21 +0100 (CET)
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

A few thoughts on re-structuring the clocking in the Tegra
audio driver. Here's what I'm thinking:

The machine driver owns configuring the root pll, pll_a, and
the cdev clock output to the codec (MCLK). The I2S driver
owns configuring the I2S clock frequency. I think all these
clocks will need to be configured in hw_params, enabled in
trigger(START/...), and disabled in trigger(STOP/...).

Does this sound sane to you? It will mean turning the clocks
on/off a lot, which goes against something you'd mentioned
above not glitching the clocks every time. However, the
following explains why:


It's not appropriate to put 100% of the clock configuration
(pll, cdev, and i2s clocks) into the I2S driver because:

* pll is shared between the 2 I2S controllers, the 1 AC'97
  controller, and perhaps also SPDIF I/O in some setups.

* cdev connectivity (and hence what needs to be driven on
  it) is machine-specific, and the I2S driver shouldn't know
  about that.

Hence, I believe the machine driver needs to control both of
those (although using utility code to avoid cut/paste of all
the clock calls into each machine driver).

The I2S clocking shouldn't be in the machine driver itself,
because only the I2S driver knows the requirements to WAR any
issues in the Tegra I2S port. Specifically, the I2S clock
cannot be equal to srate*channels*bits, because the I2S
controller requires at least (channels*bits)+1 clocks per
sample (which ends up being channel*bits*2 in practice for
simplicity). This knowledge should really be isolated in the I2S
driver not machine level driver. Arguably though, it might not
be totally inappropriate for a utility library to encode this
knowledge, and have the machine driver call the utility library.

When the machine driver reconfigures the pll_a frequency,
that clock must have zero reference count, or the kernel will
BUG(). A 0 ref count implies that the clock is disabled, and all
child/derived clocks are disabled. In particular, the I2S clock
must be disabled. So, co-ordination is needed between the
machine and I2S drivers when reconfiguring clocks.

I can see 3 ways to co-ordinate this:

1) Have all clocks off, except between two well-defined API
   calls (e.g. trigger START/STOP) such that the machine
   driver has a well-defined time the clock can be
   reconfigured without explicit calls to co-ordinate with the
   I2S driver.

2) Abuse the I2S driver's set_tristate function to perform
   the co-ordination (or add a new snd_soc_dai_ops function for
   this, or directly call the I2S driver from the machine driver).

3) Have the machine driver own the I2S clock too. See issues
   above.

Let me know if you think option 2 or 3 would actually be better
than option 1, or if there's some option I didn't think of.

Thanks.

-- 
nvpublic
