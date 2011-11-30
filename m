From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Wed, 30 Nov 2011 17:30:04 +0530
Message-ID: <1322654404.1516.998.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<s5hbos2g4af.wl%tiwai@suse.de> <1322106354.1516.951.camel@vkoul-udesk3>
	<s5hfwhd29a5.wl%tiwai@suse.de> <1322127157.1516.973.camel@vkoul-udesk3>
	<s5h1usrxujv.wl%tiwai@suse.de> <s5hty5lvowr.wl%tiwai@suse.de>
	<1322652558.1516.989.camel@vkoul-udesk3> <s5hbortrg5m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id EEDCD103B55
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 13:02:34 +0100 (CET)
In-Reply-To: <s5hbortrg5m.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-11-30 at 12:41 +0100, Takashi Iwai wrote:
> > Thanks, I have already changed this as above based on your
> suggestion
> > last week :)
> > 
> > But I have kept two different functions doing same thing for sake of
> > confusion. For playback you need to call this on
> > block/fragment/random_bytes but for capture it needs to be frame
> based.
> 
> That's what I don't understand.  Why the calls must be different?
> It just wakes up.  Nothing else.  It doesn't matter whether it's based
> on which. 
I am not religious about it :D, so don't mind keeping it one as they
essentially do the same thing.

The whole idea was that they wake up for different reasons so call based
on that reason fragment/frame, but I agree that it not really a big
deal, so fixed now

-- 
~Vinod
