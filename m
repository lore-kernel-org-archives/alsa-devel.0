From: Philippe =?ISO-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Subject: Re: [PATCH 2/4] Add imx3sound sound support.
Date: Mon, 12 Mar 2012 09:11:50 +0100
Message-ID: <4989193.ghnyrmjmJD@laptop>
References: <1331304916-4724-1-git-send-email-philippe.retornaz@epfl.ch>
	<1331304916-4724-3-git-send-email-philippe.retornaz@epfl.ch>
	<CAOMZO5DP4P9Lq-gH_NNtDxwf8DxVAVg9MWHKr1E3RoexOgNYnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.epfl.ch (smtp4.epfl.ch [128.178.224.218])
	by alsa0.perex.cz (Postfix) with SMTP id 21F112435E
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 09:11:57 +0100 (CET)
In-Reply-To: <CAOMZO5DP4P9Lq-gH_NNtDxwf8DxVAVg9MWHKr1E3RoexOgNYnQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, juergen.lambrecht@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Le dimanche 11 mars 2012 11:59:40 Fabio Estevam a =E9crit :
> On Fri, Mar 9, 2012 at 11:55 AM, Philippe R=E9tornaz
> =

> <philippe.retornaz@epfl.ch> wrote:
> > --- /dev/null
> > +++ b/sound/soc/imx/imx3sound-mc13783.c
> > @@ -0,0 +1,141 @@
> > +/*
> > + * imx3sound-mc13783.c  --  SoC audio for imx31_3ds based boards
> =

> Please rename this file to  "imx-mc13783.c".
> =

> mx27pdk board also has a mc13783 and will use this file.
> =

> It is not restricted to mx3 boards.

Ok, will do.

Thanks,

Philippe
