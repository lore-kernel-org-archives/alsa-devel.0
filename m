From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [v4 10/12] ASoC: Intel: mrfld: add the DSP DAPM
	widgets
Date: Mon, 18 Aug 2014 09:58:11 +0530
Message-ID: <32319.5782643326$1408337423@news.gmane.org>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-11-git-send-email-subhransu.s.prusty@intel.com>
 <20140813201454.GS17528@sirena.org.uk>
 <20140814102152.GA8028@vinod.koul@linux.intel.com>
 <20140814130708.GX17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C90A9265375
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 06:49:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140814130708.GX17528@sirena.org.uk>
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 14, 2014 at 02:07:08PM +0100, Mark Brown wrote:
> On Thu, Aug 14, 2014 at 03:51:56PM +0530, Subhransu S. Prusty wrote:
> > On Wed, Aug 13, 2014 at 09:14:54PM +0100, Mark Brown wrote:
> > > On Mon, Aug 04, 2014 at 03:16:01PM +0530, Subhransu S. Prusty wrote:
> 
> > > > +	pr_debug("%s: widget = %s\n", __func__, w->name);
> > > > +	for (i = 0; i < w->num_kcontrols; i++) {
> > > > +		if (dapm_kcontrol_get_value(w->kcontrols[i])) {
> > > > +			mc = (struct soc_mixer_control *)(w->kcontrols[i])->private_value;
> > > > +			val |= 1 << mc->shift;
> > > > +		}
> > > > +	}
> 
> > > All my concerns about this still stand - using something called
> > > _get_value() to do something other than read the control value (which
> > > this does - it uses it as a boolean then does something else to read the
> > > value) which doesn't seem good.
> 
> > I think this can be optimized. This need a bit of rework in the code, but
> > need to check. But this would need an assumption that the controls are
> > created in order.
> 
> > for (i = 0; i < w->num_kcontrols; i++) {
> > 	if (dapm_kcontrol_get_value(w->kcontrols[i])) {
> > 		val |= 1 << i;
> > }
> 
> > Is this ok?
> 
> No, that doesn't seem safe.  Why not read the data from the control - if
> we were calling a function which returned the value that'd be much
> clearer.
So lets step back and see what is required here.

I get a mixer update for one of the inputs of the mixer. This needs to be
communicated to the DSP via the IPC. But the IPC expects that we send all
the values of all the inputs of a mixer to the DSP.

That is why here we are reading the all mixer inputs to find the values and
send the bitmap of all inputs.

So from the driver if I have to find out what is the value of the inputs in
mixer, how do I do that, is there a simpler way? Or should we push
this/<something else> into framework to query

--



-- 
