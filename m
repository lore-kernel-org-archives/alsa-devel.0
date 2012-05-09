From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: [PATCH] ALSA: HDA: Lessen CPU usage when waiting
 for chip to respond
Date: Wed, 09 May 2012 16:25:43 +0530
Message-ID: <1336560943.7277.0.camel@localhost>
References: <1336122355-6017-1-git-send-email-david.henningsson@canonical.com>
	<1336507552.5353.3.camel@localhost> <s5hvck5zky6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B51810466A
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 14:50:51 +0200 (CEST)
In-Reply-To: <s5hvck5zky6.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-05-09 at 12:51 +0200, Takashi Iwai wrote:
> At Wed, 09 May 2012 01:35:52 +0530,
> Arun Raghavan wrote:
> > 
> > On Fri, 2012-05-04 at 11:05 +0200, David Henningsson wrote:
> > > When an IRQ for some reason gets lost, we wait up to a second using
> > > udelay, which is CPU intensive. This patch improves the situation by
> > > waiting about 30 ms in the CPU intensive mode, then stepping down to
> > > using msleep(2) instead. In essence, we trade some granularity in
> > > exchange for less CPU consumption when the waiting time is a bit longer.
> > > 
> > > As a result, PulseAudio should no longer be killed by the kernel
> > > for taking up to much RT-prio CPU time. At least not for *this* reason.
> > > 
> > > Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> > > ---
> > >  sound/pci/hda/hda_intel.c |    6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > Hi Arun,
> > > 
> > > Can you check if this patch resolves your problem with PulseAudio getting
> > > killed by the kernel? If so, we should apply it to the kernel, perhaps even
> > > to stable.
> > > 
> > > // David
> > 
> > Thanks, this fixes the problem for me. Don't know what the official
> > procedure for these things is, but fwiw:
> > 
> > Signed-off-by: Arun Raghavan <arun.raghavan@collabora.co.uk>
> 
> I guess you meant tested-by tag?
> In anyway I took the patch now with Cc to stable.  It'll be included
> in the next pull request to Linus.

I did, and now I know what tag to use the next time. :)

Thanks,
Arun
