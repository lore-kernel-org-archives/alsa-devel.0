From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ASoC: topology: Add support for TLV bytes
	control
Date: Sat, 15 Aug 2015 15:04:53 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8480D0537@SHSMSX101.ccr.corp.intel.com>
References: <2758b949231d10b23f1c8285fb3923db06fb1a46.1439345293.git.mengdong.lin@intel.com>
 <20150814191742.GJ10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id ECBBF26512B
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 17:04:58 +0200 (CEST)
In-Reply-To: <20150814191742.GJ10748@sirena.org.uk>
Content-Language: en-US
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Saturday, August 15, 2015 3:18 AM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org; tiwai@suse.de; Girdwood, Liam R
> Subject: Re: [PATCH] ASoC: topology: Add support for TLV bytes control
> 
> On Wed, Aug 12, 2015 at 10:10:51AM +0800, mengdong.lin@intel.com wrote:
> 
> > Allow vendor drivers to define bespoke bytes ext handlers and IDs for
> > TLV bytes controls. And the topology core will bind these handlers by
> > matching IDs defined by the vendor driver and user space topology data
> > file.
> 
> > @@ -513,6 +517,15 @@ static int soc_tplg_kcontrol_bind_io(struct
> > snd_soc_tplg_ctl_hdr *hdr,  {
> >  	int i;
> >
> > +	/* TLV bytes controls don't need get/put ops */
> 
> AFAICT it's actually the case that we're binding them later rather than that
> the ops aren't needed.  Isn't that what soc_tplg_bytes_ext_bind_io() does?
> 
> > +	if (k->iface & SNDRV_CTL_ELEM_IFACE_MIXER
> > +		&& k->access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE
> > +		&& k->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK
> > +		&& hdr->ops.info == SND_SOC_TPLG_CTL_BYTES) {
> > +			k->info = snd_soc_bytes_info_ext;
> > +			return 0;
> > +	}
> > +
> 
> I'm confused.  What's special about TLV controls compared to other controls,
> why are the existing bespoke handlers which get bound in this function not
> sufficient and why don't we bind the TLV bespoke handlers here?

Okay. I'll bind the TLV bespoke handlers here, and remove soc_tplg_bytes_ext_bind_io().
So all ops binding will be handled in a single function soc_tplg_kcontrol_bind_io().

> Having two different classes of bespoke handlers like this both called bespoke
> handlers seems like it's going to lead to problems - either bringing the
> interfaces closer together or naming them in a way that clarifies their
> meaning seems better.  Instead of just calling them "bespoke handlers" we
> should probably just call them handlers for whatever kind of control they're
> for and probably bind them first rather than second so we're doing more
> specific to less specific handling.
> That way drivers can also have specific handling for things the topology data
> didn't anticipate they'd need it for which seems like it might come in handy.

Are you suggesting that we bind bespoke handlers at first and then the standard handlers?
Since the bespoke handlers means more vendor-specific handling that need to be taken care at first.

We add comments to explain these two different classes of bespoke handlers.
struct snd_soc_tplg_ops {
...
	/* bespoke kcontrol handlers available for binding */
	const struct snd_soc_tplg_kcontrol_ops *io_ops;
	int io_ops_count;

	/* bespoke bytes ext handlers available for binding */
	const struct snd_soc_tplg_bytes_ext_ops *bytes_ext_ops;
	int bytes_ext_ops_count;
};

Thanks
Mengdong
