From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 12/15] oxfw: Add support for Behringer/Mackie
	devices
Date: Sun, 10 Aug 2014 17:54:45 +0200
Message-ID: <53E795C5.1010506@ladisch.de>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
	<1399991272-5807-13-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1399991272-5807-13-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, fenlason@redhat.com, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Some devices produced by Behringer/Mackie are based on OXFW970/971. This
> commit adds support for them.
>
> +++ b/sound/firewire/oxfw/oxfw.c
> @@ -16,6 +16,8 @@
>
>  #define VENDOR_GRIFFIN		0x001292
>  #define VENDOR_LACIE		0x00d04b
> +#define VEN_BEHRINGER		0x001564
> +#define VEN_LOUD		0x000ff2

These IDs were supposed to be ordered. :)
And why "VEN_" instead of "VENDOR_"?

> +	...
> +	{
> +		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
> +				  IEEE1394_MATCH_MODEL_ID,
> +		.vendor_id	= VEN_LOUD,
> +		.model_id	= 0x000460,
> +	},
> +	/* IDs are unknown but able to be supported */
> +	/*  Mackie(Loud), d.2 pro */
> +	/*  Mackie(Loud), d.4 pro */
> +	/*  Mackie(Loud), U.420 */
> +	/*  Mackie(Loud), U.420d */

To support all Mackie devices, use one ID entry with only the vendor ID,
and abort with -ENODEV from the _probe function if the hardware is not
actually an OXFW97x device (try to read the HARDWARE_ID and/or
FIRMWARE_ID registers).


Regards,
Clemens

------------------------------------------------------------------------------
