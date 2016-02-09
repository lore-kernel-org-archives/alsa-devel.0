From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 01/14] ASoC: hdac_hdmi: Add hotplug
 notification and read eld
Date: Tue, 9 Feb 2016 19:42:06 +0000
Message-ID: <20160209194206.GO13270@sirena.org.uk>
References: <1454161428-7896-1-git-send-email-subhransu.s.prusty@intel.com>
 <1454161428-7896-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4410941529464525924=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AE205261531
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2016 20:42:13 +0100 (CET)
In-Reply-To: <1454161428-7896-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4410941529464525924==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QRo3kt64Wi40AlcO"
Content-Disposition: inline


--QRo3kt64Wi40AlcO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 30, 2016 at 07:13:35PM +0530, Subhransu S. Prusty wrote:

> +	if (!pin->eld.monitor_present || !pin->eld.eld_valid) {
> +
> +		dev_info(&edev->hdac.dev, "%s: disconnect for pin %d\n",
> +						__func__, pin->nid);
> +		goto put_hdac_device;

Will this get noisy?

> +		/* TODO: use i915 component for reading ELD later */
> +		if (hdac_hdmi_get_eld(&edev->hdac, pin->nid,
> +				pin->eld.eld_buffer,
> +				&pin->eld.eld_size) == 0) {
> +
> +			print_hex_dump_bytes("Eld: ", DUMP_PREFIX_OFFSET,
> +					pin->eld.eld_buffer, pin->eld.eld_size);

ELD is an acronym, please write it properly (there's some other examples
in the patch).

> +		} else {
> +			dev_err(&edev->hdac.dev, "ELD invalid\n");
> +			pin->eld.monitor_present = false;
> +			pin->eld.eld_valid = false;
> +		}

Is it really invalid or did we fail to read it?  There's a difference as
far as debugging is concerned (one means there's an I/O problem, the
other means that the display is reporting nonsense).  Perhaps this
should be silent and let the read function be more specific?

--QRo3kt64Wi40AlcO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWukENAAoJECTWi3JdVIfQDbMH/3SE8kEtDZOzrD45IaMM7lJQ
mceo/7i0UEsV8tyVwaGnkgz7l1iy0JXbz4lD2Nd573AqJXqY3tCw54Brkyq98Jri
WjrrnWmWDR6VvgfhmM2oKx7MCHKnT3giTSkpXJE6iBAJgRcUwY5TELMGvFqlCHRz
KdCtir0O+bBAtw3QXx7SyMbZiyiZFeRXW9qdWZGgygvbWMt+pWz9nHMx4MscHY0L
CFUlTESBnlH4iB/NtyExaTeGQI+OCJ9VirY4OADBDLCq5B2roBRxxEuxc1f/lLwj
mlWtLcWkPrf/wri/kQl7/u8Qv20IPCy6RtRA9C7hv1CWOGSCCZcTmUMK1E/DL6I=
=7TAa
-----END PGP SIGNATURE-----

--QRo3kt64Wi40AlcO--

--===============4410941529464525924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4410941529464525924==--
