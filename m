From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Allocate PCM operations dynamically
 to support multiple DAIs
Date: Tue, 27 Dec 2011 10:40:05 +0000
Message-ID: <20111227104005.GC2870@opensource.wolfsonmicro.com>
References: <CANh+=Y-xM6hq6N1umMxR4PATBj-OmKkfHoSpnzR5q2kjt2b79g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 96D2C2465C
	for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2011 11:40:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANh+=Y-xM6hq6N1umMxR4PATBj-OmKkfHoSpnzR5q2kjt2b79g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangsu Park <sangsu@gmail.com>
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, lars@metafoo.de, lrg@ti.com, sangsu4u.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 27, 2011 at 05:06:56PM +0900, Sangsu Park wrote:

> +       /* free the ops memory */
> +       if (rtd->ops) kfree(rtd->ops);

We shouldn't be doing a kfree() on the ops at all.

> +++ b/sound/soc/soc-pcm.c
> @@ -641,22 +645,23 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
>         INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
>         rtd->pcm = pcm;
> +       rtd->ops = soc_pcm_ops;

That *might* work if ops were changed to be a member variable, though
it's racy against two things initializing simultaneously.  

What I'd expect is something like:

        INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
	rtd->pcm = pcm;
	rtd->pcm_ops = soc_pcm_ops;
	pcm->private_data = rtd;
	if (platform->driver->ops) {
		rtd->pcm_ops.mmap = platform->driver->ops->mmap;
		rtd->pcm_ops.pointer = platform->driver->ops->pointer;


and so on so we start off by taking a copy of the default ops then copy
the new ops in in the same fashion.  

Ideally we should also have an indirection for ioctl() though using it
at all is dodgy.
