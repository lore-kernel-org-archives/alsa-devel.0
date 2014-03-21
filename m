From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: add RT286 CODEC driver
Date: Fri, 21 Mar 2014 12:12:04 +0000
Message-ID: <20140321121204.GO11706@sirena.org.uk>
References: <1394521896-27721-1-git-send-email-bardliao@realtek.com>
 <20140314191244.GZ366@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73A0212@RTITMBSV03.realtek.com.tw>
 <20140318130137.GZ11706@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73A3762@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2148128376390572782=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D28302610A7
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 13:12:13 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D73A3762@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2148128376390572782==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="60oUs1yQD37x8E8P"
Content-Disposition: inline


--60oUs1yQD37x8E8P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 21, 2014 at 05:57:49AM +0000, Bard Liao wrote:

> > Please fix your mailer to word wrap within paragraphs, this will make your mail
> > more legible.

> Now I set 80 characters to wrap the text. Hope it can work.

Doesn't seem to have taken I'm afraid :(

> > So VID+NID is an address and PID is a value?

> For I2C write, yes.
> But for I2C read, I think PID is also a part of address. Because PID is meaningful in the I2C read protocol.
> For example, if we need to get the mute/unmute status of headphone, we need to set:
> VID = b'h (Get Amplifier Gain)
> NID = 22'h (Headhoone)
> PID = a000'h (Left output amplifier gain is requested)
> And we can get response from rt286.

> I am trying to implement my reg_write and reg_read to:
> reg_write: address: VID+NID, value: PID
> reg_read: address: VID+NID+PID, value: the responding data from rt286.

Right, that's why I said you'll need to read the cache as part of your
read function.  Unless the PID there is not the last value that was set
in which case it probably isn't actually a register value...

--60oUs1yQD37x8E8P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLCyRAAoJELSic+t+oim9ITEQAJJ4h6c1kD6wp/tUnat7qg6f
azTv+1bxmGp2oYS/f+N1MLC0FccEa6Z7kO/CNvPOgtMw0J+W65FXxAjF6iS5QRGR
Sq2XVLuF49DZoMpuGnuE756j7jt4tt5xkPK8xUaH1+U3kFdJLKGjSqgDQ+YhSqQm
yVJNl/Hy5czLM3BTtCVzMwC/aa1LyLjQdJ1a5i2/TRw/DsCPK6C/Bst5Eku09VPA
krP7RQB6lHQpQPOqBQ+H7s4dBXjRkjuVc2si6dmxQ711FRjRALG5E+LmaQFD0Uaq
HMPESOFGjsQoJYMSFfbtR+4B/9vA0K+SRnXGiLvj7vcad93pqgiPtODlEkc+Sjpx
otvc8xxvk9q2PrlPSxqflshof13hfZu9+njsYnDDd1uE2+dtCNZUaudgJEEXKlG5
kWDXvx/5vR3jp1OpSTckXlcZzrl82bPg/VlyPi1VyLJv2uxMgvZRE7w2qYHTV1ti
Ts3yFCnhVlkShVsy4iMrVA7f+XdpqNqZd0akBktquWsOdyKhT9k3wfYYZcrXHzck
4bzqmPy142Zpzh2CqdzzzSv0kK0488+ydcR1zvm0DI5cmXB3quWB1wF+CTtpuG07
PHXWd2F+y9L3g+pOE3H3r8fyQw8N9NZneRdifmRQnXxIHB+FQzqhPxSi6zmPG0Sz
6h1Zs0ZI97w88eTRaY7Y
=OMyy
-----END PGP SIGNATURE-----

--60oUs1yQD37x8E8P--

--===============2148128376390572782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2148128376390572782==--
