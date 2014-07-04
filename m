From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm-adsp: Add missing MODULE_LICENSE
Date: Fri, 4 Jul 2014 13:47:24 +0100
Message-ID: <20140704124724.GA16644@opensource.wolfsonmicro.com>
References: <1404452861-8951-1-git-send-email-vinod.koul@intel.com>
 <20140704114723.GB19453@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4361B26587F
 for <alsa-devel@alsa-project.org>; Fri,  4 Jul 2014 14:47:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140704114723.GB19453@sirena.org.uk>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Praveen Diwakar <praveen.diwakar@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 04, 2014 at 12:47:23PM +0100, Mark Brown wrote:
> On Fri, Jul 04, 2014 at 11:17:41AM +0530, Vinod Koul wrote:
> > From: Praveen Diwakar <praveen.diwakar@intel.com>
> > 
> > Since MODULE_LICENSE is missing the module load fails,
> > so add this for module.
> 
> Always CC maintainers on patches (in this case the Wolfson people),
> especially for something like licensing.

Indeed we would definitely like to be in the loop on licensing
changes :-)

> 
> > Signed-off-by: Praveen Diwakar <praveen.diwakar@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> > ---
> >  sound/soc/codecs/wm_adsp.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
> > index 0600271..2537725 100644
> > --- a/sound/soc/codecs/wm_adsp.c
> > +++ b/sound/soc/codecs/wm_adsp.c
> > @@ -1758,3 +1758,5 @@ int wm_adsp2_init(struct wm_adsp *adsp, bool dvfs)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(wm_adsp2_init);
> > +
> > +MODULE_LICENSE("GPL v2");

Yeah this is fine, I have been meaning to do that myself.

Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
