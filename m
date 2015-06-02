From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 5/7] ASoC: intel - add Skylake HDA audio
	driver
Date: Tue, 2 Jun 2015 12:10:34 +0100
Message-ID: <20150602111034.GP14071@sirena.org.uk>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-6-git-send-email-vinod.koul@intel.com>
 <20150529174115.GR21577@sirena.org.uk>
 <20150601051358.GI3140@localhost> <s5hy4k46lk1.wl-tiwai@suse.de>
 <20150602104233.GG14071@sirena.org.uk>
 <s5hvbf6e67h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6996011495951441314=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C9968260517
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 13:10:38 +0200 (CEST)
In-Reply-To: <s5hvbf6e67h.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6996011495951441314==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qOEfHYdX8LquYLAx"
Content-Disposition: inline


--qOEfHYdX8LquYLAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2015 at 12:48:50PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Why does the driver care though?  IRQF_SHARED is advertising the
> > capabilities of the hander, not a requirement on the hardware - if the
> > interrupt physically can't be shared then the ability to share it will
> > never get used but that shouldn't matter.

> Because the kernel doesn't guarantee the exclusiveness of irq handler
> registration as long as you pass IRQF_SHARED.  That is, if we keep
> IRQF_SHARED and another driver tries to request_irq() for the same irq
> with again IRQF_SHARED.  But this shouldn't happen with MSI.

Sure, but how could that happen (given that the interrupt physically
can't be shared) and surely individual client drivers are the wrong
place to do this - it's not like MSI is the only interrupt type that has
trouble with sharability, if this is an issue we need to have checks and
enforcement for I'd expect the interrupt controller to be flagging
itself as unsharable.

--qOEfHYdX8LquYLAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbY8pAAoJECTWi3JdVIfQa2gH/0oRtVa8hTaCO5uewwNQMOkS
zgIpZ0l6kw3+5QMpdjPQQ3AqrEJOmfPQlyKF72m3Vknph3gcYmd71ZtD6HYTRj8h
zzUB/SX0yeaq3yJY02OcP+ZGm/NlzSyDS+X1pNa6Nx0g0OxIQ/atqVGGHXKYvy5B
eo5RAOkWYbwS1XO7fH/24g9zwLSbteQNUyPR2px40ePiDCBNe4LBrI2hD4PWYgOl
zUeBbaRF55793LF0EM5Sf3OuLkRt/VqEzur75dIZ5qJnn2mAE7vTpetyGJ5ZR4gN
9zthasVPgIMTo0fCVYtKVxGkSv7dDaE6GrpSYk5PADXqczxWfjhRtLWYznQ/oM0=
=AOVn
-----END PGP SIGNATURE-----

--qOEfHYdX8LquYLAx--

--===============6996011495951441314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6996011495951441314==--
