From: Greg KH <gregkh@suse.de>
Subject: Re: sst: Intel SST audio driver
Date: Tue, 19 Oct 2010 06:13:40 -0700
Message-ID: <20101019131340.GB7498@suse.de>
References: <mailman.1.1287396001.20373.alsa-devel@alsa-project.org>
	<438BB0150E931F4B9CE701519A44630104BE811785@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 26A74103883
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 15:38:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104BE811785@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Harsha,
	Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 19, 2010 at 12:05:38PM +0530, Koul, Vinod wrote:
>  
> > ... so the whole messages can be reduced to a sentense:
> >   "Rewrite the driver based on ASoC!"
> > 
> > Then it's a question to Intel guys.  If they would like to support for
> > it, we can happily wait for it before merging.  If they don't want but
> > keep as is, then questions are:
> >  - whether to keep it in upstream or not
> >  - where to keep it, in staging or in sound tree
> > 
> > and, the latter question is nothing but a bikeshedding; in anyway it's
> > a second choice, after all.  We should spend time for more useful
> > things :)
> 
> Yes Intel is planning to rewrite the sound card driver for ASoC.
> I will take us little time for that :-)
> 
> Meanwhile IMO it would be great to have this driver in staging or in sound 
> whichever you guys agree to

As the userspace api is going to change, and Intel is committed to redo
the api to use ASoC, I suggest it goes into the staging tree.  That will
force Intel to live up to that promise, otherwise the code will be
dropped from the tree.

thanks,

greg k-h
