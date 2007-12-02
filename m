From: Ctirad Fertr <c.fertr@gmail.com>
Subject: Re: [PATCH] 1616(M) cardbus improvements
Date: Mon, 3 Dec 2007 00:33:25 +0100
Message-ID: <200712030033.25351.c.fertr@gmail.com>
References: <200711160007.00300.c.fertr@gmail.com>
	<s5hwss3iqqu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.vol.cz (smtp1.vol.cz [195.250.128.78])
	by alsa0.perex.cz (Postfix) with ESMTP id DC0F81038AE
	for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2007 00:34:54 +0100 (CET)
Received: from [10.16.3.4] (dsl-tn-6-43.static.adsl.vol.cz [83.148.7.43])
	by smtp1.vol.cz (Postfix) with ESMTP id 8B22C888E3
	for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2007 00:34:54 +0100 (CET)
In-Reply-To: <s5hwss3iqqu.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne Tuesday 27 of November 2007 17:43:05 jste napsal(a):
> The changes look almost good to me.  But, if I understand correctly,
> the input source put isn't changed properly for EMU1616.

No, it's correct, because emu1010_input_dst[] structure is generic for =

all EMU PCI cards.

> The patch below is the revised version with bunch of coding style
> fixes (at the next time, try scripts/checkpatch.pl in linux kernel
> tree before submission).

I will do that next time. Thank you. =


> Let me know if it works for you.  I'll apply to ALSA tree after your
> confirmation.

I works very well :)

Unfortunatelly, now I found that driver (or host card) reload causes kernel =

ooops on 2.6.23 (2.6.22 is unaffected). This is NOT related to my patch.  I=
t =

crashes even with 1.0.15 version. This is bad :( It crashes immeditely afte=
r =

a firmware for the host card is loaded. Can someone confirm that? =

 =

> Oh, BTW, it'd be also appreciated if you can write an additional patch
>=A0to add enum definitions for each emu_model type instead of digits.
> "if (emu_model =3D=3D 3)" is no good style.

OK. I'll do it. =


---
Ctirad
