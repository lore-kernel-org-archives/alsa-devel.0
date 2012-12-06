From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 20/20] ALSA: snd-usb-caiaq: remove __dev*
	attributes
Date: Thu, 06 Dec 2012 18:36:10 +0100
Message-ID: <50C0D78A.2020900@gmail.com>
References: <1354815329-20221-1-git-send-email-wfp5p@virginia.edu>
 <1354815329-20221-21-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 6985B2625D3
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 18:36:13 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so2731966bkc.38
 for <alsa-devel@alsa-project.org>; Thu, 06 Dec 2012 09:36:13 -0800 (PST)
In-Reply-To: <1354815329-20221-21-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06.12.2012 18:35, Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option.  As result the __dev*
> markings will be going away.
> 
> Remove use of __devinit, __devexit_p, __devinitdata, __devinitconst,
> and __devexit.
> 
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Daniel Mack <zonque@gmail.com>

Acked-by: Daniel Mack <zonque@gmail.com>


Thanks!

Daniel


> ---
>  sound/usb/caiaq/control.c | 8 ++++----
>  sound/usb/caiaq/device.c  | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/usb/caiaq/control.c b/sound/usb/caiaq/control.c
> index 00e5d0a..adb8d03 100644
> --- a/sound/usb/caiaq/control.c
> +++ b/sound/usb/caiaq/control.c
> @@ -137,7 +137,7 @@ static int control_put(struct snd_kcontrol *kcontrol,
>  	return 1;
>  }
>  
> -static struct snd_kcontrol_new kcontrol_template __devinitdata = {
> +static struct snd_kcontrol_new kcontrol_template = {
>  	.iface = SNDRV_CTL_ELEM_IFACE_HWDEP,
>  	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
>  	.index = 0,
> @@ -489,8 +489,8 @@ static struct caiaq_controller kontrols4_controller[] = {
>  	{ "LED: FX2: Mode",			133 | CNT_INTVAL },
>  };
>  
> -static int __devinit add_controls(struct caiaq_controller *c, int num,
> -				  struct snd_usb_caiaqdev *dev)
> +static int add_controls(struct caiaq_controller *c, int num,
> +			struct snd_usb_caiaqdev *dev)
>  {
>  	int i, ret;
>  	struct snd_kcontrol *kc;
> @@ -507,7 +507,7 @@ static int __devinit add_controls(struct caiaq_controller *c, int num,
>  	return 0;
>  }
>  
> -int __devinit snd_usb_caiaq_control_init(struct snd_usb_caiaqdev *dev)
> +int snd_usb_caiaq_control_init(struct snd_usb_caiaqdev *dev)
>  {
>  	int ret = 0;
>  
> diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
> index 7da0d0a..c828f81 100644
> --- a/sound/usb/caiaq/device.c
> +++ b/sound/usb/caiaq/device.c
> @@ -289,7 +289,7 @@ int snd_usb_caiaq_set_auto_msg(struct snd_usb_caiaqdev *dev,
>  					  tmp, sizeof(tmp));
>  }
>  
> -static void __devinit setup_card(struct snd_usb_caiaqdev *dev)
> +static void setup_card(struct snd_usb_caiaqdev *dev)
>  {
>  	int ret;
>  	char val[4];
> @@ -407,7 +407,7 @@ static int create_card(struct usb_device *usb_dev,
>  	return 0;
>  }
>  
> -static int __devinit init_card(struct snd_usb_caiaqdev *dev)
> +static int init_card(struct snd_usb_caiaqdev *dev)
>  {
>  	char *c, usbpath[32];
>  	struct usb_device *usb_dev = dev->chip.dev;
> @@ -481,7 +481,7 @@ static int __devinit init_card(struct snd_usb_caiaqdev *dev)
>  	return 0;
>  }
>  
> -static int __devinit snd_probe(struct usb_interface *intf,
> +static int snd_probe(struct usb_interface *intf,
>  		     const struct usb_device_id *id)
>  {
>  	int ret;
> 
