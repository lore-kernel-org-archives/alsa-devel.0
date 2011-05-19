From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v5] radio-sf16fmr2: convert to generic
	TEA575x interface
Date: Thu, 19 May 2011 22:56:44 +0200
Message-ID: <201105192256.44127.hverkuil@xs4all.nl>
References: <201105140017.26968.linux@rainbow-software.org>
	<201105190845.38194.hverkuil@xs4all.nl>
	<201105191815.46658.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-vbr5.xs4all.nl (smtp-vbr5.xs4all.nl [194.109.24.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 418AB103804
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 22:57:02 +0200 (CEST)
In-Reply-To: <201105191815.46658.linux@rainbow-software.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thursday, May 19, 2011 18:15:43 Ondrej Zary wrote:
> Convert radio-sf16fmr2 to use generic TEA575x implementation. Most of the
> driver code goes away as SF16-FMR2 is basically just a TEA5757 tuner
> connected to ISA bus.
> The card can optionally be equipped with PT2254A volume control (equivalent
> of TC9154AP) - the volume setting is completely reworked (with balance control
> added) and tested.
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

Acked-by: Hans Verkuil <hverkuil@xs4all.nl>

Except for one tiny little typo:

> --- linux-2.6.39-rc2-/drivers/media/radio/radio-sf16fmr2.c	2011-04-06 03:30:43.000000000 +0200
> +++ linux-2.6.39-rc2/drivers/media/radio/radio-sf16fmr2.c	2011-05-19 17:56:08.000000000 +0200
> +static int fmr2_tea_ext_init(struct snd_tea575x *tea)
>  {
> -	return a->index ? -EINVAL : 0;
> -}
> +	struct fmr2 *fmr2 = tea->private_data;
>  
> -static const struct v4l2_file_operations fmr2_fops = {
> -	.owner          = THIS_MODULE,
> -	.unlocked_ioctl = video_ioctl2,
> -};
> +	if (inb(fmr2->io) & FMR2_HASVOL) {
> +		fmr2->volume = v4l2_ctrl_new_std(&tea->ctrl_handler, &fmr2_ctrl_ops, V4L2_CID_AUDIO_VOLUME, 0, 68, 2, 56);
> +		fmr2->balance = v4l2_ctrl_new_std(&tea->ctrl_handler, &fmr2_ctrl_ops, V4L2_CID_AUDIO_BALANCE, -68, 68, 2, 0);
> +		if (tea->ctrl_handler.error) {
> +			printk(KERN_ERR "radio-sf16fmr2: can't initialize contrls\n");

contrls -> controls

> +			return tea->ctrl_handler.error;
> +		}
> +	}
