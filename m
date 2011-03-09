From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: AM3517: Update codec name after multi-component
 update
Date: Wed, 09 Mar 2011 11:55:45 +0000
Message-ID: <1299671745.3360.90.camel@odin>
References: <1299598363-32656-1-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1299598363-32656-1-git-send-email-abhilash.kv@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Abhilash K V <abhilash.kv@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, jhnikula@gmail.com, broonie@opensource.wolfsonmicro.com, perex@perex.cz, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-03-08 at 21:02 +0530, Abhilash K V wrote:
> The i2c client device name (".2-001a" in this case, including
> the separator period) for the AIC23 codec on the TI AM3517-EVM
> was appended to the codec_name member of am3517evm_dai to
> resolve the names mismatch happening in soc_bind_dai_link(),
> due to which the card was not getting registered.
> 
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
> 
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> 
> ---

Applied.

Thanks

Liam

