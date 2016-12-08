From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH V2 1/2] ASoC: samsung: include gpio consumer.h
Date: Thu, 8 Dec 2016 22:47:26 +0200
Message-ID: <20161208204726.GA17693@kozik-lap>
References: <1481229781-17483-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481229781-17483-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 08, 2016 at 09:43:01PM +0100, Fabian Frederick wrote:
> Fix the following build errors on X86_32 !GPIOLIB
> 
> sound/soc/samsung/tm2_wm5110.c:220:3: error: implicit declaration
> of function 'gpiod_set_value_cansleep' [-Werror=implicit-function-declaration]
> sound/soc/samsung/tm2_wm5110.c:438:24: error: implicit declaration
> of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
> V2:
>    -Add configuration settings (suggested by Krzysztof Kozlowski)
> 
>  sound/soc/samsung/tm2_wm5110.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
