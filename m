From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v6 01/11] ASoC: topology: Make manifest
 backward compatible from ABI v4
Date: Tue, 1 Nov 2016 13:49:46 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F88198AB4B@shsmsx102.ccr.corp.intel.com>
References: <cover.1476166990.git.mengdong.lin@linux.intel.com>
 <39acbd6c55ca9ac0855001d5a67d7d96fddd0c7b.1476166990.git.mengdong.lin@linux.intel.com>
 <20161028184721.ttqte2jot5crlz2y@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 539ED261560
 for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2016 14:49:52 +0100 (CET)
In-Reply-To: <20161028184721.ttqte2jot5crlz2y@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Shah, Hardik T" <hardik.t.shah@intel.com>, "Singh, Guneshwor O" <guneshwor.o.singh@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Saturday, October 29, 2016 2:47 AM
> To: mengdong.lin@linux.intel.com
> Cc: alsa-devel@alsa-project.org; tiwai@suse.de;
> liam.r.girdwood@linux.intel.com; Shah, Hardik T <hardik.t.shah@intel.com>;
> Singh, Guneshwor O <guneshwor.o.singh@intel.com>; Koul, Vinod
> <vinod.koul@intel.com>; Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>;
> Lin, Mengdong <mengdong.lin@intel.com>
> Subject: Re: [PATCH v6 01/11] ASoC: topology: Make manifest backward
> compatible from ABI v4
> 
> On Tue, Oct 11, 2016 at 02:36:42PM +0800, mengdong.lin@linux.intel.com
> wrote:
> 
> > +static int manifest_new_ver(struct soc_tplg *tplg,
> > +			    struct snd_soc_tplg_manifest *src,
> > +			    struct snd_soc_tplg_manifest **manifest) {
> > +	struct snd_soc_tplg_manifest *dest;
> > +	struct snd_soc_tplg_manifest_v4 *src_v4;
> > +
> > +	*manifest = NULL;
> > +
> > +	if (src->size != sizeof(*src_v4)) {
> > +		dev_err(tplg->dev, "ASoC: invalid manifest size\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_warn(tplg->dev, "ASoC: old version of manifest\n");
> 
> The way this function is written it's not going to scale to any future ABI
> churn, it's not set up to handle multiple versions at all.

If future ABI change affects this manifest struct, we'll extend this function to map all old versions to the latest one. 

Since we already add some reserved fields in the manifest, so we can use those reserved fields to assure backward compatibility and there could be no change on this function.

Thanks
Mengdong
