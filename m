From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: alsa-lib & oss 1.0.3rc1
Date: Thu, 26 Feb 2004 18:55:48 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040226155548.GC21451@master.mivlgu.local>
References: <Pine.LNX.4.58.0402212257000.1870@pnote.perex-int.cz> <1077754003.2680.26.camel@thor.asgaard.local> <Pine.LNX.4.58.0402261129550.13076@pnote.perex-int.cz> <1077804788.27443.51.camel@thor.asgaard.local> <Pine.LNX.4.58.0402261510310.13076@pnote.perex-int.cz> <1077805803.2677.67.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from master.mivlgu.local (mivlgu.ru [81.18.140.87])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA31919
	for <alsa-devel@alsa-project.org>; Thu, 26 Feb 2004 16:55:55 +0100
Content-Disposition: inline
In-Reply-To: <1077805803.2677.67.camel@thor.asgaard.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 26, 2004 at 03:30:04PM +0100, Michel D?nzer wrote:
> On Thu, 2004-02-26 at 15:10, Jaroslav Kysela wrote:
> > 
> > Can you try with the mpg123 program? It works on x86.
> 
> It can successfully print the usage info, but also crashes when trying
> to actually play a file. Note that even gdb crashes on startup, so the
> problem seems completely unrelated to sound?

You can try this:

$ gdb mpg123
(gdb) set args xxx.mp3
(gdb) set env LD_PRELOAD /home/user/src/alsa-cvs/alsa-oss/alsa/.libs/libaoss.so
(gdb) run

This way LD_PRELOAD will be set only for the debugged process, and not for
the debugger itself - hopefully the debugger will not crash and will
provide some useful info.

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPhcEW82GfkQfsqIRAuy3AJ9c/zssKHaF5RnOL1UbhBorqAbl6wCfT2iy
0tla7EQwzRfgT06YFOlI9Yw=
=KP/k
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
