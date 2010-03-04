From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/3] ALSA: usb: move ua101 driver
Date: Thu, 4 Mar 2010 16:38:34 +0100
Message-ID: <20100304153834.GK28972@buzzloop.caiaq.de>
References: <1267194883-6854-1-git-send-email-daniel@caiaq.de>
	<1267194883-6854-2-git-send-email-daniel@caiaq.de>
	<4B8BA4A3.1060506@ladisch.de>
	<20100301140129.GI28972@buzzloop.caiaq.de>
	<s5haaus16gu.wl%tiwai@suse.de>
	<20100301141848.GJ28972@buzzloop.caiaq.de>
	<s5h635g15p2.wl%tiwai@suse.de>
	<20100304151627.GY9007@buzzloop.caiaq.de>
	<s5hwrxsnlx4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 7436C103841
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 16:38:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwrxsnlx4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 04, 2010 at 04:31:19PM +0100, Takashi Iwai wrote:
> Daniel Mack wrote:
> > 
> > Any plan on when to do that? I'm not in a hurry really, but I see the
> > usbaudio driver moving on, so merging would need some manual backporting
> > already. I can do that if you want and prepare a new patchset.
> 
> You can prepare patches based on topic/misc branch of sound git tree,
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git topic/misc
> 
> or base on the latest Linus tree, which already contains USB audio v2.0
> patches.
> 
> Then I'll create a separate branch (maybe again topic/usb-v2.0) and
> apply your patches, keep separate from linux-next branch.

Ok, will do. However, I wonder how new patches to the usbaudio driver
will be handled then until the branch is merged?

Thanks,
Daniel
