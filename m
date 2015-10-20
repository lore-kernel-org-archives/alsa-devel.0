From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ASoC: dapm: Add kcontrol support for
 PGAs
Date: Tue, 20 Oct 2015 22:16:25 +0530
Message-ID: <20151020164625.GD27370@localhost>
References: <1445355532-28310-1-git-send-email-vinod.koul@intel.com>
 <1445355532-28310-2-git-send-email-vinod.koul@intel.com>
 <562664B6.7090807@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CD5A266594
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 18:46:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <562664B6.7090807@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mythri P K <mythri.p.k@intel.com>, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 20, 2015 at 05:58:46PM +0200, Lars-Peter Clausen wrote:
> > -static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
> > -	int kci)
> > +static int dapm_create_or_share_mixmuxpga_kcontrol(
> 
> ... but maybe just call it dapm_create_or_share_kcontrol()

I don't mind that

> 
> > +		struct snd_soc_dapm_widget *w, int kci)
> >  {
> >  	struct snd_soc_dapm_context *dapm = w->dapm;
> >  	struct snd_card *card = dapm->card->snd_card;
> > @@ -822,6 +822,10 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
> >  				wname_in_long_name = true;
> >  				kcname_in_long_name = false;
> >  				break;
> > +			case snd_soc_dapm_pga:
> 
> This should have the same behavior as mixers and switches, just add the case
> there instead having a different path.

Oh yes thanks for pointing out that makese better sense, will update in v2.

-- 
~Vinod
