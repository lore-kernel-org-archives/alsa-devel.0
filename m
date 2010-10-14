From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 6/9] davinci: MMC/SD and USB-OHCI configuration for
	Omapl138-Hawkboard
Date: Thu, 14 Oct 2010 21:36:19 +0400
Message-ID: <4CB73F93.6010301@mvista.com>
References: <1287076980-4481-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1287076980-4481-1-git-send-email-vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

On 10/14/10 21:23, vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> From: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>

> This patch defines Pin Mux configuration to enable MMC/SD
> and USB-OHCI on the Hawkboard-L138 system

> Signed-off-by: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
[...]

> diff --git a/arch/arm/mach-davinci/include/mach/mux.h b/arch/arm/mach-davinci/include/mach/mux.h
> index de11aac..f2c2117 100644
> --- a/arch/arm/mach-davinci/include/mach/mux.h
> +++ b/arch/arm/mach-davinci/include/mach/mux.h
> @@ -913,6 +913,10 @@ enum davinci_da850_index {
>   	DA850_GPIO2_15,
>   	DA850_GPIO4_0,
>   	DA850_GPIO4_1,
> +	DA850_GPIO3_12,
> +	DA850_GPIO3_13,
> +	DA850_GPIO2_4,
> +	DA850_GPIO6_13,

    I think these should better go in the alphabetic order.

>   	DA850_RTC_ALARM,
>   };
>

WBR, Sergei
