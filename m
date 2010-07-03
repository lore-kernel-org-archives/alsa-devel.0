From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: issue with TWL4030
Date: Sat, 3 Jul 2010 17:32:08 +0300
Message-ID: <AANLkTilvo5eV352yiSgOSst_kwt3juh4LSdTM64H5eBT@mail.gmail.com>
References: <AANLkTilwdeNLChInBSaFIpVTLDONLXIIHVpLk3Aibk0v@mail.gmail.com>
	<20100703000635.GA3533@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 54A2924443
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Jul 2010 16:32:10 +0200 (CEST)
Received: by gyd10 with SMTP id 10so2193505gyd.38
	for <alsa-devel@alsa-project.org>; Sat, 03 Jul 2010 07:32:09 -0700 (PDT)
In-Reply-To: <20100703000635.GA3533@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 3, 2010 at 3:06 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Jul 03, 2010 at 01:50:50AM +0300, Grazvydas Ignotas wrote:
>
>> there seems to be a problem with TWL4030 hw_param programming, which
>> is easy to reproduce over OSS emulation with this simple program:
>
> OSS emulation is strongly disrecommended due to the fact that it
> repeatedly reprograms things using partially valid configurations. =A0Some
> drivers will refuse to run with it.

Well it used to work fine on OMAP+TWL until one of Peter's rework
patches, I guess 6b87a91f (haven't really bisected), hope we can find
some solution. We have some closed OSS programs that we can't drop,
unfortunately. I know userspace OSS emulation solutions exist, but it
wouldn't hurt to have more options.
