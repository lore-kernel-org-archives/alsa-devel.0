From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Multiple reports of hard lockups with alsa MPU in
Date: Sun, 14 May 2006 00:08:19 +0200
Message-ID: <1147558099.25313.13.camel@johannes.berg>
References: <1147554990.6535.317.camel@mindpipe>
	 <1147556731.25313.10.camel@johannes.berg>
	 <1147557612.6535.322.camel@mindpipe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KTb1d6fvTV+XM7fgNDOm"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1147557612.6535.322.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-KTb1d6fvTV+XM7fgNDOm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-05-13 at 18:00 -0400, Lee Revell wrote:

> Switching to a real VC was tried and the problem persisted.

I wouldn't have expected it to help, but if you got the kernel to panic
it should then print out the message to the vc and you get to see what's
wrong. A segfault in an interrupt handle for example.

If you don't get to see any messages then I don't know, possibly a
deadlock somewhere. Maybe try on an SMP machine and enable spinlock
debugging?

johannes

--=-KTb1d6fvTV+XM7fgNDOm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGZY0aVg1VMiehFYAQJ9Xg//bLucZeoiSvFgaglnwGJA7XgdNk+y+vyy
ZvoA4FRVvFGpW+T8KZMPO0dRzOdAA/TWeHmPVSS8NrkLmbie/nfT0F0JorGgjJy7
vmobtIFnqUdlrpejQzOGft2xma+5y+L5IwgByfAwp+7uArJDJcgDNEKny3bFNSTz
YYQUIESXl5W4QwD++bvOJ1znmXPxv+Si/E69EBUQquOKhaxxvbmH76rSt74zxzdb
hL6uFW/z36JyNeFmtXSsVIQnQMVbT4VkGQ0t454oIGTOqJoBFDYBhQD6qdjFIiWl
cNe5FpmYxGy/E+vg8ahAP50FJq2hqDPYBrMrqJwC9wvE1AkGyxYwjGy2yZcRRIg0
jPs0hNwsmK/BD/0uwhuOhlMDrZLgIaYdhJTU0sVWhzlC0cIpLauzxhGkr07MNiA5
49zuiT0NUpp3Bskr3vqw47VIwqOoSbrI126zz6sUX7GyFWDfwOrkx76GXxa/ytCL
mq/XIa9EqcDb8N7NUAMGW76X3kGSNK88YaLurGGA2cUfDlxD7endg4mcT0bwkF8S
6OovpE2RYTvXpsrFAYjTONEtqW1d1bMamYJVe+jF+xGrlP3QN51Gr3wa5QmYei8V
QEJ1Zl8nF9jyayE5Ph7Ywm/A0D+VBERlLiGmK/f+j9Ml4f5Y/2WfFH/KizpdXI7F
E3Pu9t4h+iY=
=HJuN
-----END PGP SIGNATURE-----

--=-KTb1d6fvTV+XM7fgNDOm--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
