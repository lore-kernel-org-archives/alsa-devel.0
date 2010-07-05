From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: issue with TWL4030
Date: Tue, 6 Jul 2010 07:24:50 +0800
Message-ID: <AANLkTim5rQNaVHLlEjXK3hY2ykOU_TxM89WJd1g96LCh@mail.gmail.com>
References: <AANLkTilwdeNLChInBSaFIpVTLDONLXIIHVpLk3Aibk0v@mail.gmail.com>
	<20100703000635.GA3533@sirena.org.uk>
	<AANLkTilvo5eV352yiSgOSst_kwt3juh4LSdTM64H5eBT@mail.gmail.com>
	<C358A26273CF2948B8BCDBA661A581782A6FBF945F@NOK-EUMSG-03.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DF2B2103825
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jul 2010 01:24:50 +0200 (CEST)
Received: by vws9 with SMTP id 9so3182487vws.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Jul 2010 16:24:50 -0700 (PDT)
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A6FBF945F@NOK-EUMSG-03.mgdnok.nokia.com>
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

2010/7/6 <peter.ujfalusi@nokia.com>

> Hi,
>
> ________________________________________
> From: ext Grazvydas Ignotas [notasas@gmail.com]
> Sent: Saturday, July 03, 2010 5:32 PM
> To: Mark Brown
> Cc: Ujfalusi Peter (Nokia-MS/Tampere); alsa-devel
> Subject: Re: [alsa-devel] issue with TWL4030
>
> > On Sat, Jul 3, 2010 at 3:06 AM, Mark Brown
> > <broonie@opensource.wolfsonmicro.com> wrote:
> > > On Sat, Jul 03, 2010 at 01:50:50AM +0300, Grazvydas Ignotas wrote:
> > >
> >> there seems to be a problem with TWL4030 hw_param programming, which
> >> is easy to reproduce over OSS emulation with this simple program:
> > >
> > > OSS emulation is strongly disrecommended due to the fact that it
> > > repeatedly reprograms things using partially valid configurations.
>  Some
> > > drivers will refuse to run with it.
> >
> > Well it used to work fine on OMAP+TWL until one of Peter's rework
> > patches, I guess 6b87a91f (haven't really bisected), hope we can find
> > some solution. We have some closed OSS programs that we can't drop,
> > unfortunately. I know userspace OSS emulation solutions exist, but it
> > wouldn't hurt to have more options.
>
> Hmm.. The twl4030->configured meant to protect the reconfiguration of the
> codec when the second stream tries to start with different properties than
> the already running first (master) stream (and it has been introduced quite
> some time ago).
> The rest of the hassle around the hw param and parameter locking was to
> fix gstreamer's way of starting full duplex operation.
>
> While I agree with Mark, that OSS emulation should be phased out now (it's
> 2010)..
> However, extending the state handling might fix your problem, but it
> complicates
> things greatly, which can lead to more problems...
> What I can think of is:
> If only one (the master) stream has been opened, and the stream is not
> running (the
> pcm_trigger has not been called yet), than we could allow reconfiguration
> of the codec.
> Might work OK, but it might cause some problems under different scenario.
>
>
The OSS emulation call driver's hw_params many time when the OSS program or
SDL try to probe the supported rate , format and channels

Not easy for the driver to 100% compatible with OSS 3.8 since the default is
mono ,U8 and 8000Hz when you use  "cat  foo.wav > /dev/dsp" or "cat /dev/dsp
> foo.wav"
