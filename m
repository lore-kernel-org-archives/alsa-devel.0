From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RESENDING] [PATCH 07/22] ASoC: Ux500: Initialise
 PCM from MSP probe rather than as a device
Date: Thu, 20 Sep 2012 08:49:04 -0400
Message-ID: <20120920124903.GO17666@opensource.wolfsonmicro.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbc6bGC4Yp7Bcdfev=Uc=1h4L1v+Lj9RbmJV3F+knQOZQ@mail.gmail.com>
 <20120919133343.GH25694@gmail.com>
 <505ADBE6.6080509@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 433B9265319
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 14:49:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <505ADBE6.6080509@stericsson.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "arnd@arndb.de" <arnd@arndb.de>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 20, 2012 at 11:03:34AM +0200, Ola Lilja wrote:

> I still don't like this. It is the dai_link-struct that bothers me. We have
> "ux500-msp-i2s.1" as name of the platform AND the cpu_dai. The MSP I2S-block is
> not the platform and it is certainly not both platform and cpu-DAI at the same time.

> Mark: Did you have a solution for this? Couldn't we just put NULL on the
> platform_name instead?

No, having no platform driver means a direct device<->device link (like
baseband<->CODEC).  You could always register the platform with a -dma
added in the name or something, it'd be a bit more code but it'd work,
but the framework doesn't particularly care what you call these things.
