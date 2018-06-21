From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 6/9] ALSA: usb: caiaq: use
	usb_fill_int_urb()
Date: Thu, 21 Jun 2018 22:19:32 +0200
Message-ID: <2f8cbd9b-55ad-d543-d26a-c4452717b121@zonque.org>
References: <20180619215521.13688-1-bigeasy@linutronix.de>
 <20180619215521.13688-7-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A4D4267610
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 22:19:37 +0200 (CEST)
In-Reply-To: <20180619215521.13688-7-bigeasy@linutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, alsa-devel@alsa-project.org
Cc: tglx@linutronix.de, linux-usb@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday, June 19, 2018 11:55 PM, Sebastian Andrzej Siewior wrote:
> Using usb_fill_int_urb() helps to find code which initializes an
> URB. A grep for members of the struct (like ->complete) reveal lots
> of other things, too.

Acked-by: Daniel Mack <zonque@gmail.com>

> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   sound/usb/caiaq/audio.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
> index 15344d39a6cd..e10d5790099f 100644
> --- a/sound/usb/caiaq/audio.c
> +++ b/sound/usb/caiaq/audio.c
> @@ -736,16 +736,17 @@ static struct urb **alloc_urbs(struct snd_usb_caiaqdev *cdev, int dir, int *ret)
>   	}
>   
>   	for (i = 0; i < N_URBS; i++) {
> +		void *buf;
> +
>   		urbs[i] = usb_alloc_urb(FRAMES_PER_URB, GFP_KERNEL);
>   		if (!urbs[i]) {
>   			*ret = -ENOMEM;
>   			return urbs;
>   		}
>   
> -		urbs[i]->transfer_buffer =
> -			kmalloc_array(BYTES_PER_FRAME, FRAMES_PER_URB,
> -				      GFP_KERNEL);
> -		if (!urbs[i]->transfer_buffer) {
> +		buf = kmalloc_array(BYTES_PER_FRAME, FRAMES_PER_URB,
> +				    GFP_KERNEL);
> +		if (!buf) {
>   			*ret = -ENOMEM;
>   			return urbs;
>   		}
> @@ -758,15 +759,13 @@ static struct urb **alloc_urbs(struct snd_usb_caiaqdev *cdev, int dir, int *ret)
>   			iso->length = BYTES_PER_FRAME;
>   		}
>   
> -		urbs[i]->dev = usb_dev;
> -		urbs[i]->pipe = pipe;
> -		urbs[i]->transfer_buffer_length = FRAMES_PER_URB
> -						* BYTES_PER_FRAME;
> -		urbs[i]->context = &cdev->data_cb_info[i];
> -		urbs[i]->interval = 1;
> +		usb_fill_int_urb(urbs[i], usb_dev, pipe, buf,
> +				 FRAMES_PER_URB * BYTES_PER_FRAME,
> +				 (dir == SNDRV_PCM_STREAM_CAPTURE) ?
> +				 read_completed : write_completed,
> +				 &cdev->data_cb_info[i], 1);
> +
>   		urbs[i]->number_of_packets = FRAMES_PER_URB;
> -		urbs[i]->complete = (dir == SNDRV_PCM_STREAM_CAPTURE) ?
> -					read_completed : write_completed;
>   	}
>   
>   	*ret = 0;
> 
