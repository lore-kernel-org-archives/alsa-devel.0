Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 980C72655A0
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 06:49:00 +0200 (CEST)
Date: Tue, 19 Aug 2014 09:57:11 +0530
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Message-ID: <20140819042706.GA20885@vinod.koul@linux.intel.com>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-11-git-send-email-subhransu.s.prusty@intel.com>
 <20140813201454.GS17528@sirena.org.uk>
 <20140814102152.GA8028@vinod.koul@linux.intel.com>
 <20140814130708.GX17528@sirena.org.uk>
 <20140818042805.GA14041@vinod.koul@linux.intel.com>
 <20140818135633.GU14537@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140818135633.GU14537@sirena.org.uk>
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

On Mon, Aug 18, 2014 at 08:56:33AM -0500, Mark Brown wrote:
> On Mon, Aug 18, 2014 at 09:58:11AM +0530, Subhransu S. Prusty wrote:
> > On Thu, Aug 14, 2014 at 02:07:08PM +0100, Mark Brown wrote:
> 
> > > > for (i = 0; i < w->num_kcontrols; i++) {
> > > > 	if (dapm_kcontrol_get_value(w->kcontrols[i])) {
> > > > 		val |= 1 << i;
> > > > }
> 
> > > > Is this ok?
> 
> > > No, that doesn't seem safe.  Why not read the data from the control - if
> > > we were calling a function which returned the value that'd be much
> > > clearer.
> 
> > So lets step back and see what is required here.
> 
> > I get a mixer update for one of the inputs of the mixer. This needs to be
> > communicated to the DSP via the IPC. But the IPC expects that we send all
> > the values of all the inputs of a mixer to the DSP.
> 
> > That is why here we are reading the all mixer inputs to find the values and
> > send the bitmap of all inputs.
> 
> > So from the driver if I have to find out what is the value of the inputs in
> > mixer, how do I do that, is there a simpler way? Or should we push
> > this/<something else> into framework to query
> 
> The problem is that it looks like you are reading the value from the
> control, treating it as a boolean and discarding it.
Well the mixer input is on/off, so it should be treated as boolean. How will
it have any other value.

Btw I am thinking to create an API dapm_kcontrol_get_mixer_values() which can
give me bit map of all the mixer inputs, so I can use it and send IPCs to
the DSP.




-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
