From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: DXS broken with some cards in 1.0.X in module snd-via82xx?
Date: Mon, 1 Mar 2004 17:23:17 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040301142317.GB6542@master.mivlgu.local>
References: <40434209.6020903@tin.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <40434209.6020903@tin.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 01, 2004 at 03:00:41PM +0100, Maggio wrote:
> I was just wondering if the DXS support in 1.0.X has broken the 
> DXS_SUPPORT=1 with some cards .
> 
> I have an Abit KV7 Motherboard , and I use snd-via82xx for sound .
> 
> I use this module from the version "0.9.8" , and I've never had any 
> problems in enabling "dxs_support=1" with the 0.9.X series of the 
> drivers , yesterday , by trying 1.0.2c and today the 1.0.3 versions of 
> the kernel modules , I've noticed that ALSA doesn't work anymore with 
> DXS_SUPPORT=1 , because the sound is garbled  , and I can only use DXS 
> with DXS_SUPPORT=4 .
> 
> What's up?

I suspect that dxs_support=4 is really the correct value in most (if
not all) cases.  The resampling engine in VT82xx has a register for
the source sample rate, but does not have any register to indicate
the destination sample rate.  Unless the controller snoops the AC'97
accesses in some way, this probably means that the destination
sample rate is fixed at 48000 Hz.  I'm not sure what really happens
when the codec is set to VRA mode in this case - probably this
depends on quirks of a particular codec.  On my ASUS A7V8X (VT8235
and ALC650) both dxs_support=1 and dxs_support=4 seem to work
fine...

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAQ0dVW82GfkQfsqIRAmJXAJ9fW+D8o26lReG4S7i0oxv3kU5V1gCeKDdG
sLNhC8LGnmzqyexI6ZfKerY=
=iQJd
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
