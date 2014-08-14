From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] mfd: wm8994: declare dc servo register
	for wm8958	as volatile
Date: Thu, 14 Aug 2014 09:37:53 +0100
Message-ID: <20140814083753.GM15833@opensource.wolfsonmicro.com>
References: <1407943649-9535-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C8542265658
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 10:37:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1407943649-9535-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 13, 2014 at 04:27:29PM +0100, Nikesh Oswal wrote:
> DC Servo register 57h holds the DC offset value after the hardware has
> completed the DC Servo Correction, so declare this register as volatile
> because it is changed by the hardware.
> 
> Signed-off-by: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
> ---
>  drivers/mfd/wm8994-regmap.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/wm8994-regmap.c b/drivers/mfd/wm8994-regmap.c
> index 2fbce9c..fa1630d 100644
> --- a/drivers/mfd/wm8994-regmap.c
> +++ b/drivers/mfd/wm8994-regmap.c
> @@ -1169,6 +1169,7 @@ static bool wm8958_volatile_register(struct device *dev, unsigned int reg)
>  	case WM8958_FW_MINOR_0:
>  	case WM8958_FW_PATCH_1:
>  	case WM8958_FW_PATCH_0:
> +	case WM8994_DC_SERVO_4:

Looking at this again it looks like this should actually be in
wm8994_volatile_register as some revs of the wm8994 use this
register as well as the 8958 for the servo readback.

Then if you update the other patch to use this register for
dsc_readback_mode = 1, then once we have a confirmation
from hardware I think both of these patches are good to go.

Thanks,
Charles

>  		return true;
>  	default:
>  		return wm8994_volatile_register(dev, reg);
> -- 
> 1.7.9.5
> 
> _______________________________________________
> patches mailing list
> patches@opensource.wolfsonmicro.com
> http://opensource.wolfsonmicro.com/cgi-bin/mailman/listinfo/patches
