From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCHi v6] ALSA: compress: fix drain calls
 blocking other compress functions
Date: Thu, 7 Nov 2013 19:13:25 +0530
Message-ID: <20131107134325.GA8834@intel.com>
References: <1383809250-5703-1-git-send-email-vinod.koul@intel.com>
 <s5hhabova4i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id D9DCD265578
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 15:38:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hhabova4i.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 07, 2013 at 10:23:09AM +0100, Takashi Iwai wrote:
> At Thu,  7 Nov 2013 12:57:30 +0530,
> Vinod Koul wrote:
> > 
> > The drain and drain_notify callback were blocked by low level driver untill the
> > draining was complete. Due to this being invoked with big fat mutex held, others
> > ops like reading timestamp, calling pause, drop were blocked.
> > 
> > So to fix this we add a new snd_compr_drain_notify() API. This would be required
> > to be invoked by low level driver when drain or partial drain has been completed
> > by the DSP. Thus we make the drain and partial_drain callback as non blocking
> > and driver returns immediately after notifying DSP.
> > The waiting is done while relasing the lock so that other ops can go ahead.
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > CC: stable@vger.kernel.org
> 
> Thanks, I apply this.
> 
> Though...  I found that I already applied your earlier version
> accidentally, and pushed it out a few weeks ago.  If it were just a
> few commits, I'd rebase, but this was way too deep, so rebasing isn't
> good at all.
> 
> In the end, I applied the patch correcting to the final version.
> The downside would be that you'll get two stable commit
> notifications.  So, please beware of that.
> 
> Sorry for confusions!
Np, I will cherry-pick both.

Now i will send you bunch of trvial chnages in compressed core which I wanted to
send once this one was done

--
~Vinod
