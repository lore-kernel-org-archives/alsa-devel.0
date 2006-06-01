From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: RFC: minimalistic TLV implementation
Date: Thu, 1 Jun 2006 15:12:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0606011510010.9144@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0605311500480.9226@tm8103.perex-int.cz>
	<s5hzmgx6rtb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-2001644505-1149167525=:9144"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5A75011E
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jun 2006 15:12:06 +0200 (MEST)
In-Reply-To: <s5hzmgx6rtb.wl%tiwai@suse.de>
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

--8323584-2001644505-1149167525=:9144
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 1 Jun 2006, Takashi Iwai wrote:

> At Wed, 31 May 2006 15:10:21 +0200 (CEST),
> Jaroslav Kysela wrote:
> >=20
> > Hi,
> >=20
> > =09I've created a minimalistic TLV implemetation for the driver side.=
=20
> > Please, review and comment it. We can add more TLV funcionality in futu=
re.
> > It is essential that user space will handle SNDRV_CTL_TLVT_LEVEL type=
=20
> > immediately (altough it is not used in the kernel space now), otherwise=
 we=20
> > cannot group and level TLVs in future.
>=20
> Please never ever include pointers in the ioctl struct.
> That's to be avoided as much as possible.

> > +struct snd_ctl_tlv {
> > +        unsigned int flags;
> > +        unsigned int length;
> > +        unsigned int value;
> > +        /*
> > +         * TLV structure is:
> > +         *   unsigned int length
> > +         *   unsigned int type=09- see SNDRV_CTL_TLVT_*
> > +         *   .... data aligned to sizeof(unsigned int), use
> > +         *        block_length =3D (length + (sizeof(unsigned int) - 1=
)) &
> > +         *                       ~(sizeof(unsigned int) - 1)) ....
> > +         */
> > +        void *ptr;
> > +};

So what you suggest? Something like 'struct dm_ioctl'=20
(include/linux/dm-ioctl.h) does? Data are stored after ioctl struct.
It's nearly similar.

=09=09=09=09=09=09Jaroslav

-----
InterNet p=F8es WIFI bez limitu dat, =C8esk=E9 Bud=ECjovice a okol=ED
Pokryt=E9 lokality: =A9indlovy Dvory, Mokr=E9, Litv=EDnovice, Pek=E1rensk=
=E1, Srubec
Perex @ InterNet <internet@perex.cz>
--8323584-2001644505-1149167525=:9144
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323584-2001644505-1149167525=:9144
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--8323584-2001644505-1149167525=:9144--
