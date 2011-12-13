From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v4 4/6] core: add API header and driver
 header	files
Date: Tue, 13 Dec 2011 23:16:11 +0530
Message-ID: <1323798371.1641.305.camel@vkoul-udesk3>
References: <3CA6C6D9F70D314CA34352990B57DA1507CCB50B02@bgsmsx502.gar.corp.intel.com>
	<s5hobvcppvt.wl%tiwai@suse.de>
	<3CA6C6D9F70D314CA34352990B57DA1507CCB50B1F@bgsmsx502.gar.corp.intel.com>
	<s5hehw8pnz4.wl%tiwai@suse.de> <1323786267.1641.93.camel@vkoul-udesk3>
	<s5haa6wplcb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AE13103B86
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 18:47:09 +0100 (CET)
In-Reply-To: <s5haa6wplcb.wl%tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-12-13 at 16:01 +0100, Takashi Iwai wrote:
> At Tue, 13 Dec 2011 19:54:27 +0530,
> Vinod Koul wrote:
> > 
> > On Tue, 2011-12-13 at 15:04 +0100, Takashi Iwai wrote:
> > > At Tue, 13 Dec 2011 19:21:30 +0530,
> > > Nallasellan, Singaravelan wrote:
> > > > 
> > > > > > > +	size_t buffer_size;
> > > > > > > +	size_t fragment_size;
> > > > > > Can we define buffer_size and fragment_size as unsigned items?
> > > > > 
> > > > > size_t is unsigned.
> > > > > 
> > > > > But, it needs consideration whether size_t is the best choice, since size_t is basically
> > > > > a long, thus its size is different between 32bit and 64bit architectures.  This may lead
> > > > > to mess in many cases when you think of overlapping.
> > > > > 
> > > > Sorry for my mess on size_t.
> > > > I think the assumption here is 32 bits. Should u32 be fine here?
> > > 
> > > This depends pretty much on the demand and the implementation.
> > > Unless a buffer over 4GB is needed, u32 should be OK for buffer_size,
> > > etc.  (Or, in this case, unsigned int would be fine, too.  It's not
> > > necessarily be limited to 32bit.  u32 or such is used usually for the
> > > type that must be 32bit.)
> > I don't think someone would need buffer of 4GB :)
> > 
> > > But, the questions remain for hw_pointer, app_pointer, bytes_*
> > > fields.  Are these supposed to be 32bit or more?  This question is
> > > more important than the buffer size.  The buffer size would be rarely
> > > over 32bit.  But, if hw_pointer or such represents the accumulated
> > > position like ALSA PCM does, you'll face the overlapping problem.
> > > 32bit limit can be reached easily in the real use case.
> > the pointer are offsets within the ring buffer.
> 
> OK, then it's no problem to assume 32bit is enough.
Great :)
> 
> > there are cumulative counters which will get overlapped after the
> > size_t/u32 value.
> 
> Which field specifically?  The cumulative counter has been a problem.
There are two fields in snd_compr_runtime, bytes_written and
bytes_copied. Both are counting cumulative bytes written to ring buffer
and bytes copied by DSP.
Assumption is that they will wrap once they reach max. That should not
cause issue in core.
Then the core will wrap around the timestamp value. My thought was user
lib should always take care of kernel wrapping and provide sufficiently
large tstamp value to application.
> 
> > > When this changes between 32bit and 64bit, think twice about the 32bit
> > > compat-layer on 64bit arch (and the corresponding user-space
> > > implementation)...
> > Is it a fair assumption that userspace compiled for 32 bit should work
> > with 32 bit kernel and same for 64 bit, or does the ABI mandate it be
> > consistent across 32 and 64 bits.
> 
> The 32bit user-space must work with 64bit kernel.  It means, it'd be
> much easier if ABI definition is compatible between 32 and 64bit.
> 
> That is, using a long type in the ABI definition should be definitely
> avoided.  We had long fields in ALSA PCM field definitions, and this
> caused lots of really nasty problems.  So, I tell you -- don't do it
> again.  Learn from the history :)
> 
> Of course, this is about the ABI definition.  But, the internal
> structure (types, etc) usually follows the ABI requirement.  So I
> stated the questions here.
Right. I think we should be pretty decent if we just change the kernel
APIs to u32. Based on that all other non cumulative counter should be
u32 and cumulative ones u64 :)
That was we will not care what bit userland is, and otherthings will
work as expected.

Thanks
-- 
~Vinod
