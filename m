From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH v4 4/6] core: add API header and driver
 header	files
Date: Tue, 13 Dec 2011 19:21:30 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCB50B1F@bgsmsx502.gar.corp.intel.com>
References: <3CA6C6D9F70D314CA34352990B57DA1507CCB50B02@bgsmsx502.gar.corp.intel.com>
	<s5hobvcppvt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id D8DC8103B6E
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 14:51:37 +0100 (CET)
In-Reply-To: <s5hobvcppvt.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Vinod Koul <vinod.koul@linux.intel.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

> > > +	size_t buffer_size;
> > > +	size_t fragment_size;
> > Can we define buffer_size and fragment_size as unsigned items?
> 
> size_t is unsigned.
> 
> But, it needs consideration whether size_t is the best choice, since size_t is basically
> a long, thus its size is different between 32bit and 64bit architectures.  This may lead
> to mess in many cases when you think of overlapping.
> 
Sorry for my mess on size_t.
I think the assumption here is 32 bits. Should u32 be fine here?
