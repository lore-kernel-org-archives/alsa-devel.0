From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [patch] oxygen: change || to &&
Date: Wed, 03 Mar 2010 09:58:06 +0100
Message-ID: <4B8E249E.2090806@ladisch.de>
References: <20100303070818.GD5086@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0A4C71038AF
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 09:58:10 +0100 (CET)
In-Reply-To: <20100303070818.GD5086@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Dan Carpenter wrote:
> In the original code the condition was always true (hopefully) because
> WM8776_HPLVOL is zero.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Thanks; applied.

> diff --git a/sound/pci/oxygen/xonar_wm87x6.c b/sound/pci/oxygen/xonar_wm87x6.c
> index 7754db1..dbc4b89 100644
> --- a/sound/pci/oxygen/xonar_wm87x6.c
> +++ b/sound/pci/oxygen/xonar_wm87x6.c
> @@ -68,7 +68,7 @@ static void wm8776_write(struct oxygen *chip,
>  			 OXYGEN_SPI_CEN_LATCH_CLOCK_LO,
>  			 (reg << 9) | value);
>  	if (reg < ARRAY_SIZE(data->wm8776_regs)) {
> -		if (reg >= WM8776_HPLVOL || reg <= WM8776_DACMASTER)
> +		if (reg >= WM8776_HPLVOL && reg <= WM8776_DACMASTER)
>  			value &= ~WM8776_UPDATE;
>  		data->wm8776_regs[reg] = value;
>  	}
