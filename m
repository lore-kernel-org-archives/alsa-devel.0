From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 4/6] ASoC: Intel: Add trace support for
 Haswell/Broadwell SST IPC messages.
Date: Mon, 24 Feb 2014 19:50:25 +0000
Message-ID: <1393271425.2323.60.camel@loki>
References: <1392932927-9725-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392932927-9725-4-git-send-email-liam.r.girdwood@linux.intel.com>
 <20140221051906.GD25940@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F26E265514
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 20:56:13 +0100 (CET)
In-Reply-To: <20140221051906.GD25940@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-02-21 at 14:19 +0900, Mark Brown wrote:
> On Thu, Feb 20, 2014 at 09:48:45PM +0000, Liam Girdwood wrote:
> > Provide a trace mechanism for debugging Haswell/Broadwell specific SST
> > IPC messages.
> 
> Applied, thanks.
> 
> > +	TP_STRUCT__entry(
> > +		__field(	unsigned int,	status		)
> > +		__field(	unsigned int,	mask		)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->status = status;
> > +		__entry->mask = mask;
> > +	),
> > +
> > +	TP_printk("status 0x%8.8x mask 0x%8.8x",
> > +		(unsigned int)__entry->status, (unsigned int)__entry->mask)
> 
> I found out the other day that the trace infrastructure has a neat
> helper called __print_symbolic which can decode things - might be
> helpful for some of these, though I don't think it does bitfields it
> might help with making the IPC messages more legible.

Interesting, will be useful for sure. Will be worth looking at when we
integrate more features in the FW (and improve the trace SNR at the same
time) :)

Liam
