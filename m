From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: firmware core: Add core support
 to	create and destroy firmware components.
Date: Wed, 21 Nov 2012 09:30:42 +0900
Message-ID: <20121121003038.GB4673@opensource.wolfsonmicro.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
 <1353348765-6238-4-git-send-email-lrg@ti.com>
 <s5hr4npqvlh.wl%tiwai@suse.de> <50AB718D.10207@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3841381142952036538=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9FA8C261681
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 01:31:14 +0100 (CET)
In-Reply-To: <50AB718D.10207@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3841381142952036538==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2012 at 12:03:25PM +0000, Liam Girdwood wrote:

> I think we are good with the magic number check atm and I can add
> some explicit endianess conversion when we have more users. Atm, the
> only users will be ARM based.

It's very likely that Wolfson will pick this up quickly for some of our
devices.

Could we make the endianness annotations in the header explicit for now
but refuse to handle anything except LE?  That way we avoid changing the
externally visible interface which would be painful.  I'm not so worried
about actually implementing this properly, just worried that people will
get upset if we change the published ABI.

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQrCCaAAoJELSic+t+oim9QtQP/jYjxYITURmI6iUBvOY8ZU1O
J1I4dd+Q3Yp16IXlF7q8pWfQTHtZoZxx5xxqNtiSR4DhXgR7naDxlwI7ND0byL2+
cYsNngxfZkmE/xI3rnSMbi3JXtos4yaVKUzMfPsPh4cNahC4pjedFUQRnb+j9xM5
ulPsbs5akfF+rtDs+0zBGumGwd017rPW5LvFgjN9BeF5JTeUygxsVCA9oMJV9qIO
HxnobbON2xEmyukXNR5QcLJLKi8Z7DrL8t3nABjimeZ+dEvkUJBR5L1QpQTaqVrh
o1yTkgKdXkueJuyXEdZTCKg9hhLKxQyuoUNEJqrWqaxoGh9tYjMAUohLoDUK2Sbk
jSDLouxkdL/btdPuWP4mVO24toVRW5hy0W47exyLKzHxX3d3yxsMSyfrHnQVXxjh
LsPjXt4UU5gT2b4NcJwWvdHLcmWtiRcXNkNJsL1n1vPOUQd5yLmITDEXHVm7wRTx
QgD3++GH0r0zwJC69an6m5wwS8wkYjD0uMK1/XvDq6Bt3v+PpWGa1jSCCoMKluUP
7G8iqszrUUmq3Vhs+smdAo81/9/XUNeWNAiRQiUkggfhtQrWltq28tNcvhlko3T/
cWdmM0QSYkiLEfKbwwdr83WzQrrMjThvVcAgPbqr8/+XMHsH7Vm3VzqHp2P/pFg5
3Ute68pBeWFfoLnN1f6e
=njiP
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--

--===============3841381142952036538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3841381142952036538==--
