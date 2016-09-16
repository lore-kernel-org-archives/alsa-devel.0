From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ASoC: samsung: add missing \n to end of pr_err messages
Date: Fri, 16 Sep 2016 23:47:57 +0200
Message-ID: <20160916214757.GA22983@kozik-lap>
References: <20160916173053.13138-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160916173053.13138-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: trivial@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2016 at 06:30:53PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trival fix, some pr_err messages are missing a \n, so add it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/samsung/ac97.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)


Hi,

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Also probably converting everything to dev_* would make sense as well
but it is not trivial.

Best regards,
Krzysztof
