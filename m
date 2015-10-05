From: Koro Chen <koro.chen@mediatek.com>
Subject: Re: Question about patch ASoC: Prevent components from
 being bound to multiple cards
Date: Mon, 5 Oct 2015 19:28:54 +0800
Message-ID: <1444044534.32571.41.camel@mtksdaap41>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
 <20150909145158.GK9751@sirena.org.uk> <s5hh9n3d4bk.wl-tiwai@suse.de>
 <55F04AA1.3030607@metafoo.de> <1443782064.10151.28.camel@mtksdaap41>
 <20151002144831.GQ12635@sirena.org.uk>
 <1443884500.32571.12.camel@mtksdaap41>
 <20151005100717.GN12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A84D260508
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 13:28:59 +0200 (CEST)
In-Reply-To: <20151005100717.GN12635@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, p.zabel@pengutronix.de, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-10-05 at 11:07 +0100, Mark Brown wrote:
> On Sat, Oct 03, 2015 at 11:01:40PM +0800, Koro Chen wrote:
> > On Fri, 2015-10-02 at 15:48 +0100, Mark Brown wrote:
> > > On Fri, Oct 02, 2015 at 06:34:24PM +0800, Koro Chen wrote:
> 
> > > > I have two cards originally but the second one failed because of the
> > > > patch ASoC: Prevent components from being bound to multiple cards.
> 
> > > > My configuration is like this:
> > > > card0: use platform's DAI component A
> > > > card1: use the same platform's DAI component B
> 
> > > What do you mean by "DAI component" here?  It's not a term I'm familiar
> > > with...
> 
> > Sorry I didn't make myself clear enough. In the
> > sound/soc/mediatek/mtk-afe-pcm.c, I register two components
> > "mtk_afe_pcm_dai_component" and "mtk_afe_hdmi_dai_component", each has
> > its corresponding DAIs. Card0 (which is mt8173-rt5676-rt5650.c) uses
> > DAIs from the first component, and card1 (new) uses DAIs of the second
> > component. These two components are probed successfully and separately
> > by card0 and card1, but card1 failed to probe another component created
> > by snd_soc_register_platform(), which is already bound to card0.
> 
> OK, I see.  We probably do want to relax that restriction, it makes more
> sense at the DAI level but at the component level when we have
> components that have a bunch of independant DAIs hanging off a DMA
> controler as one component (which does make sense) then it breaks.
Thanks for your suggestion. Is it make sense if we use
component->registered_as_component, which is only true in case of
snd_soc_register_component() and will be false for components created by
snd_soc_register_platform() or snd_soc_register_codec(), then modify the
check condition like this:

@@ -1102,11 +1102,12 @@ static int soc_probe_component(struct
snd_soc_card *card,
        struct snd_soc_dai *dai;
        int ret;

        if (!strcmp(component->name, "snd-soc-dummy"))
                return 0;

        if (component->card) {
-               if (component->card != card) {
+               if (component->card != card &&
component->registered_as_component) {
