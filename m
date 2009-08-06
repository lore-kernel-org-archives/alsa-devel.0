From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/20] OMAP: McBSP: Add transmit/receive
	threshold	handler
Date: Thu, 6 Aug 2009 15:10:39 +0300
Message-ID: <20090806121039.GL2358__26828.3283141956$1249560849$gmane$org@atomide.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, alsa-devel@vger.kernel.org, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

* Eduardo Valentin <eduardo.valentin@nokia.com> [090730 16:01]:
> This patch adds a way to handle transmit/receive threshold.
> It export to mcbsp users a callback registration procedure.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> ---
>  arch/arm/plat-omap/include/mach/mcbsp.h |   13 ++++++++
>  arch/arm/plat-omap/mcbsp.c              |   50 +++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
> index e3b300c..26bcab8 100644
> --- a/arch/arm/plat-omap/include/mach/mcbsp.h
> +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
> @@ -259,6 +259,10 @@
>  #define ENAWAKEUP		0x0004
>  #define SOFTRST			0x0002
>  
> +/********************** McBSP IRQSTATUS bit definitions ********************/
> +#define IRQST_XRDY		(1<<10)
> +#define IRQST_RRDY		(1<<3)
> +
>  /********************** McBSP WAKEUPEN bit definitions *********************/
>  #define XEMPTYEOFEN		0x4000
>  #define XRDYEN			0x0400

Please add spaces around << defines above.

Regards,

Tony
