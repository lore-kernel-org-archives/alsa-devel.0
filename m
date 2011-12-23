From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Allocate PCM operations dynamically
 to support multiple DAIs
Date: Fri, 23 Dec 2011 10:24:14 +0000
Message-ID: <20111223102413.GB2834@opensource.wolfsonmicro.com>
References: <053701ccc113$7c39bd80$74ad3880$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DE5E62441C
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 11:24:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <053701ccc113$7c39bd80$74ad3880$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, sangsu4u.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 23, 2011 at 10:37:51AM +0900, Sangbeom Kim wrote:

> +	soc_pcm_ops = kzalloc(sizeof(*soc_pcm_ops), GFP_KERNEL);
> +	if (soc_pcm_ops == NULL) {
> +		snd_printk(KERN_ERR "Cannot allocate PCM OPS\n");
> +		return -ENOMEM;
> +	}

This patch is good and fixes a real problem but can you please change it
slightly so that instead of dynamically allocating the soc_pcm_ops we
just embed it directly in the runtime structure.  Since every runtime
needs an ops structure we may as well just have it embedded directly and
not write the allocation, freeing and error handling code.
