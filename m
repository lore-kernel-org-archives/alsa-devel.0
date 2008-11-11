From: "Yang, Libin" <Libin.Yang@amd.com>
Subject: HDA-Intel - Patch to support detecting HD Audio
	devices with PCI class code
Date: Tue, 11 Nov 2008 11:30:34 +0800
Message-ID: <6077B97E85E7374DAE87B42B5AA9979707B8DA@sshaexmb1.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SG2EHSOBE003.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by alsa0.perex.cz (Postfix) with ESMTP id D2C0F2447D
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 04:30:50 +0100 (CET)
Content-Class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Yang, Libin" <Libin.Yang@amd.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry, adding the title...

Thanks & Regards,
Libin

> -----Original Message-----
> From: Yang, Libin
> Sent: Tuesday, November 11, 2008 10:43 AM
> To: 'Takashi Iwai'
> Cc: 'alsa-devel@alsa-project.org'
> Subject:
> 
> Hi Takashi,
> 
> This patch is to support detecting new AMD HD Audio devices with HDA
PCI
> class code. Would you please review it? Thanks a lot!
> --------------------------------------------------------------------
> 
> Signed-off-by: Libin Yang <libin.yang@amd.com>
> 
> --- alsa-driver-1.0.18.orig/alsa-kernel/pci/hda/hda_intel.c
2008-10-29
> 20:41:35.000000000 +0800
> +++ alsa-driver-1.0.18/alsa-kernel/pci/hda/hda_intel.c
2008-11-11
> 18:33:14.000000000 +0800
> @@ -291,6 +291,7 @@
>  /* Define VIA HD Audio Device ID*/
>  #define VIA_HDAC_DEVICE_ID		0x3288
> 
> +#define PCI_CLASS_MULTIMEDIA_HDA	0x040300
> 
>  /*
>   */
> @@ -410,6 +411,7 @@
>  	AZX_DRIVER_ULI,
>  	AZX_DRIVER_NVIDIA,
>  	AZX_DRIVER_TERA,
> +	AZX_DRIVER_AMD_AUTO,
>  	AZX_NUM_DRIVERS, /* keep this as last entry */
>  };
> 
> @@ -423,6 +425,7 @@
>  	[AZX_DRIVER_ULI] = "HDA ULI M5461",
>  	[AZX_DRIVER_NVIDIA] = "HDA NVidia",
>  	[AZX_DRIVER_TERA] = "HDA Teradici",
> +	[AZX_DRIVER_AMD_AUTO] = "HDA AMD",
>  };
> 
>  /*
> @@ -1198,6 +1201,7 @@
>  static unsigned int azx_default_codecs[AZX_NUM_DRIVERS] __devinitdata
= {
>  	[AZX_DRIVER_ICH] = 3,
>  	[AZX_DRIVER_ATI] = 3,
> +	[AZX_DRIVER_AMD_AUTO] = 3,
>  };
> 
>  static int __devinit azx_codec_create(struct azx *chip, const char
*model,
> @@ -2146,6 +2150,7 @@
>  			chip->playback_streams = ULI_NUM_PLAYBACK;
>  			chip->capture_streams = ULI_NUM_CAPTURE;
>  			break;
> +		case AZX_DRIVER_AMD_AUTO:
>  		case AZX_DRIVER_ATIHDMI:
>  			chip->playback_streams = ATIHDMI_NUM_PLAYBACK;
>  			chip->capture_streams = ATIHDMI_NUM_CAPTURE;
> @@ -2373,6 +2378,9 @@
>  	{ PCI_DEVICE(0x10de, 0x0bd7), .driver_data = AZX_DRIVER_NVIDIA
},
>  	/* Teradici */
>  	{ PCI_DEVICE(0x6549, 0x1200), .driver_data = AZX_DRIVER_TERA },
> +	/* AMD Generic, PCI class code and Vendor ID for HD Audio */
> +	{ PCI_VENDOR_ID_ATI, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> +	  PCI_CLASS_MULTIMEDIA_HDA, 0xffffff, AZX_DRIVER_AMD_AUTO },
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, azx_ids);
> 
> Thanks & Regards,
> Libin
