From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] [ALSA] Allow setting codec register
	with	debugfs filesystem
Date: Tue, 7 Oct 2008 23:15:34 +0100
Message-ID: <20081007221533.GA7291@sirena.org.uk>
References: <1223413435-17571-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A0D8D2434D
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 00:15:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1223413435-17571-1-git-send-email-troy.kisky@boundarydevices.com>
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

On Tue, Oct 07, 2008 at 02:03:55PM -0700, Troy Kisky wrote:

Thanks for this - looks good.  A few comments below, nitpicks rather
than anything substantial.

> +#ifdef CONFIG_SND_SOC_DEBUG_FS
> +	struct dentry	*debugfs_root;
> +	struct dentry	*debugfs_codec_reg;
> +#endif

It would be better to just make this conditional on debugfs support -
this isn't sufficiently high cost to make the additional complexity
worthwhile.  This is the general idiom for debugfs.

> +static ssize_t code_reg_read_file(struct file *file, char __user *user_buf,
> +			       size_t count, loff_t *ppos)
> +{
> +	ssize_t res;

ret would be more consistent with the rest of ASoC (told you I was
picking nits).

> +	struct snd_soc_device *devdata = file->private_data;
> +	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);

It should check for out of memory here.  If we ever get codecs with
enormous register maps we'll need to worry about PAGE_SIZE but that's an
issue for sysfs too and not an issue currently.

> +static void soc_init_debugfs(struct snd_soc_device *socdev)
> +{
> +	struct dentry *root, *debugfs_codec_reg;
> +	root = debugfs_create_dir(dev_name(socdev->dev), NULL);
> +	if (IS_ERR(root) || !root)
> +		goto exit1;

There's an existing debugfs file (the DAPM pop time configuration) which
I'd expect to be handled by this function - it should probably be
renamed to something like soc_init_codec_debugfs().

The directory should probably be a subdirectory of that created by DAPM,
or you could just put the codec register file in that directly until we
support two codecs (which will needs updates to the sysfs code anyway).

> +	debugfs_codec_reg = debugfs_create_file("codec_reg", 0644,
> +			root, socdev, &codec_reg_fops);
> +	if (!debugfs_codec_reg)
> +		goto exit2;

> +
> +	socdev->debugfs_root = root;

> +static void soc_cleanup_debugfs(struct snd_soc_device *socdev)
> +{
> +	debugfs_remove(socdev->debugfs_codec_reg);

debugfs directory removal is recursive so no need to do this (or
remember the file) unless you put it in the directory with the DAPM file.
