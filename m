From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Wed, 25 Jul 2012 08:19:20 +0200
Message-ID: <500F8FE8.3070501@gmail.com>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com> <500F050D.6080505@gmail.com>
 <500F05CC.2000105@freescale.com> <500F0666.3030707@gmail.com>
 <500F07F9.8000408@freescale.com> <500F0B2D.9070303@gmail.com>
 <500F0D2C.9010600@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C5326264F3D
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 08:19:21 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so260214wgb.20
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 23:19:24 -0700 (PDT)
In-Reply-To: <500F0D2C.9010600@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 24.07.2012 23:01, Timur Tabi wrote:

> Also, I have a gut feeling that if someone else needs to do the same
> thing, then this code:
> 
> devm_gpio_request_one(&i2c_client->dev, reset_gpio,
> 	reset_gpio_flags & OF_GPIO_ACTIVE_LOW ?
> 	GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
> 	"cs4270 reset")
> 
> won't work for him, because it's not generic enough.

Why is that? The GPIO in the spec can be located anywhere on the board,
either directly driven by the SoC or by any arbitrary other part on on
the board that exposes itself as GPIO chip. And with the ACTIVE_LOW
flag, it's even possible to compensate external circuitry that changes
the polarity.

Which case can you imagine where that flexibility wouldn't suffice?


Daniel
