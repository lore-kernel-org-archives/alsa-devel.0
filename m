From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [RFC PATCH 1/3] ASoC: core: do not unload topology
 in unregister_component()
Date: Thu, 04 Apr 2019 19:33:33 -0700
Message-ID: <858c15b872265c0031c27164fb1cb5466a73a12a.camel@linux.intel.com>
References: <20190405003040.8709-1-ranjani.sridharan@linux.intel.com>
 <20190405003040.8709-2-ranjani.sridharan@linux.intel.com>
 <20190405021729.GB2803@sirena.org.uk>
 <c99769e7a08a7402add146e27ee7dc191b119232.camel@linux.intel.com>
 <20190405022821.GC2803@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 206E5F8071D
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2019 04:33:36 +0200 (CEST)
In-Reply-To: <20190405022821.GC2803@sirena.org.uk>
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

On Fri, 2019-04-05 at 09:28 +0700, Mark Brown wrote:
> On Thu, Apr 04, 2019 at 07:23:54PM -0700, Ranjani Sridharan wrote:
> 
> > Agree that this might make the clean up robust. But today we call
> > this
> > only when the component is unregistered and that's causing a null
> > pointer dereference. So what we really need to do is to remove the
> > topology in remove() first. 
> 
> If that's what this is doing then the changelog should reflect that
> it's
> fixing a null pointer dereference rather than talking about these
> separate issues.

Sure, I think I will drop the first patch as like you said it is good
for robustness. Adding the remove() callback for skl and sof will fix
the null pointer dereference issue. 

But I really need some feedback from you on the third patch. I think
that's the most invasive and I'm not sure about how to go about
removing the topology before the snd_card is freed without removing
the link components while unbinding the card.

Thanks,
Ranjani
