From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 1/2] hda - fix ELD memory leak
Date: Wed, 16 Nov 2011 00:56:18 +0800
Message-ID: <20111115165618.GA4762@localhost>
References: <20111115143155.GA28175@localhost> <s5h4ny5fo76.wl%tiwai@suse.de>
	<20111115144116.GA28996@localhost> <s5h1ut9fnr8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 2307C10390C
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 17:56:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h1ut9fnr8.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
	Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, Jeremy Bush <contractfrombelow@gmail.com>, Christopher White <c.white@pulseforce.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 15, 2011 at 10:45:15PM +0800, Takashi Iwai wrote:
> At Tue, 15 Nov 2011 22:41:16 +0800,
> Wu Fengguang wrote:
> > 
> > On Tue, Nov 15, 2011 at 10:35:41PM +0800, Takashi Iwai wrote:
> > > At Tue, 15 Nov 2011 22:31:55 +0800,
> > > Wu Fengguang wrote:
> > > > 
> > > > memset(eld) clears eld->proc_entry which will leak the struct
> > > > snd_info_entry when unloading the module.
> > > > 
> > > > Fix it by
> > > > - remove memset(eld)
> > > > - set eld->eld_valid to true _after_ all eld fields have been filled
> > > > - don't access the other eld fields when (eld->eld_valid == false)
> > > > 
> > > > Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> > > 
> > > This should be send to stable kernel, too, right?
> > > It appears in 3.1, at least.
> > 
> > Yeah. Good point!  I'll resend it when everything goes fine.
> 
> Ah, no, you don't need to resend.  I'd just need to put Cc to stable
> in the patch commit log.  Then Greg will pick it up automatically
> when the tree is merged to the upstream.

Ah OK, that would be convenient.

> But of course I need to know beforehand whether the patch is intended
> to be sent to stable or not.

Ack. The patch applies cleanly to 3.1.

Thanks,
Fengguang
