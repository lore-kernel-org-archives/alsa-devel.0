From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] Re: 2.6.26-rc1 regression: ISA DMA broken
	(bisected)
Date: Sat, 31 May 2008 00:11:37 +0200
Message-ID: <48407B99.4080209@keyaccess.nl>
References: <4823AAF2.7070102@keyaccess.nl> <482B38D6.5030804@keyaccess.nl>
	<48406E8D.8050408@keyaccess.nl>
	<200805301543.42208.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DA5C24418
	for <alsa-devel@alsa-project.org>;
	Sat, 31 May 2008 00:08:32 +0200 (CEST)
In-Reply-To: <200805301543.42208.bjorn.helgaas@hp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>, ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: alsa-devel@alsa-project.org

On 30-05-08 23:43, Bjorn Helgaas wrote:

> On Friday 30 May 2008 03:15:57 pm Rene Herman wrote:

>> It gets uglier. ALSA ISA drivers (for cards that exist both as legacy 
>> and as ISAPnP at least) keep a merged legacy/isapnp model; PnP is used 
>> mostly for initializing global variables that the same old legacy probe 
>> routines then reference. This means that beyond that global resource 
>> init step the specific struct device is no longer available. Without 
>> restructuring too many things really only fixable through other hacks 
>> again such as a global dma_dev[] array or some such.
>>
>>  From the viewpoint of PnP itself setting the dma_mask for a pnp_card (a 
>> pnp_dev collection) makes isolated sense so if no objections, I'll 
>> submit the attached after all. From the ALSA side we'd then pass the 
>> card dev (which we'd also do for isa_dev) and keep in mind that we might 
>> want to get more specific if over time structure permits it.
>>
>> struct snd_pcm already has its own struct device * which would be the 
>> right one here but it's setting that which gets ugly...
> 
> Looks good to me.  It does sound like a lot of work and possibly
> more risk than it's worth to fix up some of this stuff.

Fairly invasive at least. The good thing though is that with the recent 
pnp_manual_config_dev() removal the PnP drivers have no actual need/use 
for this global variable model anymore and now I have a great excuse for 
rewriting them. That can happen one at a time though...

> I do still wonder whether any non-x86 architectures need similar
> fixes in dma_alloc_coherent(), i.e., check for dev==NULL and fall
> back to a 24-bit DMA mask.

Hrmmpf. Good question. In sound/isa, we've had a but of alpha spottyness 
over time but nothing which would seem to be related.

> Acked-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Thanks. I'll assume Andrew picks it up from the CC...

Rene.
