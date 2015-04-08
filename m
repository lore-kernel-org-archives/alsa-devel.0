Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DF3132650DB
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 06:35:07 +0200 (CEST)
Date: Wed, 8 Apr 2015 10:17:20 +0530
From: Ramesh Babu <ramesh.babu@intel.com>
Message-ID: <20150408044714.GA6212@ramesh.babu@intel.com>
References: <1427968651-7821-1-git-send-email-vinod.koul@intel.com>
 <1427968651-7821-4-git-send-email-vinod.koul@intel.com>
 <20150406170804.GQ6023@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150406170804.GQ6023@sirena.org.uk>
Subject: Re: [alsa-devel] [RFC 3/3] ALSA: hda - add soc hda bus wrapper
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
Cc: Vinod Koul <vinod.koul@intel.com>, tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, pathes.audio@intel.com
List-ID: <alsa-devel@alsa-project.org>

On Mon, Apr 06, 2015 at 06:08:04PM +0100, Mark Brown wrote:

Hi Takashi, Mark

> On Thu, Apr 02, 2015 at 03:27:31PM +0530, Vinod Koul wrote:
> 
> 
> > +/**
> > + * hda_device_unregister - unregister a hda device
> > + * @pdev: hda device we're unregistering
> > + *
> > + * Unregistration is done in 2 steps. First we release all resources
> > + * and remove it from the subsystem, then we drop reference count by
> > + * calling hda_device_put().
> > + */
> > +void snd_soc_hdac_device_unregister(struct snd_soc_hdac_device *pdev)
> > +{
> > +	snd_hdac_device_exit(&pdev->hdac);
> > +	snd_hdac_device_unregister(&pdev->hdac);
> > +	snd_soc_hdac_device_put(pdev);
> > +}
> > +EXPORT_SYMBOL_GPL(snd_soc_hdac_device_unregister);
> 
> Takashi queried bits of this too...  I have to say I don't entirely
> understand how this device management is supposed to work and the lack
> of any users in the current series isn't giving me anything to refer to
> here, perhaps it's all obvious given them but I don't have them just
> now.  A lot of this looks like it's boilerplate which should be
> duplicating something device modelish and there certainly seem to be
> some things with object lifetimes that need paying attention to.
> 
> All the commit message says is "create asoc wrppers on top of hdac", can
> we have more words please?

Will fix your comments in next version of the RFC patches.
-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
