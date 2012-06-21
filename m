From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Patch subject line (was: Re: [PATCH] asoc: bfin:
 use dev_err to print error log instead of dev_dbg)
Date: Thu, 21 Jun 2012 16:39:15 +0100
Message-ID: <20120621153915.GX4037@opensource.wolfsonmicro.com>
References: <1340301118-3800-1-git-send-email-scott.jiang.linux@gmail.com>
	<20120621100841.GP4037@opensource.wolfsonmicro.com>
	<CAHG8p1ACFtV0p8c8MQFSVDuBUX0y-CTw_uXXXyPaZmHRYXZfBw@mail.gmail.com>
	<20120621104743.GT4037@opensource.wolfsonmicro.com>
	<4FE334CA.7090205@canonical.com>
	<20120621152244.GW4037@opensource.wolfsonmicro.com>
	<s5hfw9od6l4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8777385791037560955=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 826EB2442B
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 16:18:03 +0200 (CEST)
In-Reply-To: <s5hfw9od6l4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============8777385791037560955==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z3PcgjD2qOzdkXVS"
Content-Disposition: inline


--z3PcgjD2qOzdkXVS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 21, 2012 at 05:31:51PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Looking at the git logs that's *really* unusual.

> I'd say it's between usual and unusual :)
> Driver-local commits tend to have a prefix with the path (or
> omitting "drivers/").  So in our case it'd be "sound/soc/codec: xxx"
> or "sound/pci/hda: xxx".

Yeah, I was mainly thinking of the subsystem: bit which is pretty much
the norm (with a few exceptions).

--z3PcgjD2qOzdkXVS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP40AcAAoJEBus8iNuMP3di68P/0BdlkNw0kuHfWEiZAj02Y6D
RgFuJfXJ3WbMHQjIC3Uvm9jxGmT+WF8QlIaktk9r8Bvz4e7bvXRAEmdWcOLZ0WIV
mQmJXSIvLdKeWMEOfIhpkz/5lLESr1TcS6BNK2+scIauYEtvgqKMmNo9xNkigZwL
7HF93suzunI9scY1FKGknCaK0DEBrXa3j7V0N0uwVxVokQbfCS4BZOsnAHrL1XQG
a0EqWcmYlwCmGinRXcTxlCsViRIRiHs14HpOKuJb+vKb8jABT+dzksZZhUyofHfH
lmZBkZCk2+uSztZWG4BcoLe6gfTxdPB6oAgIe5GDWpxkd+Ao3XW2fbUgU5e+Jnjv
bf83BpK0zvPxxIgwUPMHDvZHZEm9tW8Q/xRCNmBNm7k4lGjU2A+rzqLf+WhuqN8L
Ts1i8GfEkteQ92hROndh8OEgBH85k/yssL5qTIdCFWmOjtNzuA/Frk5Nmp3UeWj4
sYBNcCl6QSQ6Cr+ifRwItwd3d/H0sSwJAAUjYpMJl9VZH+mUtl2eRhQxmLgk4wLz
pmwrmqpcoj8U6kCRzOsLalZ2hzxVtQDE6o2ILqvVCzYoNs9V8ImRBajghDERmN5P
8V/7VKyyk3UU7Pj1jYa4upUyJxa4hn/jUmDRig0PaZU+HIHK91MO58+o/gVbzwOz
Ye4GLHfWFid95JMCTMLI
=AE+/
-----END PGP SIGNATURE-----

--z3PcgjD2qOzdkXVS--

--===============8777385791037560955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8777385791037560955==--
