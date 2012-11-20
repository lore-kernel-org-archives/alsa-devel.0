From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 0/10] Kirkwood ASoC drivers fixes and
	improvements
Date: Tue, 20 Nov 2012 12:17:26 +0000
Message-ID: <20121120121726.GN3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id DB6D52615DF
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 13:17:35 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, Rabeeh Khoury <rabeeh@solid-run.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The first five patches of this patch series fixes a number of problems
with the Kirkwood audio driver, as seen on Dove platforms.  The biggest
issue is that they can cause the kernel to lock up solidly, requiring
a reset to recover.

Other issues included in the first six patches are bugs found by the
cubox folk.

The other five patches convert the I2S driver to use the devm_* APIs,
improve the handling of the record and playback control registers so
we're not reading and writing them as often, lift restrictions in the
DMA driver which aren't necessary to impose, and add support for
external clocks so that sample rates other than 44.1, 48 and 96kHz
can be supported.  Some of these changes prepare the driver to support
the SPDIF output including passthrough mode; however, that support is
not included in this patch set.

These patches probably need checking out on Kirkwood before they go
into mainline, but given the severity of the kernel lockup, I suggest
that once tested the first five patches go into -rc.

 sound/soc/kirkwood/kirkwood-dma.c |   19 ++-
 sound/soc/kirkwood/kirkwood-i2s.c |  291 ++++++++++++++++++++++---------------
 sound/soc/kirkwood/kirkwood.h     |   11 +-
 3 files changed, 197 insertions(+), 124 deletions(-)

 ASoC: kirkwood-dma: remove channel restrictions
 ASoC: kirkwood-i2s: add support for external clock rates
 ASoC: kirkwood-dma: remove restriction on sample rates
 ASoC: kirkwood-i2s: better handling of play/record control registers
 ASoC: kirkwood-i2s: use devm_* APIs
 ASoC: kirkwood-i2s: more pause-mode fixes
 ASoC: kirkwood-i2s: fix DMA underruns
 ASoC: kirkwood-i2s: fix DCO lock detection
 ASoC: kirkwood-dma: don't ignore other irq causes on error
 ASoC: kirkwood-dma: fix use of virt_to_phys()
