From: =?big5?B?IlRpZW4sICBDLkwuIC0gpdCp08KnIg==?= <cltien@cmedia.com.tw>
Subject: RE: [patch] for 9880 spdif out
Date: Fri, 18 Mar 2005 23:11:49 +0800
Message-ID: <92C0412E07F63549B2A2F2345D3DB515F7D6A8@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable
Received: from cm-msg-02.cmedia.com.tw (61-30-17-228.static.tfn.net.tw [61.30.17.228])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 16F2C257
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 06:57:11 +0100 (MET)
Content-Class: urn:content-classes:message
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Yes,

It works exactly as my patch. Thank you very much.

Sincerely,
ChenLi tien

-----Original Message-----
From:	Takashi Iwai [mailto:tiwai@suse.de]
Sent:	2005/3/18 [=ACP=B4=C1=A4=AD] =A4W=A4=C8 08:46
To:	Tien,  C.L. - =A5=D0=A9=D3=C2=A7
Cc:	alsa-devel@alsa-project.org
Subject:	Re: [Alsa-devel] [patch] for 9880 spdif out
At Thu, 17 Mar 2005 12:41:24 +0100,
I wrote:
>=20
> > --- alsa-kernel/pci/hda/hda_codec.c	16 Mar 2005 13:37:09 -0000	1.7
> > +++ alsa-kernel/pci/hda/hda_codec.c	17 Mar 2005 04:40:12 -0000
> > @@ -955,6 +955,8 @@
> >  	if (change || codec->in_resume) {
> >  		codec->spdif_ctls =3D val;
> >  		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1, =
val & 0xff);
> > +		put_vol_mute(codec, nid, 0, HDA_OUTPUT, 0, val ? 0 : 0x80);
> > +		put_vol_mute(codec, nid, 1, HDA_OUTPUT, 0, val ? 0 : 0x80);
>=20
> It should check only the enable bit (bit0) of val.
> Also, these two calls can be a single verb, e.g.
>=20
> 	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
> 			AC_AMP_SET_LEFT|AC_AMP_SET_RIGHT|AC_AMP_SET_OUTPUT|
> 			((val & 1) ? 0 : 0x80));
>=20
> Could you check whether this works?

OK the patch is below.  Please let me know if it works.


Takashi





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
