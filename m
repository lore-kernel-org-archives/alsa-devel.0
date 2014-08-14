Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F8822615F7
 for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2014 12:43:36 +0200 (CEST)
Date: Thu, 14 Aug 2014 15:51:56 +0530
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Message-ID: <20140814102152.GA8028@vinod.koul@linux.intel.com>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-11-git-send-email-subhransu.s.prusty@intel.com>
 <20140813201454.GS17528@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140813201454.GS17528@sirena.org.uk>
Subject: Re: [alsa-devel] [v4 10/12] ASoC: Intel: mrfld: add the DSP DAPM
	widgets
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

On Wed, Aug 13, 2014 at 09:14:54PM +0100, Mark Brown wrote:
> On Mon, Aug 04, 2014 at 03:16:01PM +0530, Subhransu S. Prusty wrote:
> 
> > +	pr_debug("%s: widget = %s\n", __func__, w->name);
> > +	for (i = 0; i < w->num_kcontrols; i++) {
> > +		if (dapm_kcontrol_get_value(w->kcontrols[i])) {
> > +			mc = (struct soc_mixer_control *)(w->kcontrols[i])->private_value;
> > +			val |= 1 << mc->shift;
> > +		}
> > +	}
> 
> All my concerns about this still stand - using something called
> _get_value() to do something other than read the control value (which
> this does - it uses it as a boolean then does something else to read the
> value) which doesn't seem good.

I think this can be optimized. This need a bit of rework in the code, but
need to check. But this would need an assumption that the controls are
created in order.

for (i = 0; i < w->num_kcontrols; i++) {
	if (dapm_kcontrol_get_value(w->kcontrols[i])) {
		val |= 1 << i;
}

Is this ok?

-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
