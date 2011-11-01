From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Add new Realtek ALC5632 CODEC
	driver.
Date: Tue, 1 Nov 2011 12:15:04 +0000
Message-ID: <20111101121504.GC10029@opensource.wolfsonmicro.com>
References: <1319913743-2693-1-git-send-email-leon@leon.nu>
	<CABS+qY1zjgnaB5o+LZ3ghvByXwPrDuNN0uWWcPE=q-JK52-c7g@mail.gmail.com>
	<CALq1K=JkJi_OAu-RZO1++8fXWF6xg4bHaWL=yp4a-uCnpqmFTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1EAF1103822
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 13:15:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CALq1K=JkJi_OAu-RZO1++8fXWF6xg4bHaWL=yp4a-uCnpqmFTA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Leon Romanovsky <leon@leon.nu>
Cc: alsa-devel@alsa-project.org, Andrey Danin <danindrey@mail.ru>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 01, 2011 at 08:53:05AM +0200, Leon Romanovsky wrote:
> On Mon, Oct 31, 2011 at 16:28, Girdwood, Liam <lrg@ti.com> wrote:
> > On 29 October 2011 19:42, Leon Romanovsky <leon@leon.nu> wrote:

> >> + =A0 =A0 =A0 alc5632 =3D devm_kzalloc(&client->dev, sizeof(struct alc=
5632_priv), GFP_KERNEL);
> >> + =A0 =A0 =A0 if (alc5632 =3D=3D NULL)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;

> >> + =A0 =A0 =A0 alc5632->id =3D vid2;
> >> + =A0 =A0 =A0 switch (alc5632->id) {
> >> + =A0 =A0 =A0 case 0x5c:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 alc5632_dai.name =3D "alc5632-hifi";
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 =A0 default:

> > Need to free resources here.
> Do I need explicit call for this?
> Is this because driver detach not called  in this case?
> http://lxr.free-electrons.com/source/drivers/base/devres.c#L609
> (Memory allocated with this function is automatically freed on driver det=
ach.)

You should be fine due to use of devm_kzalloc() - it's just that that's
a relatively new API.
