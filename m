From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: FW: [PATCH 07/22] ASoC: Ux500: Initialise PCM from
 MSP probe rather than as a device
Date: Mon, 27 Aug 2012 09:33:38 -0700
Message-ID: <20120827163337.GC4339@opensource.wolfsonmicro.com>
References: <014401cd8165$99960c40$ccc224c0$@se>
 <50377C0D.2060905@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 619A7265E3F
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2012 18:33:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <50377C0D.2060905@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: roger.xr.nilsson@stericsson.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, lee.jones@linaro.org, Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 24, 2012 at 03:05:17PM +0200, Ola Lilja wrote:

> I haven't followed everything in this discussion, but what I meant in an earlier
> mail was that using the device for platform-DAI (MSP_I2S) also
> as platform int the DAI-link struct is not anything I can see fit (as in the
> patch Lee first submitted).

I'm not sure I fully understand the above - I didn't notice anything
with the dai links but I have to say that I could've looked more closely
as I was waiting for ARM side reviews.

> I can see a few acceptable solutions:
> 1) Use it as it is! (A virtual device for PCM is created in arch/arm and the
> probe is invoked from the machine-driver).
> 2) Since the actual platform is the DMA-block, maybe there is some way of making
> the device "non-virtual" by having some sub-device in the DMA-driver that is
> instead triggered in the same way as in 1).

The option we're using is essentially your option 2 but doing it from
the DAI driver rather than from the DMA driver (keeping things in the
audio subsystem since it's an audio specific issue).
