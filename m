From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8962: set ALC2 as non-volatile register
Date: Mon, 26 Oct 2015 08:40:13 +0000
Message-ID: <20151026084013.GG10520@ck-lbox>
References: <1445577528-2354-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445577528-2354-1-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 23, 2015 at 02:18:48PM +0900, Jiada Wang wrote:
> Previously ALC2 register is set as a volatile register, declare
> it as one of ALC Coefficients register together with other non-volatile
> registers will cause issue, in case wm8962 has enter suspend mode,
> and cache_only flag is set, any attempt to read from ALC2 will fail.
> 
> Because the 5 status bits in ALC2 aren't used anywhere nor are useful
> to end user, so this patch removes ALC2 register from volatile
> register list to make ALC2 be possible to be accessed when cache_only
> flag is set.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
