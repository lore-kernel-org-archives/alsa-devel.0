From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add TXx9 AC link controller driver
Date: Fri, 15 May 2009 20:05:58 +0100
Message-ID: <20090515190558.GA13050@sirena.org.uk>
References: <1242312605-2160-1-git-send-email-anemo@mba.ocn.ne.jp>
	<20090514185945.GO28291@sirena.org.uk>
	<20090516.001202.173372394.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 486DF1039DE
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 21:06:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090516.001202.173372394.anemo@mba.ocn.ne.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, ralf@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 16, 2009 at 12:12:02AM +0900, Atsushi Nemoto wrote:

> OK, then I will move irq/mem resource stuff to the DAI driver and dma
> resource stuff to the DMA driver.

Either is fine - do whatever makes most sense for your system.

> OTOH, I want to keep arch code as is.  There are some TXx9 SoC
> variations and they can have different baseaddr/irq/dma.  I want to
> leave these details in arch code and make ASoC drivers generic as
> possible.

This is the common situation for SoC CPUs - most silicon vendors reuse
the same IPs in diffierent combinations on different CPUs.  The normal
approach is to have the generic code for each SoC set up the resources
for the devices that are present on that particular SoC.  This avoids
the need for each board using the SoC to have to replicate the
information.
