From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v4 4/6] core: add API header and driver
 header	files
Date: Tue, 13 Dec 2011 19:54:27 +0530
Message-ID: <1323786267.1641.93.camel@vkoul-udesk3>
References: <3CA6C6D9F70D314CA34352990B57DA1507CCB50B02@bgsmsx502.gar.corp.intel.com>
	<s5hobvcppvt.wl%tiwai@suse.de>
	<3CA6C6D9F70D314CA34352990B57DA1507CCB50B1F@bgsmsx502.gar.corp.intel.com>
	<s5hehw8pnz4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D6FC103B88
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 15:25:22 +0100 (CET)
In-Reply-To: <s5hehw8pnz4.wl%tiwai@suse.de>
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

On Tue, 2011-12-13 at 15:04 +0100, Takashi Iwai wrote:
> At Tue, 13 Dec 2011 19:21:30 +0530,
> Nallasellan, Singaravelan wrote:
> > 
> > > > > +	size_t buffer_size;
> > > > > +	size_t fragment_size;
> > > > Can we define buffer_size and fragment_size as unsigned items?
> > > 
> > > size_t is unsigned.
> > > 
> > > But, it needs consideration whether size_t is the best choice, since size_t is basically
> > > a long, thus its size is different between 32bit and 64bit architectures.  This may lead
> > > to mess in many cases when you think of overlapping.
> > > 
> > Sorry for my mess on size_t.
> > I think the assumption here is 32 bits. Should u32 be fine here?
> 
> This depends pretty much on the demand and the implementation.
> Unless a buffer over 4GB is needed, u32 should be OK for buffer_size,
> etc.  (Or, in this case, unsigned int would be fine, too.  It's not
> necessarily be limited to 32bit.  u32 or such is used usually for the
> type that must be 32bit.)
I don't think someone would need buffer of 4GB :)

> But, the questions remain for hw_pointer, app_pointer, bytes_*
> fields.  Are these supposed to be 32bit or more?  This question is
> more important than the buffer size.  The buffer size would be rarely
> over 32bit.  But, if hw_pointer or such represents the accumulated
> position like ALSA PCM does, you'll face the overlapping problem.
> 32bit limit can be reached easily in the real use case.
the pointer are offsets within the ring buffer.
there are cumulative counters which will get overlapped after the
size_t/u32 value.
> 
> When this changes between 32bit and 64bit, think twice about the 32bit
> compat-layer on 64bit arch (and the corresponding user-space
> implementation)...
Is it a fair assumption that userspace compiled for 32 bit should work
with 32 bit kernel and same for 64 bit, or does the ABI mandate it be
consistent across 32 and 64 bits. In the latter case we should change
the ones in kernel ABI to consistent size of u32/u64. IMO u32 should be
fine, please let me know if anyone thinks otherwise.
In former size_t should be fine :)

-- 
~Vinod
