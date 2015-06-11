From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v8 2/3] ALSA: hdac_ext: add hdac extended
	controller
Date: Thu, 11 Jun 2015 09:13:46 +0530
Message-ID: <20150611034346.GX28601@localhost>
References: <1433941562-5778-1-git-send-email-vinod.koul@intel.com>
 <1433941562-5778-3-git-send-email-vinod.koul@intel.com>
 <s5hr3pj8kzf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 53EDA2612AE
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 05:42:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hr3pj8kzf.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 10, 2015 at 08:41:08PM +0200, Takashi Iwai wrote:
> At Wed, 10 Jun 2015 18:36:01 +0530,
> Vinod Koul wrote:
> > 
> > +/**
> > + * snd_hdac_ext_bus_get_link_index - get link based on codec name
> > + * @ebus: HD-audio extended core bus
> > + * @codec_name: codec name
> > + */
> > +struct hdac_ext_link *snd_hdac_ext_bus_get_link(struct hdac_ext_bus *ebus,
> > +						 const char *codec_name)
> > +{
> > +	int i;
> > +	struct hdac_ext_link *hlink = NULL;
> > +	char name[32];
> > +
> > +	list_for_each_entry(hlink, &ebus->hlink_list, list) {
> > +		for (i = 0; i < HDA_MAX_CODECS; i++) {
> > +			snprintf(name, sizeof(name), "codec#%03x", hlink->codec[i]);
> > +			if (!strncmp(name, codec_name, strlen(codec_name)))
> > +				return hlink;
> 
> Is this name supposed to be identical with the string the patch 1
> sets?  If so, this looks incompatible.
Yes my miss :(

This also means that I would be required to save the idx number, so I am
thinking of returning the idx value in snd_hdac_ext_bus_device_init() and
then pass on snd_hdac_ext_bus_map_codec_to_link() API which can save this in
the array and then use idx here as well and use I like below so will add
this

> 
> Also, it'd be easier to parse the string only once like:
> 
> 	int bus_idx, addr;
> 
> 	if (sscanf(codec_name, "ehdaudio%dD%d", &bus_idx, &addr) != 2)
> 		return NULL;
> 	if (ebus->index != bus_idx)
> 		return NULL;
> 	list_for_each_entry(hlink, &ebus->hlink_list, list)
> 		if (hlink->lsdiid && (0x1 << addr))
> 			return hlink;
> 
> 	return NULL;

Thanks

-- 
~Vinod
