From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Add DSP firmware
	manifest parsing
Date: Tue, 12 Apr 2016 05:12:07 +0100
Message-ID: <20160412041207.GU3351@sirena.org.uk>
References: <1459633754-20548-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6766918409931890559=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 545DA265335
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 06:12:17 +0200 (CEST)
In-Reply-To: <1459633754-20548-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, "Nc, Shreyas" <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6766918409931890559==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0rpW5bEisVBStM29"
Content-Disposition: inline


--0rpW5bEisVBStM29
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 03, 2016 at 03:19:14AM +0530, Vinod Koul wrote:

> +	for (i = 0; i < num; i++) {
> +		if (!strcmp(uuid, tbl[i].uuid)) {

Do we really want to be working with UUIDs in string format all the
time?  It seems error prone and as far as I can see at least some of the
time we get them in in binary format.

> +	sprintf(buf, "%08X", entry->uuid.id_1);
> +	sprintf(buf+strlen(buf), "-");

Coding style, spaces around +.  I'd also like to be a bit more confident
that this can't result in a buffer overflow, sprintf() isn't reassuring
especially in conjunction with buf being passed in from elsewhere with
no length information.

> +	adsp_hdr = (struct adsp_fw_hdr *)(buf + SKL_ADSP_FW_BIN_HDR_OFFSET);
> +
> +	mod_entry = (struct adsp_module_entry *)
> +		(buf + SKL_ADSP_FW_BIN_HDR_OFFSET + adsp_hdr->header_len);
> +
> +	num_entry = adsp_hdr->num_module_entries;

> +	for (i = 0; i < num_entry; i++, mod_entry++) {
> +		get_canonical_uuid(uuid_str, mod_entry);

We're not checking that we're not walking off the end of the file here.

--0rpW5bEisVBStM29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDHWWAAoJECTWi3JdVIfQunAH/ig/ljB5WPd24hScLm7APpqr
eAZd2uN+LRYYdY1FCVZsFlB6ZiynoSfv2UizzUkeOVmPsN2PYw9K4RYMr16ZdtII
H5tYAXym6AM/B1YHhzQ8cjboqMkcZzlgdCUZM/0BvPbaa5OZTCltfCNKkpg3FDTO
YdcpAXB9jwGIu+/eaX+sQwOpMMswg60WpwwrAf/mVPdJXz3xnN94lw7Ab2qWxDq6
Q7TxoWhaE5+U/DFL9ltZQiZM4jORhqiiXUyesO7Bi3bYv6x1VA11hiSOAxRdKDx9
8vvSxHF3r09IVPwTYN9H1udTp94vVRzpfHsofzspZujOKzedsOyEXFDDn8C5kyY=
=8dLS
-----END PGP SIGNATURE-----

--0rpW5bEisVBStM29--

--===============6766918409931890559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6766918409931890559==--
