From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: snd-rme9652 fails
Date: Fri, 19 Dec 2003 13:32:48 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031219103248.GB29650@master.mivlgu.local>
References: <3FE02BA2.8020900@emt.iis.fhg.de> <3FE1676C.40806@ifrance.com> <1071738574.2020.24.camel@localhost.localdomain> <1071777684.26967.5.camel@cmn37.stanford.edu> <20031218225205.GA534@tuba.home> <Pine.LNX.4.58.0312191021540.8959@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312191021540.8959@pnote.perex-int.cz>
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


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 19, 2003 at 10:22:47AM +0100, Jaroslav Kysela wrote:
> > --- rme9652.c.ORIGINAL	Thu Dec 18 23:43:36 2003
> > +++ rme9652.c	Thu Dec 18 23:45:12 2003
> > @@ -1618,7 +1618,6 @@
> >  RME9652_SPDIF_RATE("IEC958 Sample Rate", 0),
> >  RME9652_ADAT_SYNC("ADAT1 Sync Check", 0, 0),
> >  RME9652_ADAT_SYNC("ADAT2 Sync Check", 0, 1),
> > -RME9652_ADAT_SYNC("ADAT3 Sync Check", 0, 2),
> >  RME9652_TC_VALID("Timecode Valid", 0),
> >  RME9652_PASSTHRU("Passthru", 0)
> >  };
> 
> Yes, duplicated controls ARE NOT ALLOWED NOW. Applied. Thanks.

Maybe snd_ctl_add() should print some debugging info (at least the control
name) when it encounters a duplicate control?  There were at least three
such bugs recently, and all of them required adding printk calls to the
driver to locate where it fails - this does not look like a good way...

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/4tPQW82GfkQfsqIRAqZvAJ44hEO7OaSwLvTyiCQdJAYA4eStqgCdF6qI
PI5ZgnsDmkkCza+GG3hNfDs=
=dEgP
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
