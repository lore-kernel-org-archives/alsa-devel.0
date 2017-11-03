From: Naveen M <naveen.m@intel.com>
Subject: Re: [PATCH] ASoC: Intel: kbl: Modify Headset map for
	Multi-Playback
Date: Fri, 3 Nov 2017 14:18:34 +0530
Message-ID: <41797.3769050606$1509698954@news.gmane.org>
References: <1509679697-22154-1-git-send-email-naveen.m@intel.com>
 <20171103082100.GK3187@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 27E46266A0C
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 09:49:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171103082100.GK3187@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 03, 2017 at 01:51:00PM +0530, Vinod Koul wrote:
> On Fri, Nov 03, 2017 at 08:58:17AM +0530, Naveen Manohar wrote:
> > Current topology for Headset resulted in unwanted pop noise,
> > while switching from spk->hs at the start of Headset Playback.
> 
> what is the reason for the pop ?
> 
There is an artifact observed at the start of the stream, which is not
seen earlier with mixin-mixout dsp module, through which data was
passing-through.

> > Modified topology to fix the same.
> 
> how does that fix it, sorry am quite unclear about that part
> 
Only for headset playback pipe, we re-introduced the mixin-mixout which
was there earlier. This does not fix the problem but removes regression
(pop-noise in headset playback) introduced by earlier
commit-ID:0b06122fc8d0949a0aa7b817d98e031104802611

> > This modification also requires headset route to be updated.
> 
> that seems to be the only change here, so not sure I follow the changes dont
> for this
>
As the topology was modified to earlier path, earlier route change was
reverted for headset playback.

> > 
> > Signed-off-by: Naveen Manohar <naveen.m@intel.com>
> > Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
> > ---
> >  sound/soc/intel/boards/kbl_rt5663_max98927.c        | 2 +-
> >  sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
> > index 6f9a8bc..6dcad0a 100644
> > --- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
> > +++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
> > @@ -101,7 +101,7 @@ enum {
> >  	{ "ssp0 Tx", NULL, "spk_out" },
> >  
> >  	{ "AIF Playback", NULL, "ssp1 Tx" },
> > -	{ "ssp1 Tx", NULL, "hs_out" },
> > +	{ "ssp1 Tx", NULL, "codec1_out" },
> >  
> >  	{ "hs_in", NULL, "ssp1 Rx" },
> >  	{ "ssp1 Rx", NULL, "AIF Capture" },
> > diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> > index 6072164..271ae3c 100644
> > --- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> > +++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
> > @@ -109,7 +109,7 @@ enum {
> >  	{ "ssp0 Tx", NULL, "spk_out" },
> >  
> >  	{ "AIF Playback", NULL, "ssp1 Tx" },
> > -	{ "ssp1 Tx", NULL, "hs_out" },
> > +	{ "ssp1 Tx", NULL, "codec1_out" },
> >  
> >  	{ "hs_in", NULL, "ssp1 Rx" },
> >  	{ "ssp1 Rx", NULL, "AIF Capture" },
> > -- 
> > 1.9.1
> > 
> 
> -- 
> ~Vinod

-- 
