From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Tue, 2 Jun 2009 09:08:28 +0300
Message-ID: <200906020908.28624.peter.ujfalusi__8727.96536791629$1243922973$gmane$org@nokia.com>
References: <4A1BEBE3.8010306@tis.icnet.pl> <4A23CC97.1020209@tis.icnet.pl>
	<20090601210413.7678bf42.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090601210413.7678bf42.jhnikula@gmail.com>
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
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@vger.kernel.org" <alsa-devel@vger.kernel.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: alsa-devel@alsa-project.org

On Monday 01 June 2009 21:04:13 ext Jarkko Nikula wrote:
> On Mon, 01 Jun 2009 14:41:59 +0200
>
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
> > The original patch ported to linux-omap-2.6.27, the last omap release
> > with omap-alsa support, gives me a working sound driver on ams-delta.
>
> Ok, good to know.
>
> > To make the original driver work stable, I had to patch the omap-alsa
> > framework to restore the original way that lack of dma chaining
> > problem had been solved in the original patch (see below), so maybe
> > there is a similiar issue in the currect ASoC McBSP framework?
>
> Is the older implementation working at commit
> d8376cc482b241701f7606c81ad578b90853e175 in linux-omap, i.e. last
> commit before their removal?
>
> What I see at quick look from the older implementation that it is doing
> somewhat similar way the DMA transfer and workaround for 1510 than
> current ASoC except that now the DMA parameters are not reprogrammed
> between the restarted transfers. I don't know if 1510 requires it?

Good question, but at least on DMA round should have been completed anyways=
 if =

this is the case...

>
> > My asoc based patch is also very generic and contains no more that
> > the same two ams_delta_latch2_write() hardware related operations,
> > called from inside snd_soc_dai_link.ops.startup() and
> > snd_soc_dai_link.ops.shutdown() callback functions:
>
> One thing worth to try would be try to use exactly same McBSP registers
> for omap_mcbsp_config in omap_mcbsp_dai_hw_params than used before for
> ams delta.

Good idea, I was about to suggest to print the McBSP config in the working =
old =

alsa implementation, than print the non working from the ASoC version and s=
ee =

the difference, but copying the working one to ASoC (hardwire for now) shou=
ld =

get it working.

>
> Sorry, have to cut my answer now here. I'll get back tomorrow.

-- =

P=E9ter
