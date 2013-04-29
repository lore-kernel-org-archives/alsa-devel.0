From: Daniel Mack <zonque@gmail.com>
Subject: Re: ALSA: usb-audio: caiaq: endianness bug
Date: Mon, 29 Apr 2013 20:33:56 +0200
Message-ID: <517EBD14.7030904@gmail.com>
References: <alpine.LNX.2.00.1304291957510.6097@xoschi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f43.google.com (mail-bk0-f43.google.com
 [209.85.214.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B0FD9261609
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 20:33:57 +0200 (CEST)
Received: by mail-bk0-f43.google.com with SMTP id jm19so2839861bkc.16
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 11:33:57 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1304291957510.6097@xoschi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eldad Zack <eldad@fogrefinery.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 29.04.2013 20:10, Eldad Zack wrote:
> 
> Hi Daniel,
> 
> I think I found a endian usage issue in the caiaq driver. I have a patch 
> to fix it (below), but it assumes that the driver works currently on 
> little endian CPUs - I don't have a device to test it with.

I don't currently have any either, but your findings make sense. I just
know that the driver currently works on LE CPUs.

> Cheers,
> Eldad
> 
> -- >8 --
> Subject: [PATCH] ALSA: usb-audio: caiaq: fix endianness bug
> 
> Current code does this:
> 
>   be16_to_cpu(buf[i * 2] << 8 | buf[(i * 2) + 1])
> 
> Which is effectively:
> 
>   be16_to_cpu(be16_to_cpu(*((u16 *) buf)))
> 
> This means the int16 in the buffer is not converted at all.
> Assuming the device-side structure is actually little endian,
> change the code to use le16_to_cpu().
> 
> Signed-off-by: Eldad Zack <eldad@fogrefinery.com>

Acked-by: Daniel Mack <zonque@gmail.com>

> ---
>  sound/usb/caiaq/input.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
> index efc70ae..2f4ae4d 100644
> --- a/sound/usb/caiaq/input.c
> +++ b/sound/usb/caiaq/input.c
> @@ -488,13 +488,12 @@ static void snd_usb_caiaq_maschine_dispatch(struct snd_usb_caiaqdev *cdev,
>  					unsigned int len)
>  {
>  	unsigned int i, pad_id;
> -	uint16_t pressure;
> +	__le16 *pressure = (__le16 *) buf;
>  
>  	for (i = 0; i < MASCHINE_PADS; i++) {
> -		pressure = be16_to_cpu(buf[i * 2] << 8 | buf[(i * 2) + 1]);
> -		pad_id = pressure >> 12;
> -
> -		input_report_abs(cdev->input_dev, MASCHINE_PAD(pad_id), pressure & 0xfff);
> +		pad_id = le16_to_cpu(*pressure) >> 12;
> +		input_report_abs(cdev->input_dev, MASCHINE_PAD(pad_id), le16_to_cpu(*pressure) & 0xfff);
> +		pressure++;
>  	}
>  
>  	input_sync(cdev->input_dev);
> 
