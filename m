From: Luca Capello <luca@pca.it>
Subject: Re: Clicks in output using intel8x0 driver (and a few
 questions)
Date: Fri, 19 Mar 2004 08:49:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405AA60E.5080808@pca.it>
References: <1079679790.2906.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1079679790.2906.17.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

on 03/19/04 08:03, Josh Green wrote:
> I was curious what the state is of the intel8x0m driver, since I have an
> accursed CH4 82801DB AC'97 Modem Controller which is an HSF Conexant
> device. I have it working with the linuxant.com drivers, but they are
> rather unstable with the newer 2.6.4 kernel and contain binary code.
> Anyone have this working with this modem?
yes, me :-)
    http://sourceforge.net/mailarchive/forum.php?thread_id=4059462&forum_id=1752

I used it with the daemon 'slmodemd' from the SmartLink drivers at
    ftp://ftp.smlink.com/linux/unsupported/

I don't know if there's a way to use the 'intel8x0m' without the 'slmodemd'.

Please take care that as reported in my post I used it on my old laptop (an ASUS
M3410C/M3N, Intel Centrino), while I haven't tried yet on my new one (always an
ASUS Intel Centrino, but now a M6842NWH/M6800N). I'll do my tests ASAP with the
new 2.6.5-rc1 kernel which includes the 'intel8x0m'.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFAWqXqVAp7Xm10JmkRAiG4AKCKU6AZ77oCYGZAMb/20tjyAH/TqgCeI6e+
YOB6HJJRtujydUKzhqHjyhQ=
=Cswe
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
