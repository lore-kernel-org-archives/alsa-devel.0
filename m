From: Travis Place <wishie@wishie.net>
Subject: [Fwd: Re:  Problem regarding CA0106]
Date: Tue, 17 Jun 2008 01:56:11 +1000
Message-ID: <1213631771.4031.6.camel@temp-fallen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-rded96TlqCJce0LRIW0F"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-089.dial.usertools.net
	[202.137.100.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 390A224375
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 17:55:04 +0200 (CEST)
Received: from [192.168.0.7] (unknown [192.168.0.200])
	by www.wishie.net (Postfix) with ESMTP id 20A114B87B
	for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2008 16:16:38 +1000 (EST)
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


--=-rded96TlqCJce0LRIW0F
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-rded96TlqCJce0LRIW0F
Content-Disposition: inline
Content-Description: Forwarded message - Re: [alsa-devel] Problem regarding
	CA0106
Content-Type: message/rfc822

Subject: Re: [alsa-devel] Problem regarding CA0106
From: Travis Place <wishie@wishie.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hve09psuz.wl%tiwai@suse.de>
References: <1213377513.27630.5.camel@temp-fallen>
	 <s5hve09psuz.wl%tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Message-Id: <1213631528.4031.4.camel@temp-fallen>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.1.1 
Date: Tue, 17 Jun 2008 01:52:29 +1000
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-06-16 at 12:38 +0200, Takashi Iwai wrote:
> At Sat, 14 Jun 2008 03:18:33 +1000,
> Travis Place wrote:
> >=20
> > Just been speaking with a guy in #alsa about the problems with his "M=
SI
> > K8N Diamond MB" which has an onboard "SB Live 24bit" or "Audigy".
> >=20
> > While looking through ca0106_main.c in GIT, i saw the following secti=
on:
> >=20
> > /* MSI K8N Diamond Motherboard with onboard SB Live 24bit without AC9=
7
> > */
> > 	 /* SB0438
> > 	  * CTRL:CA0106-DAT
> > 	  * ADC: WM8775SEDS
> > 	  * DAC: CS4382-KQZ
> > 	  */
> > 	 { .serial =3D 0x10091462,
> > 	   .name   =3D "MSI K8N Diamond MB [SB0438]",
> > 	   .gpio_type =3D 2,
> > 	   .i2c_adc =3D 1 } ,
> >=20
> > For this guys sound to work, we had to change the serial line to:
> >=20
> > 	 { .serial =3D 0x10091102,
>=20
> Does it mean that this number 1009:1102 is missing, or a wrong
> 1009:1462 entry matches with his hardware?
>=20
=EF=BB=BFWell, it appears to me (due to another report filed previously) =
that
the motherboard is a 'newer revision' and has a different ID for the
soundcard.

> In the former case, it happens often.  We just need to add a new entry
> for the newer model.  In the latter case, it's odd.
>=20

=EF=BB=BFI think that adding the new ID to the driver wont cause any imme=
diate
problems. The old value (1009:1462) should remain, until we can confirm
it against another K8N Diamond motherboard (although im not sure how
common these boards are).

>=20
> thanks,
>=20
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Thanks,
Travis Place

--=-rded96TlqCJce0LRIW0F
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-rded96TlqCJce0LRIW0F--
