From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/14] soundwire: Add IO transfer
Date: Sat, 21 Oct 2017 10:29:08 +0100
Message-ID: <20171021092908.yevlinnkiv5lzus3@sirena.org.uk>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2510666206872561361=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CED14266DF5
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 11:29:21 +0200 (CEST)
In-Reply-To: <1508382211-3154-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============2510666206872561361==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r5zrqzgzswqfbr6h"
Content-Disposition: inline


--r5zrqzgzswqfbr6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2017 at 08:33:22AM +0530, Vinod Koul wrote:

> +static bool sdw_get_page(struct sdw_slave *slave, struct sdw_msg *msg)
> +{
> +	bool page = false, paging_support = false;
> +
> +	if (slave && slave->prop.paging_support)
> +		paging_support = true;
> +
> +	/*
> +	 * Programme SCP page addr for:
> +	 * 1. addr_page1 and addr_page2 contains non-zero values.
> +	 * 2. Paging supported by Slave.
> +	 */
> +	switch (msg->dev_num) {
> +	case SDW_ENUM_DEV_NUM:
> +	case SDW_BROADCAST_DEV_NUM:
> +		break;
> +
> +	default:
> +		if (paging_support && ((msg->addr_page1) || (msg->addr_page2)))
> +			page = true;
> +	}
> +
> +	return page;

So if a page was specified but we don't have paging support we silently
just write to the base pagee?

> +int sdw_transfer(struct sdw_bus *bus, struct sdw_slave *slave,
> +					struct sdw_msg *msg)
> +{
> +	bool page;
> +	int ret;
> +
> +	mutex_lock(&bus->msg_lock);
> +
> +	page = sdw_get_page(slave, msg);

get_page() doesn't interact with the hardware at all so it could be
outside the lock.

> +	ret = do_transfer(bus, msg, page);
> +	if (ret != 0 && ret != -ENODATA) {
> +		dev_err(bus->dev, "trf on Slave %d failed:%d\n",
> +				msg->dev_num, ret);
> +		goto error;
> +	}
> +
> +	if (page)
> +		ret = sdw_reset_page(bus, msg->dev_num);

Wouldn't it be safer to reset the page even on error so future messages
go to the right place if the paging bit of the failed operation worked?

> +int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
> +{
> +	struct sdw_msg msg;
> +	int ret;
> +
> +	pm_runtime_get_sync(slave->bus->dev);

No error check.

> +	pm_runtime_get_sync(slave->bus->dev);
> +
> +	sdw_fill_msg(&msg, addr, count, slave->dev_num, SDW_MSG_FLAG_WRITE, val);

The device doesn't need to be powered up for us to fill in the data
structures we're going to use.

--r5zrqzgzswqfbr6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnrE2QACgkQJNaLcl1U
h9DjXAf/cVCY93eaMsz/8ug2qHUXMuIJ1f7Ii8FgdVzdiz6+WvVHzFMqXkaIGRbt
rQGOnW8ogy8m/DwgqhcG8c/FOdT3ZzYPqfJtGz3dsYjZldF01hXf5phEeRJZCbRA
x+WW0apVI9xctOL4l20oRr2HeZuR3V3nlu+VKK5jxVjyRY8j75ZCiGLPmuCcyBBF
2OVrrnIuejjgO+NKbL0mWAEHBA7M77Oul9izXzd1/JDoFX16HC9H7J6SoeHJ/qBD
UVNPpxvTvUbxw+HqendVr3C3OathWa6TXsK8pPtEv2VMYVLvEuPD2X6gxUFseQTi
PNLyTTT7jAYWqo9IsDpkqWXW7p8pZg==
=r7jm
-----END PGP SIGNATURE-----

--r5zrqzgzswqfbr6h--

--===============2510666206872561361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2510666206872561361==--
