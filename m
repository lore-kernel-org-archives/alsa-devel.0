From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: oxygen - Fix snd_oxygen module not
 loading for some (new?) Xonar DG SI cards.
Date: Thu, 30 Mar 2017 09:20:58 +0200
Message-ID: <6bb14a89-1879-9fca-db19-acb21dac4bb6@ladisch.de>
References: <20170329211311.GA4751@unit02.localdomain>
 <51152705-a2af-f1d9-b51a-019237e9d334@ladisch.de>
 <20170330025507.GA961@unit02.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A5815266BA4
 for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2017 09:20:59 +0200 (CEST)
In-Reply-To: <20170330025507.GA961@unit02.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eugene Ganeev <easymodofrf@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Eugene Ganeev wrote:
> On Wed, Mar 29, 2017 at 08:56:16PM +0200, Clemens Ladisch wrote:
>> Eugene Ganeev wrote:
>>> My Xonar DG SI card is showing up in lspci but no module is loaded for
>>> it.
>>>
>>> The patch just adds a new value with card's PCI ID to oxygen_ids array.
>>
>> Is the hardware identical?  Do all the inputs and outputs work?
>
> According to asus website they both use C-MEDIA CMI8786. The difference is that DG SI is 7.1 surround compared to 5.1 in DG.
> I've tested the patch, all ports seem to work except rear out. So basically the card is usable unless you use 7.1 setup.

Strange.  This would imply that the CS4245 is used for both headphones
output and back surround output.

And of course this should be supported.  Are you willing to experiment?
(In theory, it should suffice to adjust model.dac_channels_pcm and
model.adjust_dac_routing.)

>> Please add the correct name to the names[] array.
>
> [PATCH v2] sound: oxygen: add Xonar DG SI support
>
> Add PCI ID for the Asus Xonar DG SI card.
>
> Signed-off-by: Eugene Ganeev <easymodofrf@gmail.com>
>
> ---
>
> v2:
> 	- Added model name to names[] array.
>
>  sound/pci/oxygen/oxygen.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/sound/pci/oxygen/oxygen.c b/sound/pci/oxygen/oxygen.c
> index 74afb6b75976..7ba1099fefb1 100644
> --- a/sound/pci/oxygen/oxygen.c
> +++ b/sound/pci/oxygen/oxygen.c
> @@ -94,6 +94,7 @@ enum {
>  	MODEL_2CH_OUTPUT,
>  	MODEL_HG2PCI,
>  	MODEL_XONAR_DG,
> +	MODEL_XONAR_DG_SI,
>  	MODEL_XONAR_DGX,
>  };
>
> @@ -110,6 +111,8 @@ static const struct pci_device_id oxygen_ids[] = {
>  	{ OXYGEN_PCI_SUBID(0x1a58, 0x0910), .driver_data = MODEL_CMEDIA_REF },
>  	/* Asus Xonar DG */
>  	{ OXYGEN_PCI_SUBID(0x1043, 0x8467), .driver_data = MODEL_XONAR_DG },
> +	/* Asus Xonar DG SI */
> +	{ OXYGEN_PCI_SUBID(0x1043, 0x855e), .driver_data = MODEL_XONAR_DG_SI },
>  	/* Asus Xonar DGX */
>  	{ OXYGEN_PCI_SUBID(0x1043, 0x8521), .driver_data = MODEL_XONAR_DGX },
>  	/* PCI 2.0 HD Audio */
> @@ -767,6 +770,7 @@ static int get_oxygen_model(struct oxygen *chip,
>  		[MODEL_FANTASIA]	= "TempoTec HiFier Fantasia",
>  		[MODEL_SERENADE]	= "TempoTec HiFier Serenade",
>  		[MODEL_HG2PCI]		= "CMI8787-HG2PCI",
> +		[MODEL_XONAR_DG_SI]	= "Asus Xonar DG SI",
>  	};
>
>  	chip->model = model_generic;
> @@ -832,6 +836,9 @@ static int get_oxygen_model(struct oxygen *chip,
>  		chip->model = model_xonar_dg;
>  		chip->model.shortname = "Xonar DG";
>  		break;
> +	case MODEL_XONAR_DG_SI:
> +		chip->model = model_xonar_dg;
> +		break;
>  	case MODEL_XONAR_DGX:
>  		chip->model = model_xonar_dg;
>  		chip->model.shortname = "Xonar DGX";

This does no longer apply because of the other names[] patch.

And I forgot to mention: please also update sound/pci/Kconfig and
Documentation/sound/alsa-configuration.rst.


Regards,
Clemens
