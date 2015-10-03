From: Koro Chen <koro.chen@mediatek.com>
Subject: Re: Question about patch ASoC: Prevent components from
 being bound to multiple cards
Date: Sat, 3 Oct 2015 23:01:40 +0800
Message-ID: <1443884500.32571.12.camel@mtksdaap41>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
 <20150909145158.GK9751@sirena.org.uk> <s5hh9n3d4bk.wl-tiwai@suse.de>
 <55F04AA1.3030607@metafoo.de> <1443782064.10151.28.camel@mtksdaap41>
 <20151002144831.GQ12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 57596261740
 for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2015 17:01:45 +0200 (CEST)
In-Reply-To: <20151002144831.GQ12635@sirena.org.uk>
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

On Fri, 2015-10-02 at 15:48 +0100, Mark Brown wrote:
> On Fri, Oct 02, 2015 at 06:34:24PM +0800, Koro Chen wrote:
> 
> > I have two cards originally but the second one failed because of the
> > patch ASoC: Prevent components from being bound to multiple cards.
> 
> > My configuration is like this:
> > card0: use platform's DAI component A
> > card1: use the same platform's DAI component B
> 
> What do you mean by "DAI component" here?  It's not a term I'm familiar
> with...
Sorry I didn't make myself clear enough. In the
sound/soc/mediatek/mtk-afe-pcm.c, I register two components
"mtk_afe_pcm_dai_component" and "mtk_afe_hdmi_dai_component", each has
its corresponding DAIs. Card0 (which is mt8173-rt5676-rt5650.c) uses
DAIs from the first component, and card1 (new) uses DAIs of the second
component. These two components are probed successfully and separately
by card0 and card1, but card1 failed to probe another component created
by snd_soc_register_platform(), which is already bound to card0.
 
