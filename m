From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: why snd_soc_suspend is not called
Date: Tue, 19 Jun 2012 10:30:00 +0100
Message-ID: <20120619093000.GA3974@opensource.wolfsonmicro.com>
References: <CAMj5BkgV9odU+1VwhXx5w0Y8pPdHg25tHWNMX-5ecG_aL+r+cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4710523041253488845=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAMj5BkgV9odU+1VwhXx5w0Y8pPdHg25tHWNMX-5ecG_aL+r+cw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============4710523041253488845==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bgVZo3zXaTQrZhjg"
Content-Disposition: inline


--bgVZo3zXaTQrZhjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 19, 2012 at 01:12:05PM +0800, zhangfei gao wrote:

> In fact, even soc_probe is not called since no soc-audio device.

This is only called for soc-audio, if it were called otherwise it would
be abug.

> When running, system recommend using snd_soc_register_card instead.
> After doing such modification, the audio could work.
> But strangely snd_soc_suspend is not called, as well as soc-probe.
> So cpu_dai->driver->suspend will no be called accordingly.

> If manually add "soc-audio" in arch/, the soc-probe can be called.
> But snd_soc_suspend still fail to be called.

> Could you give me some suggestion?

There is probably a bug in your code.  At a guess you've not set up the
pm ops for your card.

--bgVZo3zXaTQrZhjg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP4EZ+AAoJEBus8iNuMP3dYzsP/2qeZJwJbln4pg5efTb3gM96
G9GdA0g16Zb/Ze21qBqoljnKCy3Fd9MyeKqAXwmiqd/SGetF6wkBhcg6TlYLLff8
m71k5s77uHpkDDwRZHN3VL6UtbhMT9yQsBY5IrCiXoXVSN2ra2GmNFSyUEm85o6g
FxYTE8k4oPfOCVTYnBrpm4QcXd6Hjkccu49LDcbvdJickI/b6CcfP+brizFxIpP/
/MX9J3BcuchHdnunG5x31vq890llg58sj3GGHLZUzOPGbZ1iM5VL/0aq9Bfs1CLM
+ikBJaSligi22lqfPX1gyq1zoWK3ZAJxQbex91hcsTZnck89i1p7y2TgcEp531pY
4T9L4wqubvO8LvgdL+Fq8bgQ1Qu0kPZqv9IPwuLOPMZOD2HfxnVdg4BInMv3yIjY
l4XbLHeLS70H9IobTv0YbIbkedwZu1zilC6KycV0q3TpzKX29FJKeKd34br9x8rV
iF0/3aSpegjDZGnFTVGmvqrAkKAkkplSR30kuf2JyKN6DjoNhWh/N/+ab2MosLQH
tGZ8JNDAslrgyNL5uSbJ3J5xAy56uy9qxNHR4TaCfO0Ohouwr4EPu3fRu02SGF9o
g0+z8YhvGDrMZtrkV1cLia2QvBZLHuhDJiSxsn9cEh4XImMkzjoOS+oV86FPGxM6
y9trdyANV/VzbpMSu04d
=gdzB
-----END PGP SIGNATURE-----

--bgVZo3zXaTQrZhjg--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============4710523041253488845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4710523041253488845==--
