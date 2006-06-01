From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: RFC: minimalistic TLV implementation
Date: Thu, 1 Jun 2006 17:00:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606011645530.9144@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0605311500480.9226@tm8103.perex-int.cz>
	<s5hzmgx6rtb.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606011510010.9144@tm8103.perex-int.cz>
	<s5hpsht6lo6.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0606011602020.9144@tm8103.perex-int.cz>
	<s5hirnl6isc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1118779612-1149174030=:9144"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 527EB15A
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jun 2006 17:00:31 +0200 (MEST)
In-Reply-To: <s5hirnl6isc.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1118779612-1149174030=:9144
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 1 Jun 2006, Takashi Iwai wrote:

> At Thu, 1 Jun 2006 16:08:13 +0200 (CEST),
> Jaroslav Kysela wrote:
> >=20
> > On Thu, 1 Jun 2006, Takashi Iwai wrote:
> >=20
> > > Yes.  It's similar but a really big difference if you consider about
> > > 32/64bit compatibility.
> > >=20
> > > Also, the order of "TLV" is type-length-value.
> >=20
> > Ok, the second version of my patch. Note: in the ca0106 driver, only
> > three lines (if I don't count one empty line) are required to add
> > the dB scale information.
>=20
> The existence of flag makes the things complicated.
> I prefer removing flag and make the ioctl numid-specific.

It might be. It's really small work for the user space and we may use
flags in future to determine ioctl version or some other extension at the
ioctl level.

> Also, I don't think data_offset is necessary in the practical use.

To separate ioctl and data in the user space? But it might be that=20
the 32bit->64bit conversion layer won't handle the non-continuous memory=20
in a right way. I'll remove it.

=09=09=09=09=09Jaroslav

-----
InterNet p=F8es WIFI bez limitu dat, =C8esk=E9 Bud=ECjovice a okol=ED
Pokryt=E9 lokality: =A9indlovy Dvory, Mokr=E9, Litv=EDnovice, Pek=E1rensk=
=E1, Srubec
Perex @ InterNet <internet@perex.cz>
--8323584-1118779612-1149174030=:9144
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323584-1118779612-1149174030=:9144
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--8323584-1118779612-1149174030=:9144--
