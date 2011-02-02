From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: Support debugfs entries
 larger than PAGE_SIZE bytes
Date: Wed, 2 Feb 2011 13:07:41 +0000
Message-ID: <20110202130741.GP12743@opensource.wolfsonmicro.com>
References: <1296646145-2356-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17599103827
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 14:07:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296646145-2356-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 02, 2011 at 11:29:05AM +0000, Dimitris Papastamos wrote:

> +/* fill buf which is 'len' bytes with a formatted
> + * string of the form 'reg: value\n' */
> +static int format_register_str(struct snd_soc_codec *codec,
> +			       unsigned int regidx, char *buf, size_t len)

The naming of regidx is really inconsistent with the rest of the code
which pretty much always calls registers reg.

> +	/* we don't currently handle failed reads */
> +	ret = snd_soc_read(codec , regidx);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Failed to read from %#x\n", regidx);
> +		return ret;
> +	}

I'd suggest filling the field with some obvious out of bound character
such as X.

> +	if (ret >= 0) {
> +		if (!access_ok(VERIFY_WRITE, user_buf, ret)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		if (copy_to_user(user_buf, buf, ret)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}

Why do we need the access_ok() here?  I'd really expect copy_to_user()
to do the right thing here and simple_read_from_buffer() doesn't do
this.
