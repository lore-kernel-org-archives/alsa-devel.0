From: German Gomez Garcia <german@hal9000.piraos.com>
Subject: Fwd: Emu10k1 SPDIF passthru doesn't work if HIGHMEM is enabled
Date: Tue, 12 Mar 2002 01:38:19 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020312003819.GA24406@hal9000.piraos.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

-- Forwarded message from "David S. Miller" <davem@redhat.com> --

From: "David S. Miller" <davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: rui.p.m.sousa@clix.pt, german@piraos.com, jcm@netcabo.pt,
        linux-kernel@vger.kernel.org, emu10k1-devel@lists.sourceforge.net,
        steve@math.upatras.gr, d.bertrand@ieee.org, dledford@redhat.com
Date: Thu, 28 Feb 2002 17:03:17 -0800 (PST)
Subject: Re: [Emu10k1-devel] Re: Emu10k1 SPDIF passthru doesn't work if

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Fri, 1 Mar 2002 01:07:27 +0000 (GMT)
  =20
   The cast befor ethe cpu_to_ is safe if its 32bit I/O only. Maybe we shou=
ld
   have cpu_to_le_dma_addr_t 8)

Actually, the cast to 32-bit is safe if you've set your DMA mask
properly :-)

-- End forwarded message --

	Please could anybody check that ALSA is doing things correctly
with HIGHMEM enabled? it seems that it's fixed now in the oss driver (at
least it's working for me) but ALSA is still broken if HIGHMEM is enabled.

	Regards,

	- german

--=20
Send email with "SEND GPG KEY" as subject to receive my GnuPG public key.

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE8jU37t47D3sninbkRAu9uAJd6gZk6yCduPALMWdjWtE4VzRuxAJ9HQPYf
7yBuFSzyNMNWYG3w/Vn+7g==
=pdK+
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
