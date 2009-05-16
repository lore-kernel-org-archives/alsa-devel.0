From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] ASoC: Add TXx9 AC link controller driver
Date: Sat, 16 May 2009 22:45:41 +0900 (JST)
Message-ID: <20090516.224541.39155366.anemo@mba.ocn.ne.jp>
References: <20090514185945.GO28291@sirena.org.uk>
	<20090516.001202.173372394.anemo@mba.ocn.ne.jp>
	<20090515190558.GA13050@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.mba.ocn.ne.jp (mba.ocn.ne.jp [122.1.235.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 1966324552
	for <alsa-devel@alsa-project.org>;
	Sat, 16 May 2009 15:45:44 +0200 (CEST)
In-Reply-To: <20090515190558.GA13050@sirena.org.uk>
	<1242312605-2160-2-git-send-email-anemo@mba.ocn.ne.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, ralf@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Fri, 15 May 2009 20:05:58 +0100, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> > OTOH, I want to keep arch code as is.  There are some TXx9 SoC
> > variations and they can have different baseaddr/irq/dma.  I want to
> > leave these details in arch code and make ASoC drivers generic as
> > possible.
> 
> This is the common situation for SoC CPUs - most silicon vendors reuse
> the same IPs in diffierent combinations on different CPUs.  The normal
> approach is to have the generic code for each SoC set up the resources
> for the devices that are present on that particular SoC.  This avoids
> the need for each board using the SoC to have to replicate the
> information.

Yes, and I tried to do so in "TXx9: Add ACLC support" patch.

>  arch/mips/include/asm/txx9/generic.h  |    5 ++++
>  arch/mips/include/asm/txx9/tx4927.h   |    2 +
>  arch/mips/include/asm/txx9/tx4938.h   |    1 +
>  arch/mips/include/asm/txx9/tx4939.h   |    1 +
>  arch/mips/txx9/Kconfig                |    3 ++
>  arch/mips/txx9/generic/setup.c        |   36 +++++++++++++++++++++++++++
>  arch/mips/txx9/generic/setup_tx4927.c |   43 +++++++++++++++++++++++++++++++++
>  arch/mips/txx9/generic/setup_tx4938.c |   11 ++++++++
>  arch/mips/txx9/generic/setup_tx4939.c |    9 +++++++

These are "the generic code for each SoC set up the resources for
the devices that are present on that particular SoC".

>  arch/mips/txx9/rbtx4927/setup.c       |    7 ++++-
>  arch/mips/txx9/rbtx4938/setup.c       |    1 +
>  arch/mips/txx9/rbtx4939/setup.c       |    1 +

And these are setup codes for each boards.

Is this acceptable?  I'm not sure whether you are saying Ack or Nack
for this approach.

---
Atsushi Nemoto
