From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [RFC PATCH 1/3] ASoC: core: do not unload topology
 in unregister_component()
Date: Thu, 04 Apr 2019 19:23:54 -0700
Message-ID: <c99769e7a08a7402add146e27ee7dc191b119232.camel@linux.intel.com>
References: <20190405003040.8709-1-ranjani.sridharan@linux.intel.com>
 <20190405003040.8709-2-ranjani.sridharan@linux.intel.com>
 <20190405021729.GB2803@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA403F80792
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 04:23:58 +0200 (CEST)
In-Reply-To: <20190405021729.GB2803@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2019-04-05 at 09:17 +0700, Mark Brown wrote:
> On Thu, Apr 04, 2019 at 05:30:38PM -0700, Ranjani Sridharan wrote:
> > Typically, topology is loaded when the card is registered
> > by the machine driver and the link components are probed.
> > Therefore, it should be unloaded when the link components
> > are removed. This will make the register/unregister component
> > methods balanced.
> >  			continue;
> >  
> > -		snd_soc_tplg_component_remove(component,
> > -					      SND_SOC_TPLG_INDEX_ALL);
> >  		snd_soc_component_del_unlocked(component);
> >  		found = 1;
> 
> Isn't this a robustness fix?  It's just freeing anything that's left
> over, it doesn't free specific stuff and shouldn't stop anything else
> freeing that before so if we made a mistake earlier on it'll clean up
> after you.
Hi Mark,

Agree that this might make the clean up robust. But today we call this
only when the component is unregistered and that's causing a null
pointer dereference. So what we really need to do is to remove the
topology in remove() first. 

Thanks,
Ranjani 

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
