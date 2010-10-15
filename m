From: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 8/9] davinci: USB clocks for Omapl138-Hawkboard
Date: Fri, 15 Oct 2010 20:27:24 +0400
Message-ID: <4CB880EC.3000909@mvista.com>
References: <1287112105-11968-1-git-send-email-vm.rod25@gmail.com>
	<1287112105-11968-9-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1287112105-11968-9-git-send-email-vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

On 10/15/10 07:08, vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> From: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>

> This patch adds USB1.1 and USB2.0 clocks for the Hawkboard-L138 system

> Signed-off-by: Victor Rodriguez<victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
[...]

> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 4458bff..2a4730e 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -345,6 +345,20 @@ static struct clk aemif_clk = {
>   	.flags		= ALWAYS_ENABLED,
>   };
>
> +static struct clk usb11_clk = {
> +	.name		= "usb11",
> +	.parent		=&pll0_sysclk4,
> +	.lpsc		= DA8XX_LPSC1_USB11,
> +	.gpsc		= 1,
> +	};

    This } should be at the start of line.

> +
> +static struct clk usb20_clk = {
> +	.name		= "usb20",
> +	.parent		=&pll0_sysclk2,
> +	.lpsc		= DA8XX_LPSC1_USB20,
> +	.gpsc		= 1,
> +	};

    Same comment.

WBR, Sergei
