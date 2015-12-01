From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 06/16] ASoC: Intel: Skylake: Add support
 for Load/Unload IPCs
Date: Tue, 1 Dec 2015 22:58:54 +0000
Message-ID: <20151201225854.GZ1929@sirena.org.uk>
References: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
 <1448703121-5831-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3140774075749115383=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 31A3426073D
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:02 +0100 (CET)
In-Reply-To: <1448703121-5831-7-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3140774075749115383==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ljc4DTHj+3GjP/mD"
Content-Disposition: inline


--Ljc4DTHj+3GjP/mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 28, 2015 at 03:01:51PM +0530, Vinod Koul wrote:

> Some firmware modules can be loaded and unloaded to/from DSP.
> This can be done by invoking IPCs Load module and unload module
> respectively. So this patch starts this by adding support for
> these IPCs

In what way does it do this?

> +int skl_ipc_load_modules(struct sst_generic_ipc *ipc,
> +				u8 module_cnt, void *data)
> +{
> +	struct skl_ipc_header header = {0};
> +	u64 *ipc_header = (u64 *)(&header);
> +	int ret;
> +
> +	header.primary = IPC_MSG_TARGET(IPC_FW_GEN_MSG);
> +	header.primary |= IPC_MSG_DIR(IPC_MSG_REQUEST);
> +	header.primary |= IPC_GLB_TYPE(IPC_GLB_LOAD_MULTIPLE_MODS);
> +	header.primary |= IPC_LOAD_MODULE_CNT(module_cnt);
> +
> +	ret = sst_ipc_tx_message_wait(ipc, *ipc_header, data,
> +				(sizeof(u16) * module_cnt), NULL, 0);

So the multiple modules are a block of at most 255 16 bit words?  That's
a bit surprising - is it really a count of the number of modules or
rather the size of the block of data that's being squirted at the DSP?

> +int skl_ipc_unload_modules(struct sst_generic_ipc *ipc, u8 module_cnt,
> +							void *data)
> +{
> +	struct skl_ipc_header header = {0};
> +	u64 *ipc_header = (u64 *)(&header);
> +	int ret;
> +
> +	header.primary = IPC_MSG_TARGET(IPC_FW_GEN_MSG);
> +	header.primary |= IPC_MSG_DIR(IPC_MSG_REQUEST);
> +	header.primary |= IPC_GLB_TYPE(IPC_GLB_UNLOAD_MULTIPLE_MODS);
> +	header.primary |= IPC_LOAD_MODULE_CNT(module_cnt);
> +
> +	ret = sst_ipc_tx_message_wait(ipc, *ipc_header, data,
> +				(sizeof(u16) * module_cnt), NULL, 0);

This seems weird...  what's the data that's getting passed in?  This
doesn't seem to be actually managing anything, it's just some very basic
message formatting.

--Ljc4DTHj+3GjP/mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXiYuAAoJECTWi3JdVIfQ0ZoH/3v0U4GFgI4NBZTXbMYZ0ZX8
1fekwcV9c7MWHIjBf0sj2Z1/K0iYK0J6K9GxFPqrj1K/Lw3QpZ/5jgFih7ieXRFG
iVKnf/uD1pWv5bguS2Jyff13u0w5r4ylnxvllqT7f6SbeJMuwzfgiO1k9Y5vzOaV
f1T45Jyr9t6yZxDPKqKcrYI4qXTlThQQ14hJ3v1AruqVc7trxP5vJCGrJmnV7UaI
qG8Kkm2NnWX8ZY4OPqbxHGG0IrpccrkxdKU2pQTmJ/uvx3OeLl98MGZuXI91jt1j
ylJz6WxZoIfMD3FwcAaD7LLypQ0rZ/v2GIPLOSyXNEueF7VdX8KpFJ3bqkpEefQ=
=GcY8
-----END PGP SIGNATURE-----

--Ljc4DTHj+3GjP/mD--

--===============3140774075749115383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3140774075749115383==--
