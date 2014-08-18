Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BD742654BB
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 12:37:11 +0200 (CEST)
Date: Mon, 18 Aug 2014 15:45:15 +0530
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Message-ID: <20140818101514.GA29250@vinod.koul@linux.intel.com>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-6-git-send-email-subhransu.s.prusty@intel.com>
 <20140813200012.GO17528@sirena.org.uk>
 <20140818053609.GD14041@vinod.koul@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140818053609.GD14041@vinod.koul@linux.intel.com>
Subject: Re: [alsa-devel] [v4 05/12] ASoC: Intel: mrfld: add bytes control
	for modules
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-ID: <alsa-devel@alsa-project.org>

On Mon, Aug 18, 2014 at 11:06:09AM +0530, Subhransu S. Prusty wrote:
> On Wed, Aug 13, 2014 at 09:00:12PM +0100, Mark Brown wrote:
> > On Mon, Aug 04, 2014 at 03:15:56PM +0530, Subhransu S. Prusty wrote:
> > 
> > > From: Vinod Koul <vinod.koul@intel.com>
> > 
> > > +static int sst_algo_bytes_ctl_info(struct snd_kcontrol *kcontrol,
> > > +			    struct snd_ctl_elem_info *uinfo)
> > > +{
> > > +	struct sst_algo_control *bc = (void *)kcontrol->private_value;
> > > +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> > > +
> > > +	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
> > > +	uinfo->count = bc->max;
> > > +
> > > +	/* allocate space to cache the algo parameters in the driver */
> > > +	if (bc->params == NULL) {
> > > +		bc->params = devm_kzalloc(component->dev, bc->max, GFP_KERNEL);
> > > +		if (bc->params == NULL)
> > > +			return -ENOMEM;
> > > +	}
> > > +	return 0;
> > > +}
> > 
> > I wouldn't expect an info call to be allocating anything - why is it
> > doing that?  It's not looking at the alocated data except to see if the
> > allocation succeeded.  What happens if someone manages to do a get or
> > set without having first done an info and why aren't we doing any
> > allocation on initialisation?
> 
> Will move after control initialization.
As I have to initialize the params, and if it's done in probe after
control creation, it's required to iterate over the controls list and
match certain pattern to find the control and then initialize. This doesn't
look elegant. Instead I would prefer adding an init callback in the control
to do this operation. What do you recommend?

-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
