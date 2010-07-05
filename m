From: <peter.ujfalusi@nokia.com>
Subject: Re: issue with TWL4030
Date: Mon, 5 Jul 2010 23:13:28 +0200
Message-ID: <C358A26273CF2948B8BCDBA661A581782A6FBF945F@NOK-EUMSG-03.mgdnok.nokia.com>
References: <AANLkTilwdeNLChInBSaFIpVTLDONLXIIHVpLk3Aibk0v@mail.gmail.com>
	<20100703000635.GA3533@sirena.org.uk>,
	<AANLkTilvo5eV352yiSgOSst_kwt3juh4LSdTM64H5eBT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 6451D103807
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Jul 2010 23:13:37 +0200 (CEST)
In-Reply-To: <AANLkTilvo5eV352yiSgOSst_kwt3juh4LSdTM64H5eBT@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: notasas@gmail.com, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

________________________________________
From: ext Grazvydas Ignotas [notasas@gmail.com]
Sent: Saturday, July 03, 2010 5:32 PM
To: Mark Brown
Cc: Ujfalusi Peter (Nokia-MS/Tampere); alsa-devel
Subject: Re: [alsa-devel] issue with TWL4030

> On Sat, Jul 3, 2010 at 3:06 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> > On Sat, Jul 03, 2010 at 01:50:50AM +0300, Grazvydas Ignotas wrote:
> >
>> there seems to be a problem with TWL4030 hw_param programming, which
>> is easy to reproduce over OSS emulation with this simple program:
> >
> > OSS emulation is strongly disrecommended due to the fact that it
> > repeatedly reprograms things using partially valid configurations.  Some
> > drivers will refuse to run with it.
> 
> Well it used to work fine on OMAP+TWL until one of Peter's rework
> patches, I guess 6b87a91f (haven't really bisected), hope we can find
> some solution. We have some closed OSS programs that we can't drop,
> unfortunately. I know userspace OSS emulation solutions exist, but it
> wouldn't hurt to have more options.

Hmm.. The twl4030->configured meant to protect the reconfiguration of the
codec when the second stream tries to start with different properties than
the already running first (master) stream (and it has been introduced quite
some time ago).
The rest of the hassle around the hw param and parameter locking was to
fix gstreamer's way of starting full duplex operation.

While I agree with Mark, that OSS emulation should be phased out now (it's 2010)..
However, extending the state handling might fix your problem, but it complicates
things greatly, which can lead to more problems...
What I can think of is:
If only one (the master) stream has been opened, and the stream is not running (the
pcm_trigger has not been called yet), than we could allow reconfiguration of the codec.
Might work OK, but it might cause some problems under different scenario.

--
Peter
