From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC v2] ASoC: core: add a helper for extended
 byte controls using TLV
Date: Tue, 15 Jul 2014 21:00:59 +0530
Message-ID: <20140715153059.GH4387@intel.com>
References: <1405406865-10636-1-git-send-email-vinod.koul@intel.com>
 <s5hlhrur8nu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 235C9261683
 for <alsa-devel@alsa-project.org>; Tue, 15 Jul 2014 17:34:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hlhrur8nu.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Charles Keepax <Charles.Keepax@Wolfsonmicro.com>, Dimitris Papastamos <Dimitris.Papastamos@Wolfsonmicro.com>, lgirdwood@gmail.com, broonie@kernel.org, Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 15, 2014 at 04:36:21PM +0200, Takashi Iwai wrote:
> At Tue, 15 Jul 2014 12:17:45 +0530,
> Vinod Koul wrote:
> > 
> > From: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
> > 
> > ALSA supports arbitrary length TLVs for each kcontrol that can be used
> > to pass metadata about the control (e.g. volumes, enum information). The
> > same transport mechanism is now used for arbitrary length data by
> > defining a new helper.
> > 
> > Signed-off-by: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> > As discussed in [1] we are adding a new approach to solve the byte control
> > extensions by using existing TLVs and combining them with byte controls.  The
> > usermode on seeing byte control + TLV can treat it differently as it does for
> > control + TLV combination today. This way we don't change kernel API and
> > existing users will be happy, while providing embedded folks facility to pass
> > large bytes data to kcontrols
> > [1]:
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2013-November/069483.html
> 
> Yeah, this would bypass the limitation nicely.
Yes thats what I realized when Omair pointed this out!

> > +int snd_soc_bytes_tlv_callback(struct snd_kcontrol *kcontrol, int op_flag,
> > +				unsigned int size, unsigned int __user *tlv)
> > +{
> > +	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
> > +	unsigned int count = size < params->max ? size : params->max;
> > +
> > +	switch (op_flag) {
> > +	case 0:
> > +		if (params->get)
> > +			params->get(tlv, count);
> > +		break;
> > +	case 1:
> > +		if (params->put)
> > +			params->put(tlv, count);
> > +		break;
> 
> No error propagation from the callback?
> Also, if a driver doesn't provide get or put, it gets no error?
Will fix that
> 
> BTW, about the value of op_flag: I have a patch to define the
> constants (attached below), which I forgot until now.  Now I put it
> into topic/tlv-opflag branch of sound git tree.  If you'd like to use
> the new constants, merge (or base on) this branch.
yes rebased now..

-- 
~Vinod
