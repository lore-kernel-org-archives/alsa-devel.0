From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: alsa-lib & oss 1.0.3rc1
Date: Fri, 27 Feb 2004 13:38:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077885495.13385.32.camel@thor.asgaard.local>
References: <Pine.LNX.4.58.0402212257000.1870@pnote.perex-int.cz>
	 <1077754003.2680.26.camel@thor.asgaard.local>
	 <Pine.LNX.4.58.0402261129550.13076@pnote.perex-int.cz>
	 <1077804788.27443.51.camel@thor.asgaard.local>
	 <Pine.LNX.4.58.0402261510310.13076@pnote.perex-int.cz>
	 <1077805803.2677.67.camel@thor.asgaard.local>
	 <Pine.LNX.4.58.0402261530490.13076@pnote.perex-int.cz>
	 <1077817984.2680.119.camel@thor.asgaard.local>
	 <Pine.LNX.4.58.0402261933560.13076@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-o1rxlCEmfgQt/XLmieMG"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from netline-mail1.netline.ch (netline-mail1.netline.ch [195.141.226.27])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA27182
	for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2004 13:38:24 +0100
In-Reply-To: <Pine.LNX.4.58.0402261933560.13076@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--=-o1rxlCEmfgQt/XLmieMG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by alsa.alsa-project.org id NAA27182

On Thu, 2004-02-26 at 19:38, Jaroslav Kysela wrote:
> On Thu, 26 Feb 2004, Michel D=C3=A4nzer wrote:
>=20
> > The problem occurs when the ALSA_OSS_WRAPPER environment variable isn=
't
> > set. initialize() returns early, so the public functions segfault whe=
n
> > they try to dereference the uninitialized fds.
> >=20
> > Is there a reason why ALSA_OSS_WRAPPER must be set? Even if so, I thi=
nk
> > it should cope more gracefully otherwise. :)
>=20
> No reason. I ommited to remove this hack when I separated the wrapper=20
> code from the API emulation code. You can remove the lines without any=20
> side effect.

Okay, thanks.

Unfortunately, bzflag now fails doing=20

ioctl(5, SNDCTL_DSP_SETFRAGMENT, 0x7ffff308[4000c])

even with the attached patch, which used to be enough to get it working.
Adam's ('small and cosmetic'??? :) patch doesn't help either.

Luckily, bzflag is switching to SDL...


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI devel=
oper
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenze=
r

--=-o1rxlCEmfgQt/XLmieMG
Content-Disposition: attachment; filename=local.diff
Content-Type: text/x-patch; name=local.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

? build-arch-stamp
? debian
? local.diff
Index: alsa/pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-oss/alsa/pcm.c,v
retrieving revision 1.9
diff -p -u -r1.9 pcm.c
--- alsa/pcm.c	26 Feb 2004 15:31:46 -0000	1.9
+++ alsa/pcm.c	27 Feb 2004 12:13:33 -0000
@@ -261,7 +261,9 @@ static int oss_dsp_hw_params(oss_dsp_t *
 			if (err < 0)
 				return err;
 			if (dsp->maxfrags > 0) {
-				unsigned int periods_max = dsp->maxfrags;
+				unsigned int periods_max = periods_min > dsp->maxfrags
+							 ? periods_min
+							 : dsp->maxfrags;
 				err = snd_pcm_hw_params_set_periods_max(pcm, hw,
 									&periods_max, 0);
 				if (err < 0)

--=-o1rxlCEmfgQt/XLmieMG--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
