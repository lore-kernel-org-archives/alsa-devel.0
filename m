From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/10] ALSA: add AXD Audio Processing IP alsa driver
Date: Wed, 26 Aug 2015 19:37:00 +0100
Message-ID: <20150826183700.GD28760@sirena.org.uk>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-4-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440419959-14315-4-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2015 at 01:39:12PM +0100, Qais Yousef wrote:

> +#define THREAD_COUNT 4

This is a very generic name that looks likely to collide with something
else, please namespace.

> +#define AXD_INPUT_DESCRIPTORS 10
> +struct axd_input {
> +	struct axd_buffer_desc descriptors[AXD_INPUT_DESCRIPTORS];
> +};

Where do these numbers come from?  Are they hardware limits or something
else?

> +/* this is required by MIPS ioremap_cachable() */
> +#include <asm/pgtable.h>

Don't work around this here, fix it in the relevant header.

> +#define AXD_BASE_VADDR		0xD0000000

This sounds like something that is going to be platform dependant,
should this be supplied from board configuration?

> +extern struct snd_compr_ops axd_compr_ops;

Prototype shared definitions in headers not in C files please so we know
the definition matches.

> +static struct snd_soc_dai_driver axd_dai[] = {
> +	{

Why an array with only one entry?

> +	if (!*offp) {
> +		unsigned int flags = axd_platform_lock();
> +		unsigned int log_offset = ioread32(log_addr);
> +		unsigned int log_wrapped = ioread32(log_addr + 8);
> +		char __iomem *log_buff = (char __iomem *)(log_addr + 12);
> +
> +		/* new read from beginning, fill up our internal buffer */
> +		if (!log_wrapped) {
> +			memcpy_fromio(axd->log_rbuf, log_buff, log_offset);
> +			axd->log_rbuf_rem = log_offset;
> +		} else {
> +			char __iomem *pos = log_buff + log_offset;
> +			unsigned int rem = log_size - log_offset;
> +
> +			memcpy_fromio(axd->log_rbuf, pos, rem);
> +			memcpy_fromio(axd->log_rbuf + rem, log_buff, log_offset);
> +			axd->log_rbuf_rem = log_size;
> +		}
> +		axd_platform_unlock(flags);

I didn't see the lock being taken?

> +static ssize_t axd_write_mask(struct file *filep,
> +				const char __user *buff, size_t count, loff_t *offp)
> +{
> +	struct axd_dev *axd = filep->f_inode->i_private;
> +	unsigned int mask;
> +	char buffer[32] = {};
> +	int ret;
> +
> +	/* ensure we always have null at the end */
> +	ret = copy_from_user(buffer, buff, min(31u, count));
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!kstrtouint(buffer, 0, &mask))
> +		axd_write_reg(&axd->cmd, AXD_REG_DEBUG_MASK, mask);

What are we writing here?  If we're going behind the driver's back on
something that might confuse it it's generally better to taint the
kernel so we know dodgy stuff happened later on.

> +static void axd_debugfs_create(struct axd_dev *axd)
> +{
> +	axd->debugfs = debugfs_create_dir(dev_name(axd->dev), NULL);
> +	if (IS_ERR_OR_NULL(axd->debugfs)) {
> +		dev_err(axd->dev, "failed to create debugfs node\n");
> +		return;
> +	}

It'd be nicer to create this under the relevant ASoC debugfs directory
so it's easier to find.

> +#ifdef CONFIG_CRYPTO_LZO
> +#include <linux/crypto.h>

This include should be with all the other includes, not down here.

> +	size = axd->fw_size;
> +	cached_fw_base = (char *)CAC_ADDR((int)axd->fw_base_m);
> +	ret = crypto_comp_decompress(tfm, fw->data + 8,
> +				fw->size - 8, cached_fw_base, &size);
> +	if (ret)
> +		dev_err(axd->dev, "Failed to decompress the firmware\n");

Print return codes if you get them.

> +
> +	if (size != axd->fw_size) {
> +		dev_err(axd->dev, "Uncompressed file size doesn't match reported file size\n");
> +		ret = -EINVAL;
> +	}

Should we be checking this if the decompression failed?

> +}
> +#else /* !CONFIG_CRYPTO_LZO */
> +static int decompress_fw(struct axd_dev *axd, const struct firmware *fw)

Blank lines between things please.

> +{
> +	dev_err(axd->dev, "The firmware must be lzo decompressed first, compile driver again with CONFIG_CRYPTO_LZO enabled in kernel or do the decompression in user space.\n");

Please split this up into a few prints for wrapping, similarly in
several other places.

> +	return -EIO;

-ENOTSUPP.

> +		return -EIO;
> +	}
> +	/*

More vertical blanks missing.

> +	 * We copy through the cache, fw will do the necessary cache
> +	 * flushes and syncing at startup.
> +	 * Copying from uncached makes it more difficult for the
> +	 * firmware to keep the caches coherent with memory when it sets
> +	 * tlbs and start running.
> +	 */
> +	memcpy_toio((void *)cached_fw_base, fw->data, fw->size);

Why the cast here?  I'm also not seeing where we handled the copying to
I/O in the decompression case?

> +	dev_info(axd->dev, "Loading firmware at 0x%p ...\n", axd->fw_base_m);

This should be _dbg() at most, otherwise it's going to get noisy.

> +	t0_new_pc = (unsigned long) axd->fw_base_m + (t0_new_pc - AXD_BASE_VADDR);

Those casts look fishy...

> +	for (i = 0; i < AXD_LDFW_RETRIES; i++) {
> +		ret = axd_wait_ready(axd_cmd->message);
> +		if (!ret) {
> +			/*
> +			 * Let the firmware know the address of the buffer
> +			 * region
> +			 */
> +			ret = axd_write_reg(axd_cmd,
> +					AXD_REG_BUFFER_BASE, axd->buf_base_p);
> +			if (ret) {
> +				dev_err(axd->dev,
> +					"Failed to setup buffers base address\n");

Again print errors please.

> +				goto out;
> +			}
> +			return 0;
> +
> +		}
> +	}

I'm not seeing any diagnostics if we fall out of the retry loop here?

> +static void axd_reset(struct work_struct *work)
> +{
> +	unsigned int major, minor, patch;
> +	int i;
> +
> +	struct axd_dev *axd = container_of(work, struct axd_dev, watchdogwork);
> +
> +
> +	/* if we got a fatal error, don't reset if watchdog is disabled */
> +	if (unlikely(!axd->cmd.watchdogenabled))
> +		return;

There's generally no need for unlikely() annotations outside of hot
paths.

> +	/* stop the watchdog timer until we restart */
> +	del_timer(&axd->watchdogtimer);

I'd expect del_timer_sync() to make sure that the timer stopped.

> +	if (!axd_get_flag(&axd->cmd.fw_stopped_flg)) {
> +		/* ping the firmware by requesting its version info */
> +		axd_cmd_get_version(&axd->cmd, &major, &minor, &patch);
> +		if (!major && !minor && !patch) {
> +			dev_warn(axd->dev, "Firmware stopped responding...\n");
> +			axd_set_flag(&axd->cmd.fw_stopped_flg, 1);
> +		} else {
> +			goto out;
> +		}
> +	}

It might be useful to display the firmware version we loaded.

> +	axd_platform_print_regs();
> +	dev_warn(axd->dev, "Reloading AXD firmware...\n");

This is going to get noisy and isn't adding much.

> +	/* wake up any task sleeping on command response */
> +	wake_up(&axd->cmd.wait);
> +	/* give chance to user land tasks to react to the crash */
> +	ssleep(2);

This looks horribly racy, I'd expect us to be trashing and/or killing
off any active work and resources here.

> +static void axd_watchdog_timer(unsigned long arg)
> +{
> +	struct axd_dev *axd = (struct axd_dev *)arg;
> +
> +	/* skip if watchdog is not enabled */
> +	if (unlikely(!axd->cmd.watchdogenabled))
> +		goto out;
> +
> +	schedule_work(&axd->watchdogwork);
> +	return;
> +out:
> +	mod_timer(&axd->watchdogtimer, jiffies + WATCHDOG_TIMEOUT);
> +}

So we have a timer that just schedules some work?  Why not just
schedule_delayed_work()?

> +	/*
> +	 * Verify that the firmware is ready. In normal cases the firmware
> +	 * should start immediately, but to be more robust we do this
> +	 * verification and give the firmware a chance of 3 seconds to be ready
> +	 * otherwise we exit in failure.
> +	 */
> +	for (i = 0; i < AXD_LDFW_RETRIES; i++) {
> +		axd_cmd_get_version(&axd->cmd, &major, &minor, &patch);
> +		if (major || minor || patch) {
> +			/* firmware is ready */
> +			break;
> +		}
> +		/* if we couldn't read the version after 3 tries, error */
> +		if (i == AXD_LDFW_RETRIES - 1) {
> +			dev_err(axd->dev, "Failed to communicate with the firmware\n");
> +			ret = -EIO;
> +			goto error;
> +		}
> +		/* wait for 10 ms for the firmware to start */
> +		msleep(10);
> +	}
> +	dev_info(axd->dev, "Running firmware version %u.%u.%u %s\n",
> +				major, minor, patch, axd_hdr_get_build_str());

Why is this code not shared with the restart case?

> +	ret = of_property_read_u32_array(of_node, "gic-irq", val, 2);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +				"'gic-irq' parameter must be set\n");
> +		return ret;
> +	}

This appears to have a DT binding but the binding is not documented.
All new DT bindings must be documented.  I'm concerned that some of the
properties being read from DT may not be ideal here...

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3gdLAAoJECTWi3JdVIfQINoH/RRlWWmjGCy9rNQFdW4GGx91
Is9w4xGhrBc7YQ5S/VPEIqvy7ctW8IQVsuTEwm5vI5WuEa9Kuvl4+bJi6luPnkRh
cuFJo/uENZDUw4Udl2BTKS8X8m6g7qv2dok1iBb23uV16zaTiymVr/4K8ufygaIK
Nd8HbJygPdPTFV9v+Tpt7DMhDDCeKXxjOI44z27L+x/1mSR7xn6WaBazbexAlwrH
lEat6pjBjZUd7CwVvQoHRqnHwasyrEuKKFmCw8IhpJ+kHfR987s4iycw2881rjx+
qjyhDK54LJy9yo4T5LbUZEqEVp3afhdHxbCJ3JVeFHbEFGcN43xM57ONuAEtdC0=
=+AHc
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
