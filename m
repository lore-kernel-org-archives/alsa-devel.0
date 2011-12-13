From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH v4 4/6] core: add API header and driver
 header	files
Date: Tue, 13 Dec 2011 18:32:54 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCB50B0B@bgsmsx502.gar.corp.intel.com>
References: <3CA6C6D9F70D314CA34352990B57DA1507CCB50B02@bgsmsx502.gar.corp.intel.com>
	<20111213125134.GM7148@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F93C103B53
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 14:03:02 +0100 (CET)
In-Reply-To: <20111213125134.GM7148@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, Vinod Koul <vinod.koul@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

> > > +struct snd_compr_runtime {
> > > +	snd_pcm_state_t state;
> > > +	struct snd_compr_ops *ops;
> > > +	void *buffer;
> 
> > Can we define buffer as char *?
> 
> Clearly we *can* but why would we want to do that for a pointer to unstructured
> data?
True, it will always be pointer to bytes. u8 could also be used. 
No big advantage here. It will be clear.
> 
> > > +	size_t buffer_size;
> > > +	size_t fragment_size;
> 
> > Can we define buffer_size and fragment_size as unsigned items?
> > Can we have negative size here?
> 
> Again, what is the advantage in doing this?

The size will be positive anyways. Why don't we do it?
No big advantage here as well. It will be clear.
