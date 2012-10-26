From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: question on snd_soc_dai_link_event
Date: Fri, 26 Oct 2012 18:01:42 +0100
Message-ID: <20121026170142.GZ18814@opensource.wolfsonmicro.com>
References: <9C1683ABA24673439FCD019782C9F4BBDA2A1C1582@SAFEX1MAIL1.st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2730130377210723969=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82DDE265145
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 19:07:04 +0200 (CEST)
In-Reply-To: <9C1683ABA24673439FCD019782C9F4BBDA2A1C1582@SAFEX1MAIL1.st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien LEDUC <sebastien.leduc@st.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Liam Girdwood (lrg@ti.com)" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2730130377210723969==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UEW5kU42M6+IO/TD"
Content-Disposition: inline


--UEW5kU42M6+IO/TD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 26, 2012 at 01:58:54PM +0200, Sebastien LEDUC wrote:

Fix your mailer to word wrap within paragraphs, it makes your mails hard
to read if you don't do this.  I've reflowed for legibility.

> I wonder why it does not call the full hw_params / prepare / trigger
> sequence on both dai drivers to start the 2 DAIs.

None of the drivers that use this actually have any of those calls so I
didn't bother.  Especially in the case of trigger it's unlikely that an
off-SoC device without DMA would need this, though of course it could
happen.

--UEW5kU42M6+IO/TD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQisHpAAoJELSic+t+oim9ks4P/jBfYz6rzNbj321iMzkt2rxU
wwfcqDIAQUTd4iHiJmb9vJheGSI3nBtFhzhaG4eFuwXmqbAhjCRDWDbafw8PF2uf
nLVn9L2GfeiE4XmtdhbreeY3N1pJ9cEyeekYONsQsHLl/OQ/TxB9ItoZNeX/UXW7
gL7l9ciHvuNMACp5hTBdyyY6QARlSL4rc4zYj7Xb6nXWt3VK9bGyuYizDrj5qZ7v
jX1YvcNkHrvXOzFs7I6NHOUWP6OZrQU+dWcbFxkGDAyfChsHjYcoU50bwTPOnx6K
N8iIJhRs2jWLs09lKbko39uIVxCygD22Gvm7mpni3MO8xOYrOpcN/Skh/0O6Cj54
jUFIDLM7/x0rMHzljCkmguXbd20N40Oxn7juG5uNQNIpsoKA5y2LuXCoJXuzMesb
1dxY/66k6MOOpwpBfEl5kxZvHZm27gatl+Y4OdomL8l1g413FnAl61XbdIpRLVq5
IQfgsUNUfE9N2/SDtSi9iBijOWTSD6QTcVuHSNYkJSsEQNT3t+e6Q3Y/hqKcNK4u
PAG5D8zbPl6YEkxtxOim5H0GpnkVM752Iif7pAYMtYP7WPeO1rp4nYqFNVEm94VP
Y6mXsQPQ7mUD0Doq+GwWJCtR8VBqcM4SgpMfZgfLGHIRErEBhtHEa1eH2Gf2F+oq
1I89a/IRq5xTCr83gou2
=FWUf
-----END PGP SIGNATURE-----

--UEW5kU42M6+IO/TD--

--===============2730130377210723969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2730130377210723969==--
