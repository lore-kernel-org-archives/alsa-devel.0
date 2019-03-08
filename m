From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Fri, 8 Mar 2019 21:13:13 +0000
Message-ID: <20190308211313.GD7960@sirena.org.uk>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
 <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
 <20190308041056.GA1172@workstation>
 <20190308125916.2cgiqclp6jmlfbim@shell.armlinux.org.uk>
 <20190308172235.GA31189@sirena.org.uk>
 <25dec9c5-af5c-bc54-89dd-2abdeffa9f82@perex.cz>
 <CAGngYiVaFswVrVYfUpo4YfkH+nxwaW+8q8q3C6_wfggS7YCYjw@mail.gmail.com>
 <865cd0e3-8390-024d-6c84-c416bfe3cb45@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3744444655497173341=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96CE2F806F7
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2019 22:13:17 +0100 (CET)
In-Reply-To: <865cd0e3-8390-024d-6c84-c416bfe3cb45@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============3744444655497173341==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Content-Disposition: inline


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 08, 2019 at 02:49:48PM -0600, Pierre-Louis Bossart wrote:

> I am not sure I fully understand the ask but wanted to point out that for
> ASoC topology-based solutions the bclk rate is typically passed as a
> parameter from userspace (w/ a request_firmware and topology parsing) and

You mean for x86 systems :)  Well, big DSP really.  It's not really
topology related.

> might be forwarded over IPC to a DSP. On some Intel platforms which can't
> support 32x fs that is typically how we represent a bclk ratio multiple of
> 25. the kernel has no idea of the relationship between the representation of
> the stream in memory and the final bit clock, only the DSP which programs
> the hardware registers knows about the latter.

> It's really quite typical that the DAI is programmed for a fixed
> configuration and the DSP takes care of the conversions. The kernel only
> deals with stream triggers and power management without know all the
> internal details of the audio graph.

I think this is more the issue with not having transitioned fully to
components which we've talked about before I think - it's related but
not quite the same thing.  In the big DSP case there's really two audio
links that aren't really connected but we're currently trying to treat
them as one since the code was designed for much smaller DSPs.

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyC2ugACgkQJNaLcl1U
h9BzAgf/QarVNiOsLpgm9s/R+gkYQ+/+o6ThIHkEnZqrLFfCbva59zHtbO46ruQO
T43nBWtdN3wyQPF5kb6HbMxgCqy26raTR0/SnptHYQNTtui79oz5zlsKwtZyf8O4
9pF6QrCvoa6fRT4RtS98AvVYGDp6/mwD7G6IVy/EWC5wFCAT74h5sDh1VC2mCbge
54RxTj4v5r/FHLFCHwzCg0OSamKvWRmJqDNS1Vg6DgggYu5IV8ZkO+MRHquiQR1X
wJxsRBJmA5ksw+Rl3ihRuVrJBBQOknwJROeh+Z0wH0KpoSwh3KVXz+OzKlqgVi1U
AD8l9StFBUUnPryK1B3pbIMcDdmH2w==
=bNow
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--

--===============3744444655497173341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3744444655497173341==--
