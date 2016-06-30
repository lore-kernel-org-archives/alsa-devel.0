From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v2 2/6] ASoC: samsung: Add Samsung Low
 Power Audio Subsystem driver
Date: Thu, 30 Jun 2016 19:16:46 +0200
Message-ID: <577553FE.6080803@samsung.com>
References: <1466678715-19962-1-git-send-email-s.nawrocki@samsung.com>
 <1466678715-19962-3-git-send-email-s.nawrocki@samsung.com>
 <20160629215757.GX6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 286BA265300
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2016 19:16:59 +0200 (CEST)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0O9L007PKHC6N290@mailout1.w1.samsung.com> for
 alsa-devel@alsa-project.org; Thu, 30 Jun 2016 18:16:54 +0100 (BST)
In-reply-to: <20160629215757.GX6247@sirena.org.uk>
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

On 06/29/2016 11:57 PM, Mark Brown wrote:
> On Thu, Jun 23, 2016 at 12:45:11PM +0200, Sylwester Nawrocki wrote:
...
>> > This patch adds LPASS driver. The LPASS (Low Power Audio Subsystem)
>> > is a special subsystem that supports audio playback with low power
>> > consumption. This is a minimal driver which prepares resources for
>> > IP blocks like I2S, audio DMA and UART.
>> > Also system power ops are added to ensure the Audio Subsystem is
>> > operational after system suspend/resume cycle.
>
> This is so trivial that I'm wondering why you even need it, it does
> essentially nothing except for manage power on and off, and that isn't
> synced up with the rest of the audio subsystem in any discernable way.
> Previous Samsung SoCs have quite happily ignored their LPASS subsystems
> in mainline.  As things stand I'm concerned that systems may get broken
> if more functionality is added without the joining up with the rest of
> the audio hardware via a card, there's not even the hooks which would
> allow that.

Sorry, I didn't notice this e-mail earlier.  With previous Exynos versions
the LPASS (or AudioSS) was mainly about the embedded audio DSP processor
(at least WRT to SFRs), which was not required for boards supported in 
the mainline kernel. Since e.g. Exynos5433 the LPASS SFR region contains 
also entries related to other IP blocks, like I2S or DMAC.  Even though 
functionality covered by these registers is still rather trivial, like 
SW resets and unmasking interrupts, it's essential for the whole audio 
subsystem operation. The intention was to have in future the LPASS driver 
covering any functionality provided by the embedded audio dedicated MCU.
I'm afraid we have to handle those power sequences in central place to
ensure proper SoC operation. I would also rather avoid adding any exynos 
quirks to the PL330 DMAC driver. 

I agree this driver is currently detached from the rest, while it would
be good at the card to ensure the required resources are prepared.
How about making LPASS registering a component and then adding it at
the card as aux_dev? I would move some parts to the component's probe()
callback and with component's probe_order specified a proper 
initialization sequence could be ensured.
