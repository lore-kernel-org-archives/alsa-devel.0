From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/1] [ALSA] Allow setting codec register
	with debugfs filesystem
Date: Tue, 14 Oct 2008 10:46:08 +0100
Message-ID: <20081014094607.GC14538@sirena.org.uk>
References: <1223944934-24546-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 33AD32447A
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 11:46:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1223944934-24546-1-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 13, 2008 at 05:42:14PM -0700, Troy Kisky wrote:

Thanks.

> @@ -425,6 +425,7 @@ struct snd_soc_codec {
>  	short reg_cache_step;
>  
>  	/* dapm */
> +	u32 pop_time;
>  	struct list_head dapm_widgets;

Hrm.  On the one hand this is deliberately a system-wide bit of
configuration since the pop/click sequencing covers the whole system
rather than just the codec.  On the other hand the codec structure does,
unfortunately, represent the entire sound device currently.  I'll have a
think and either push the patch as-is or push it together with a
followup patch moving the pop time configuration out of the codec
structure.

> +}
> +
>  static DEVICE_ATTR(codec_reg, 0444, codec_reg_show, NULL);

Extra blank line added here.

> +	file = debugfs_create_file("codec_reg", 0644,
> +			root, socdev, &codec_reg_fops);
> +	if (!file)
> +		goto exit2;
> +
> +	file = debugfs_create_u32("dapm_pop_time", 0744,
> +			root, &codec->pop_time);
> +	if (!file)
> +		goto exit2;

There's no real need to handle these errors - if anything, it's probably
better to half create the tree 

> +exit1:
> +	dev_err(socdev->dev, "debugfs is not available\n");
> +}

This isn't actually an error...
