From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v1 3/6] ASoC: davinci: ASoC support for Omapl138-Hawkboard
Date: Sat, 09 Oct 2010 16:28:42 +0400
Message-ID: <4CB05FFA.4070804@mvista.com>
References: <1286586727-1296-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1286586727-1296-1-git-send-email-vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hello.

On 09-10-2010 5:12, vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> From: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>

> This patch adds ASoC support for the Hawkboard-L138 system
> It is under the machine name "omapl138_hawkboard".
> This system is based on the da850 davinci CPU architecture.

> Signed-off-by: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
[...]

> diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
> index 6bbf001..d6cb394 100644
> --- a/sound/soc/davinci/Kconfig
> +++ b/sound/soc/davinci/Kconfig
> @@ -76,8 +76,9 @@ config  SND_DA830_SOC_EVM
>   	  DA830/OMAP-L137 EVM
>
>   config  SND_DA850_SOC_EVM
> -	tristate "SoC Audio support for DA850/OMAP-L138 EVM"
> -	depends on SND_DAVINCI_SOC && MACH_DAVINCI_DA850_EVM
> +	tristate "SoC Audio support for DA850/OMAP-L138 EVM/Hawkboard"
> +	depends on SND_DAVINCI_SOC&& (MACH_DAVINCI_DA850_EVM \

    Keep space before && please.

> +					|| MACH_OMAPL138_HAWKBOARD)

    || should preferably be on the previous line.

WBR, Sergei
