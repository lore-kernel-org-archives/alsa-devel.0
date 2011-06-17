From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Codec VIA VT2020/VT1718S and questions about
	commit 4ab2d53a99b6dcee86837d2a9739bfb9f468db45
Date: Fri, 17 Jun 2011 09:27:34 +0800
Message-ID: <BANLkTinujGkeH66UgAEjhS0wNQmkikJmiA@mail.gmail.com>
References: <BANLkTiky0K_Tx=jB4+sY4-d9Lk=ZghRHJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 58B6D2448D
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jun 2011 03:27:36 +0200 (CEST)
Received: by fxm5 with SMTP id 5so751707fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2011 18:27:35 -0700 (PDT)
In-Reply-To: <BANLkTiky0K_Tx=jB4+sY4-d9Lk=ZghRHJA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/6/17 alex dot baldacchino dot alsasub at gmail dot com
<alex.baldacchino.alsasub@gmail.com>:
> Hello,
>
>
>
> and that seems to be the same for other vt1718s codec implementations
> (by asrock): https://launchpadlibrarian.net/70606587/Card0.Codecs.codec.0=
.txt
> =A0(motherboard ASRock H55M Pro, more info at
> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/772638 ),
> therefore your code seems to access a non-existing connection. Since
> such looks like not very safe/correct, Raymond Yau had suggested to
> change it into:
>
>
> - =A0 =A0 =A0 {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(5)},
> + =A0 =A0 =A0 {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
>

I only suggest you to ask Lydia who have submited a patch which change
this non-existing connection
