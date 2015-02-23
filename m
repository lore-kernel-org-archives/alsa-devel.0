From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/13] ASoC: Intel: add pm support in sst
	ipc driver
Date: Tue, 24 Feb 2015 00:45:16 +0900
Message-ID: <20150223154516.GG6236@finisterre.sirena.org.uk>
References: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
 <1423715405-4562-11-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3490416644522208509=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A749226066E
 for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2015 16:46:08 +0100 (CET)
In-Reply-To: <1423715405-4562-11-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3490416644522208509==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Edk6HoYKP7RsK9ib"
Content-Disposition: inline


--Edk6HoYKP7RsK9ib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 12, 2015 at 10:00:02AM +0530, Vinod Koul wrote:
> This adds support for system pm support. We need to save the dsp memory
> which gets lost on suspend and restore that on resume

This doesn't seem to apply against current code, not entirely sure
what's going on there, can you take a look please?  I've applied
everything up to here, thanks!

--Edk6HoYKP7RsK9ib
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU60sMAAoJECTWi3JdVIfQQBkH/i7JHhy6AFOLplr/KxYYBa8j
QlfoNu0/35FKu6Ce/VBxiYgwRKZ4GHxS5fxNYEEwhbT9wlNAGh0fRdgJ1tg+Wrfs
/Z8GuPAmG2x2KjynyxnpIDAqw6F5MPjMQsG8VrMMWZtTpAPAckMMSOEqPD7pADZ5
aewR9w0FwhEsDnA2kBq4p4I7YK/pIUAegZ7oPXkCoVoIgvNUXpvacppCi/9892zK
ljXSD2HVg7aXeY4WmFaCAwZDPk7Bx5c+yovgvR7sq636kf6My+h2mYCZ5HgCngS+
Vch62MdD3CY5DBchv2+kb8x5xUCnoYhU0jgliDuQ2XUoXE4tp93ThlDDh2QnRyY=
=+y2f
-----END PGP SIGNATURE-----

--Edk6HoYKP7RsK9ib--

--===============3490416644522208509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3490416644522208509==--
