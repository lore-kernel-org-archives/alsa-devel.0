From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH RFC 3/7] clk: samsung: exynos542x: Add EPLL rate table
Date: Sat, 22 Apr 2017 17:28:21 +0200
Message-ID: <20170422152821.v35c2ffrmejpe5oo@kozik-lap>
References: <1492795191-31298-1-git-send-email-s.nawrocki@samsung.com>
 <CGME20170421172029epcas5p1b32ed135c5e0f1b86fbcc54279126349@epcas5p1.samsung.com>
 <1492795191-31298-4-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492795191-31298-4-git-send-email-s.nawrocki@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, inki.dae@samsung.com, sw0312.kim@samsung.com, cw00.choi@samsung.com, javier@osg.samsung.com, jy0922.shim@samsung.com, broonie@kernel.org, robh+dt@kernel.org, b.zolnierkie@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 21, 2017 at 07:19:47PM +0200, Sylwester Nawrocki wrote:
> A specific clock rate table is added for EPLL so it is possible
> to set frequency of the EPLL output clock as multiple of various
> audio sampling rates.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 

Looks correct although I didn't check the numbers.
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
