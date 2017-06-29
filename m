From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/4] ASoC: Intel: Skylake: Add debugfs
	support
Date: Thu, 29 Jun 2017 13:26:49 +0530
Message-ID: <20170629075649.GG19154@localhost>
References: <20170629065604.30105-1-guneshwor.o.singh@intel.com>
 <20170629065604.30105-2-guneshwor.o.singh@intel.com>
 <e7607f1b-540b-fcda-a784-918ef9eafbeb@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B32CB266E2C
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 09:55:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e7607f1b-540b-fcda-a784-918ef9eafbeb@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, liam.r.girdwood@linux.intel.com, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vunny Sodhi <vunnyx.sodhi@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 29, 2017 at 04:43:38PM +0900, Takashi Sakamoto wrote:
> Hi,

Hi Takashi,

> > +struct skl_debug *skl_debugfs_init(struct skl *skl)
> > +{
> > +	struct skl_debug *d;
> > +
> > +	d = devm_kzalloc(&skl->pci->dev, sizeof(*d), GFP_KERNEL);
> > +	if (!d)
> > +		return NULL;
> > +
> > +	/* create the root dir first */
> > +	d->fs = debugfs_create_dir(KBUILD_MODNAME, NULL);
> 
> ALSA SoC part has a debugfs support. It adds "asoc" node into debugfs
> mount point and export "snd_soc_debugfs_root" symbol as a root node. I
> think it a better idea to collect relevant nodes into the place, rather
> than dispersing them.

Yes we can use that, but then this is very driver specific info, does it
make sense to keep under framework 'asoc' ?

If we decide to use that, a more intuitive place might be "platform" rather
than "asoc" which creates dependency on sound card creation which might happen
much later.

for debug, I would like to avoid complexity and go with simple device
approach...

> 
> As a quick glance, "snd_soc_skl" depends on "snd_soc_core", which
> exports the symbol. So no matter to dependencies.
> 
> $ lsmod | grep snd_soc_core
> snd_soc_core          233472  1 snd_soc_skl
> $ mount | grep debugfs
> debugfs on /sys/kernel/debug type debugfs (rw,relatime)
> $ sudo find /sys/kernel/debug/asoc
> /sys/kernel/debug/asoc
> /sys/kernel/debug/asoc/platforms
> /sys/kernel/debug/asoc/dais
> /sys/kernel/debug/asoc/codecs
> 
> $ cd mainline.git/
> $ git grep snd_soc_debugfs_root sound/soc/soc-core.c | grep EXPORT
> sound/soc/soc-core.c:EXPORT_SYMBOL_GPL(snd_soc_debugfs_root);
> 
> 
> Regards
> 
> Takashi Sakamoto

-- 
~Vinod
