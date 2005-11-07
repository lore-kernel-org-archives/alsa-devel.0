From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: Re: [Alsa-devel] Re: +
	v4l-720-alsa-support-for-saa7134-that-should-work-fix.patch added to -mm
	tree
Date: Mon, 07 Nov 2005 18:36:01 -0200
Message-ID: <1131395761.6632.125.camel@localhost>
References: <200511060743.jA67hpZa018948@shell0.pdx.osdl.net>
	 <20051106001249.48d3ade0.akpm@osdl.org> <1131301995.13599.5.camel@mindpipe>
	 <1131344803.10094.8.camel@localhost> <1131377615.8383.9.camel@mindpipe>
	 <s5h4q6opi5t.wl%tiwai@suse.de>  <20051107114843.0a476d90.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965041AbVKGUgN@vger.kernel.org>
In-Reply-To: <20051107114843.0a476d90.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, nshmyrev@yandex.ru, v4l@cerqueira.org
List-Id: alsa-devel@alsa-project.org

Andrew,

Em Seg, 2005-11-07 =E0s 11:48 -0800, Andrew Morton escreveu:
> Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > OK, a brief review:
> >  >=20
> >  >  - Why couldn't you use ALSA's DMA API?
> >=20
> >  This is OK, IMO.  Basically, it's up to the driver.
> >=20
> >=20
> >  >  - The DMA must be stopped and started in the trigger callback, =
not the
> >  > prepare callback.
> >  >=20
> >  >  - If this device lacks a volume control alsa-lib can emulate it=
 in
> >  > software, just create a proper /usr/share/alsa/cards/your_card.c=
onf
> >  > file.
> >  >=20
> >  >  - By ALSA convention the acceptable formats, sample rates, etc =
should
> >  > be directly defined in the snd_pcm_hardware_t structure.
> >  >=20
> >  >  - dev->oss needs to go.
> >=20
> >  Agreed about the rest.
>=20
> Thanks, guys.
>=20
> Despite all that, I am inclined to merge this patch into 2.6.15.  Bec=
ause
> it's in the middle of a 192-patch series and we do need to get the v4=
l tree
> synced up.
>=20
> Mauro, if we do that, do you think the above points can be addressed
> inside the next four weeks or so?
	We are, in fact already working on these. We are about to send you a
newer patch addressing most of the points that Takashi and Lee showed.
	You may apply the patches. If they noticed some weird stuff at the
newer patchset, we will have enough time for fix it.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
Cheers,=20
Mauro.
