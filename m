From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/5] clk: bcm2835: enable management of PCM
	clock
Date: Sat, 09 Jan 2016 21:56:39 +0100
Message-ID: <4332640.jBKM55TPAo@wuerfel>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
 <1452331558-2520-3-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by alsa0.perex.cz (Postfix) with ESMTP id ABE1D26052B
 for <alsa-devel@alsa-project.org>; Sat,  9 Jan 2016 21:56:58 +0100 (CET)
In-Reply-To: <1452331558-2520-3-git-send-email-kernel@martin.sperl.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kernel@martin.sperl.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Michael Turquette <mturquette@baylibre.com>, Lee Jones <lee@kernel.org>, Takashi Iwai <tiwai@suse.com>, Eric Anholt <eric@anholt.net>, Remi Pommarel <repk@triplefau.lt>, Mark Brown <broonie@kernel.org>, linux-rpi-kernel@lists.infradead.org, lFlorian Meier <florian.meier@koalo.de>, Matthias Reichl <hias@horus.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Saturday 09 January 2016 09:25:54 kernel@martin.sperl.org wrote:
> --- a/include/dt-bindings/clock/bcm2835.h
> +++ b/include/dt-bindings/clock/bcm2835.h
> @@ -44,5 +44,6 @@
>  #define BCM2835_CLOCK_EMMC             28
>  #define BCM2835_CLOCK_PERI_IMAGE       29
>  #define BCM2835_CLOCK_PWM              30
> +#define BCM2835_CLOCK_PCM              31
>  
> -#define BCM2835_CLOCK_COUNT            31
> +#define BCM2835_CLOCK_COUNT            32

The last line contains an incompatible change, please don't do that.
If you have to add another clock, do that after the BCM2835_CLOCK_COUNT
definition to avoid changing dts files that use that number.

	Arnd
