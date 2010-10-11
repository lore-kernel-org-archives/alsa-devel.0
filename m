From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch] ASoC: soc: snprintf() doesn't return
	negative
Date: Mon, 11 Oct 2010 11:40:09 +0100
Message-ID: <20101011104009.GB9231@rakim.wolfsonmicro.main>
References: <20101011035416.GD5851@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8A87A2444D
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 12:40:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20101011035416.GD5851@bicker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <error27@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 11, 2010 at 05:54:17AM +0200, Dan Carpenter wrote:
> In user space snprintf() returns negative on errors but the kernel
> version only returns positives.  It could potentially return sizes

I'm not going to apply this.  snprintf() returns a signed type, checking
that the return value is a reasonable thing to do here - at worst we're
wasting a few cycles in code that's nowhere near a hot path, at best
we're robust in the face of a decision to add error reporting to
snprintf() so it's hard to see this change as an improvement.

> larger than the size of the buffer so we should check for that.

> -	if (ret >= 0)
> -		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
> +	if (ret > PAGE_SIZE)
> +		ret = PAGE_SIZE;
> +
> +	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);

The PAGE_SIZE part of the change has an issue too, the code immediately
preceeding this is:

	list_for_each_entry(codec, &codec_list, list)
		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
				codec->name);

so it's rather late to be worrying about PAGE_SIZE after the loop.

Please also try to be a bit more thoughtful in your use of
get_maintainers; try to have a look at why people have come up and
consider if it's really sensible to include them.
