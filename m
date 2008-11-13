From: "Arun KS" <arunks@mistralsolutions.com>
Subject: Re: [topic/asoc][PATCH] ASoC: OMAP: Add more supported
	sample rates into McBSP DAI driver
Date: Thu, 13 Nov 2008 15:32:50 +0530
Message-ID: <dfeb90390811130202p2cd7c29atc161213580b31237@mail.gmail.com>
References: <1226502351-21838-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id D60A4244D2
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 11:02:51 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id k29so1366288rvb.2
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 02:02:50 -0800 (PST)
In-Reply-To: <1226502351-21838-1-git-send-email-jarkko.nikula@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 12, 2008 at 8:35 PM, Jarkko Nikula <jarkko.nikula@nokia.com>wrote:

> Originally it was put too tight limits to support only 44.1 kHz and 48 kHz
> sample rates in McBSP DAI driver. Extend it now to 8 kHz - 96 kHz. With
> 96 kHz and 2*16 bits, bit clock is 3.072 MHz < 3.125 MHz (I2S max?).
>
> Tested on Nokia N810 with TVL320AIC33 from rates 8 - 96 kHz and on Texas
> Instruments Beagle with TWL4030 from rates 8 - 48 kHz.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Cc: Steve Sakoman <steve@sakoman.com>
> Cc: Arun KS <arunks@mistralsolutions.com>


Acked-by: Arun KS <arunks@mistralsolutions.com

Tested this on osk5912.
