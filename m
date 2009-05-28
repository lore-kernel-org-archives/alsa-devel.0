From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [Pkg-alsa-devel] Bug#529940: lib32asound2: symbol
	versioning changed in an incompatible way
Date: Wed, 27 May 2009 20:23:53 -0400
Message-ID: <9e4733910905271723v3fe03bcahb687fdeea206d898@mail.gmail.com>
References: <20090527115302.GA16925@chistera.yi.org>
	<20090527214856.GB3549@aragorn.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 96808243B9
	for <alsa-devel@alsa-project.org>;
	Thu, 28 May 2009 02:23:54 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so2726692qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2009 17:23:53 -0700 (PDT)
In-Reply-To: <20090527214856.GB3549@aragorn.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 529940@bugs.debian.org, =?ISO-8859-1?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>, Jordi Mallach <jordi@debian.org>, control@bugs.debian.org, debian-powerpc <debian-powerpc@lists.debia>
List-Id: alsa-devel@alsa-project.org

On Wed, May 27, 2009 at 5:48 PM, Elimar Riesebieter <riesebie@lxtec.de> wro=
te:
> tags 529940 pending
> forwarded 529940 alsa-devel@alsa-project.org
> thanks
>
> * Adeodato Sim=F3 [090527 13:53 +0200]
>> severity 529940 serious
>> retitle 529940 lib32asound2: symbol versioning changed in an incompatibl=
e way (ALSA_0.9.0rc4/8 dropped)
>> thanks
>>
>> Hello,
>>
>> it seems that between 1.0.19-1 and 1.0.20-1 the list of symbols in
>> lib32asound2 changed. More precisely, the list of symbols remained but
>> their associated versioning changed: all symbols associated with
>> ALSA_0.9.0rc4 and ALSA_0.9.0rc8 were changed to live under ALSA_0.9
>> instead, making applications compiled against <=3D 1.0.19 fail to start
>> due to missing symbols.
>>
>> Note that this problem affects the 32-bit library in amd64, but not the
>> native libraries nor in i386 nor amd64.

I think you found my thread showing that dropping the rc4 symbols
breaks skype on 64b.
skype is only 32b and needs 32b compatibility support on amd64.

It is pretty pathetic that skype hasn't released a new Linux binary in
four years.

>
> Don't we have to verify it at ppc64 as well? CC'd to debian-ppc.
>
>>
>> Also note that we've started having applications like WINE 1.1.19 in
>> experimental rebuilt against 1.0.20, and which don't work against
>> alsa-lib 1.0.19 either. And we'll have no easy way to detect these,
>> since shlibs are not bumped.
>>
>> Will you be able to upload fixed packages in a timely manner?
>
> According to [0] I created svn version 2249 on alioth [1]. I've tested
> it on amd64, were rc4 symbols appeared by checking via readelf. But
> maybe alsa-devel rechecks the buildsystem of alsa-libs to avoid that
> dirty hacks? --with-versioned appended to ./configure opts didn't
> help.
>
> [0] http://mailman.alsa-project.org/pipermail/alsa-devel/2009-April/01608=
3.html
> [1] http://svn.debian.org/wsvn/pkg-alsa/?op=3Dcomp&compare[]=3D%2F@2248&c=
ompare[]=3D%2F@2249
>
> Jordi, please recheck and upload.
>
> Index: debian/rules
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- debian/rules =A0 =A0 =A0 =A0(Revision 2248)
> +++ debian/rules =A0 =A0 =A0 =A0(Arbeitskopie)
> @@ -39,7 +39,7 @@
> =A0 endif
> =A0endif
>
> -CFLAGS =3D -g -Wall
> +CFLAGS =3D -g -Wall -DUSE_VERSIONED_SYMBOLS
>
> =A0ifneq (,$(findstring noopt,$(DEB_BUILD_OPTIONS)))
> =A0 =A0 =A0 =A0CFLAGS +=3D -O0
>
>
> --
> =A0"Talking much about oneself can also
> =A0 be a means to conceal oneself."
> =A0 =A0 =A0 =A0 -Friedrich Nietzsche
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- =

Jon Smirl
jonsmirl@gmail.com
