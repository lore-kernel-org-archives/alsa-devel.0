From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 3/4] ASoC: Intel - add makefile support
	for SKL driver
Date: Tue, 16 Jun 2015 10:14:58 +0530
Message-ID: <20150616044458.GU28601@localhost>
References: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
 <1434040438-14535-4-git-send-email-vinod.koul@intel.com>
 <20150615155752.GV18309@sirena.org.uk>
 <s5hmw00gby8.wl-tiwai@suse.de>
 <20150615185405.GA18309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 37E3626070D
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 06:43:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150615185405.GA18309@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2015 at 07:54:05PM +0100, Mark Brown wrote:
> On Mon, Jun 15, 2015 at 06:42:39PM +0200, Takashi Iwai wrote:
> > Mark Brown wrote:
> > > On Thu, Jun 11, 2015 at 10:03:57PM +0530, Vinod Koul wrote:
> 
> > > > +	  HD-audio driver.  A larger buffer (e.g. 2048) is preferred
> > > > +	  for systems using PulseAudio.  The default 64 is chosen just
> > > > +	  for compatibility reasons.
> 
> > > What are those compatibility reasons - why should users have to worry
> > > about this?
> 
> > ... if a user wants to reduce the memory foot print.
> > 2MB buffers for each stream are significant size, supposing that it
> > can have 16 streams.
> 
> That doesn't sound like a compatibility thing though?  Compatibility
> makes it sound like things will break rather than we'll just use too
> much RAM.  Is there anything else going on?
> 
> > > Should this be a module parameter or something?
> 
> > The buffers can be reallocated dynamically via procfs in general, but
> > it's not practical and intuitive.  That's why the similar option was
> > provided for HDA legacy driver.  It was the time when PA started
> > accepted slowly.  I don't know whether it makes sense for SKL ASoC
> > driver, though -- it's up to you guys.
> 
> I'm not against having configuration, I just want it to be configuration
> that people can understand and it seems better to make the default be
> that for PulseAudio given how much of the common case it is now.
> Something like "make this smaller to reduce the default memory
> footprint" for example.
We have been using defaults for our testing, and PA and other usermode
entities seem happy :)

Btw Mark, the text is not our invention. This exists in legacy driver
as well.

Said that, i see two thing to be done here, one is to remove this in SKL
driver for now and if required add it later with better explanation as for
now usermode seems happy atm, so may not be required right away

Second one is to actually make this in core, move the flag in legacy driver to
hdac parts and be used in legacy driver as well as anywhere else

Let me know which one looks good to you guys

Thanks
-- 
~Vinod
