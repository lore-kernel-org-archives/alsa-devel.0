From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] ALSA: ASoC: Davinci: Fix incorrect
	machine type for SFFSDR board
Date: Sat, 07 Mar 2009 18:45:23 -0800
Message-ID: <873adospfg.fsf@deeprootsystems.com>
References: <1236285897-26180-1-git-send-email-hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C04D1037EC
	for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2009 03:45:27 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id v27so566069wah.16
	for <alsa-devel@alsa-project.org>; Sat, 07 Mar 2009 18:45:26 -0800 (PST)
In-Reply-To: <1236285897-26180-1-git-send-email-hugo@hugovil.com> (Hugo
	Villeneuve's message of "Thu\, 5 Mar 2009 15\:44\:57 -0500")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

Hugo Villeneuve <hugo@hugovil.com> writes:

> Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>
> ---
>  sound/soc/davinci/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
> index 7d3a85d..411a710 100644
> --- a/sound/soc/davinci/Kconfig
> +++ b/sound/soc/davinci/Kconfig
> @@ -21,7 +21,7 @@ config SND_DAVINCI_SOC_EVM
>  
>  config SND_DAVINCI_SOC_SFFSDR
>  	tristate "SoC Audio support for SFFSDR"
> -	depends on SND_DAVINCI_SOC && MACH_DAVINCI_SFFSDR
> +	depends on SND_DAVINCI_SOC && MACH_SFFSDR
>  	select SND_DAVINCI_SOC_I2S
>  	select SND_SOC_PCM3008
>  	select SFFSDR_FPGA

Thanks, pushed.

Kevin
