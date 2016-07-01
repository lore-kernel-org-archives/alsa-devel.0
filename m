From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2 2/6] ASoC: samsung: Add Samsung Low
 Power Audio Subsystem driver
Date: Fri, 01 Jul 2016 18:31:33 +0200
Message-ID: <57769AE5.4050407@samsung.com>
References: <1466678715-19962-1-git-send-email-s.nawrocki@samsung.com>
 <1466678715-19962-3-git-send-email-s.nawrocki@samsung.com>
 <20160629215757.GX6247@sirena.org.uk> <577553FE.6080803@samsung.com>
 <20160701150709.GT6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FB702614E3
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 18:31:45 +0200 (CEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O9N00ABN9WUXH60@mailout1.w1.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 01 Jul 2016 17:31:42 +0100 (BST)
In-reply-to: <20160701150709.GT6247@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, inki.dae@samsung.com, Beomho Seo <beomho.seo@samsung.com>, ideal.song@samsung.com
List-Id: alsa-devel@alsa-project.org

On 07/01/2016 05:07 PM, Mark Brown wrote:
> On Thu, Jun 30, 2016 at 07:16:46PM +0200, Sylwester Nawrocki wrote:
> 
>> > Sorry, I didn't notice this e-mail earlier.  With previous Exynos versions
>> > the LPASS (or AudioSS) was mainly about the embedded audio DSP processor
>> > (at least WRT to SFRs), which was not required for boards supported in 
>> > the mainline kernel. Since e.g. Exynos5433 the LPASS SFR region contains 
>> > also entries related to other IP blocks, like I2S or DMAC.  Even though 
>> > functionality covered by these registers is still rather trivial, like 
>> > SW resets and unmasking interrupts, it's essential for the whole audio 
>> > subsystem operation. The intention was to have in future the LPASS driver 
>> > covering any functionality provided by the embedded audio dedicated MCU.
>> > I'm afraid we have to handle those power sequences in central place to
>> > ensure proper SoC operation. I would also rather avoid adding any exynos 
>> > quirks to the PL330 DMAC driver.
>
> Hrm.  This is sounding a bit like a combination of a power domain and
> an interrupt controller, would something like that fit in perhaps?
> Depends on how many of these trivial bits there are I think...

To me LPASS is somehow similar to the camera subsystem, it's a container/
manager for all the audio related sub-IP blocks.  The LPASS (top) SFR 
region contains bits for resetting sub-blocks like: DMAC, SRAM, TIMER, WDT,
I2S, UART.  It also contains mask and status bits of interrupts from those
IP blocks to the CPU or the embedded MCU (CA5). An (incomplete) list of 
registers can be seen at [1]. There are also entries for software triggered
interrupts to the CPU/MCU, for the MCU reset vector control and general 
purpose register for CPU/MCU communication.

In the SoC there is a dedicated power domain for the whole audio subsystem 
and LPASS also contains a VIC itself. We could try to decompose the LPASS 
top block into various subsystems but I seriously doubt it's a good way
forward. I think LPASS should rather be some top level SoC platform entity.

[1] https://goo.gl/JiYbaZ
