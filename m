From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: SonyPI module and via82xx sound driver
Date: Mon, 5 Jan 2004 18:00:13 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040105150013.GC31599@master.mivlgu.local>
References: <Pine.LNX.4.53.0312282043360.31435@tweety.gaugusch.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0312282043360.31435@tweety.gaugusch.at>
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


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 28, 2003 at 08:47:07PM +0100, Markus Gaugusch wrote:
> The sonypi module uses IO Address 0x1080 - 0x1084B, which is in the range
> of the via82xx sound driver (0x1000 - 0x10ff). Is it possible to exclude
> the address range of the sonypi module in the via82xx driver? I'm pretty
> sure that it isn't really used by ALSA :)

Does the sonypi module really work on your machine if snd-via82xx is
not loaded?  What is the exact machine model?

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+Xv9W82GfkQfsqIRAk35AJ9KaxYGWXG5qeshN60CeC+gT3VODQCfZCWG
dQEJdkuSczPenscdIDAB2yY=
=73Q0
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
