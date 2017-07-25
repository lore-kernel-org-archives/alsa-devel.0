From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 03/11] ASoC: samsung: pcm: Handle return value of
 clk_prepare_enable.
Date: Tue, 25 Jul 2017 19:51:53 +0200
Message-ID: <20170725175153.GB8329@kozik-book>
References: <1500977674-27960-1-git-send-email-arvind.yadav.cs@gmail.com>
 <1500977674-27960-4-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1500977674-27960-4-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 25, 2017 at 03:44:30PM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  sound/soc/samsung/pcm.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
