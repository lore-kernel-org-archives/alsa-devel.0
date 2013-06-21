From: Bo Shen <voice.shen@atmel.com>
Subject: Re: WM8741 DAC with AT91SAM9G20
Date: Fri, 21 Jun 2013 18:25:24 +0800
Message-ID: <51C42A14.1070907@atmel.com>
References: <CA+WMtaNJYNO81zKVWYYQ2SkPwd+2tvn0KEBNv879mNANTLYU9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.243])
 by alsa0.perex.cz (Postfix) with ESMTP id 754E52610C5
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 12:27:27 +0200 (CEST)
In-Reply-To: <CA+WMtaNJYNO81zKVWYYQ2SkPwd+2tvn0KEBNv879mNANTLYU9w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Lathion <m.lathion@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Michael,

On 06/21/2013 05:40 AM, Michael Lathion wrote:
> Hi all,
>
> I'm trying to use a WM8742 dac instead of WM8731 on a custom board based on
> AT91SAM9G20EK (developpment board from Atmel for AT91SAM9G20 soc) with
> Linux Kernel 2.6.38.
>
> I have the driver working in alsa (driver compiled, mixer up in alsa, ...)
> but I can't have the ssc interface working. When trying to play sound with
> aplay I get only the masterclock and  bitclock but no frame clock (LRCLK),
> see output below.
>
> What I've done is modifying the /sound/soc/atmel/sam9g20_wm8731.c file  but
> it seems something is not configured as it should (probably related to
> WM8742 being slave and the WM8731 used on original dev board was master for
> clock distribution).
>
> My modified sam9g20_wm8741.c is enclosed to this mail, i suspect something
> is wrongly setup in CPU DAI configuration but can't find what.

Don't see any attachment. So, don't know how you modify the code.

However, for your reference for codec work as slave, atmel ssc as 
master: 
https://github.com/Android4SAM/linux-at91/commit/33db8ebd3e75632c482dda271340f4d2adcfd320

Best Regards,
Bo Shen
