From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 6/6] ASoC: Intel: Skylake: remove call
	to pci_dev_put
Date: Wed, 16 Mar 2016 20:14:05 +0530
Message-ID: <20160316144405.GT13211@localhost>
References: <1458040168-3769-1-git-send-email-vinod.koul@intel.com>
 <1458040168-3769-7-git-send-email-vinod.koul@intel.com>
 <20160316100829.GS2566@sirena.org.uk>
 <20160316105244.GR13211@localhost>
 <20160316110310.GT2566@sirena.org.uk>
 <s5hwpp2d5ar.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B958266018
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 15:40:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwpp2d5ar.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 16, 2016 at 12:35:08PM +0100, Takashi Iwai wrote:
> On Wed, 16 Mar 2016 12:03:10 +0100,
> Mark Brown wrote:
> > 
> > On Wed, Mar 16, 2016 at 04:22:44PM +0530, Vinod Koul wrote:
> > > On Wed, Mar 16, 2016 at 10:08:29AM +0000, Mark Brown wrote:
> > 
> > > > Why is the fix for this not to call pci_dev_get()?
> > 
> > > Why do I need either, I see no reason why driver should be doing this,
> > > so removed :)
> > 
> > Well, the PCI documentation says that drivers are expected to record a
> > reference to their devices in probe().  This is a bit unusual given that
> > normally the driver core takes a reference to the device for us but
> > presumably there's some reason for this?
> 
> Maybe the document is obsoleted.  The PCI core, at least the probe /
> remove via the normal PCI bus, takes pci_dev_get() and pci_dev_put()
> already there.

Yes that is my understanding too, that is why we removed this from driver
here..

Mark, is this fine now?

-- 
~Vinod
