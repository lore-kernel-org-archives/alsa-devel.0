From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: DaVinci: Added support based on
 copy_from_user instead of DMA
Date: Tue, 3 Aug 2010 16:13:45 +0100
Message-ID: <20100803151345.GH25306@rakim.wolfsonmicro.main>
References: <1279291619-5081-1-git-send-email-lamiaposta71@gmail.com>
	<1279291619-5081-3-git-send-email-lamiaposta71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 48394244E4
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Aug 2010 17:13:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279291619-5081-3-git-send-email-lamiaposta71@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raffaele Recalcati <lamiaposta71@gmail.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, Troy Kisky <troy.kisky@boundarydevices.com>, Davide Bonfanti <davide.bonfanti@bticino.it>, Raffaele Recalcati <raffaele.recalcati@bticino.it>, Chaithrika U S <chaithrika@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 16, 2010 at 04:46:58PM +0200, Raffaele Recalcati wrote:
> From: Davide Bonfanti <davide.bonfanti@bticino.it>
> 
>     This driver implements a pcm interface without the use of a DMA but with
>     a copy_from_user.
>     There's a buffer in the driver that is filled with davinci_pcm_copy.
>     When pcm is running, a TIMER interrupt is activated in order to fill
>     HW FIFO.
>     BUG: It happens sometimes that the peripheral stops working so there's a
>     trap.

Looking at this code the main thing that jumps out at me is that it
doesn't look at all DaVinci specific - all the interaction with the
hardware is hidden behind the ops structure you've defined, though the
ops structure doesn't define things like the maximum number of channels
and sample rate which I'd expect it to.  This suggests that either the
patch shouldn't be DaVinci specific or the splitting out of the ops
structure isn't adding anything.

> +int pointer_sub;

These should all be static.

> +int hw_fifo_size;
> +u16 *local_buffer;
> +static struct hrtimer hrtimer;
> +struct snd_pcm_substream *substream_loc;
> +int ns_for_interrupt = 1500000;

Magic number?

> +       gpio_set_value(69, 0);

Magic number again, and nothing requests this GPIO either.  Looks like
another thing for the ops structure.
