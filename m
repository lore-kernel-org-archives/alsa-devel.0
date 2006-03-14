From: Florian Schlichting <Florian.Schlichting@gmx.de>
Subject: Re: debugging nm256: some results, many questions
Date: Wed, 15 Mar 2006 03:59:46 +0800
Message-ID: <20060314195946.GA3633@tigerbay>
References: <20060223185253.GA7954@tigerbay> <s5hfym8vd0k.wl%tiwai@suse.de> <20060311174421.GB7775@tigerbay> <20060313064627.GA3864@tigerbay> <s5h4q22mu89.wl%tiwai@suse.de> <20060313145534.GA7995@tigerbay> <s5h7j6yqr7c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h7j6yqr7c.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2006 at 04:50:31PM +0100, Takashi Iwai wrote:
> How about the patch below?  (It's only for CVS version)

very good. It makes the larger changes that I didn't dare to think of
for lack of insight.=20

There's just another tiny cosmetical change, to the comments:

--- nm256.c.orig	2006-03-15 00:50:55.000000000 +0800
+++ nm256.c	2006-03-15 00:59:28.000000000 +0800
@@ -1157,7 +1157,8 @@
=20
 /*
  * some nm256 easily crash when reading from mixer registers
- * thus we're caching both read and written values for reading
+ * thus we're treating it as a write-only mixer and cache the=20
+ * written values
  */
 static unsigned short
 snd_nm256_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
@@ -1200,9 +1201,6 @@
 }
=20
 /*=20
- * below copied from OSS driver
- * this list could perhaps be fused with mixer_regs[] ??
- *=20
  * Initial register values to be written to the AC97 mixer.
  * While most of these are identical to the reset values, we do this
  * so that we have most of the register contents cached--this avoids



NB: while trying to compile from CVS with ./cvscompile [...]=20
-----------
patching file usbaudio.c
Hunk #2 FAILED at 70.
-----------
Running the command again it aparently ignored this problem

Also, there are some warnings during compile and a problem with depmod=20
loops at install
----------
  Building modules, stage 2.
  MODPOST
*** Warning: "snd_minor_info_oss_init" [/usr/src/cvs/alsa/alsa-driver/acore=
/snd.ko] undefined!
*** Warning: "snd_lookup_oss_minor_data" [/usr/src/cvs/alsa/alsa-driver/aco=
re/snd.ko] undefined!
*** Warning: "snd_info_minor_unregister" [/usr/src/cvs/alsa/alsa-driver/aco=
re/snd.ko] undefined!
*** Warning: "snd_minor_info_oss_done" [/usr/src/cvs/alsa/alsa-driver/acore=
/snd.ko] undefined!
*** Warning: "snd_info_minor_register" [/usr/src/cvs/alsa/alsa-driver/acore=
/snd.ko] undefined!

[...]

WARNING: Loop detected:
/lib/modules/2.6.15-max/kernel/sound/acore/snd.ko which needs snd.ko
again!
----------
(and the rest of the ALSA modules is ignored), so although I could=20
build things, it wouldn't "make install" and I can't make a final smoke=20
test :-(

Florian

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEFyCy/R0+cAphf/kRApAPAJwPXmEnFC/eEzkNP4TcSEb4fTg1tACfVVZ/
P/q3ZL0ZsZ9qbw23Hbj6p9w=
=WQVo
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
