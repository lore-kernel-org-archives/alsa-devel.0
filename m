From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: Intel G45 8-Channel LPCM over HDMI
Date: Tue, 4 Nov 2008 17:51:05 +0800
Message-ID: <1225792266.708657.30943@de>
References: <8D978A35-5424-4BB5-980A-8F74EE529876@lambda-audiosystems.de>
	<s5hfxm9wap9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id C91B0103824
	for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2008 10:51:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfxm9wap9.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Alexander Werner <alexander.werner@lambda-audiosystems.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 03, 2008 at 08:05:54AM +0100, Takashi Iwai wrote:
> At Sun, 2 Nov 2008 15:16:49 +0100,
> Alexander Werner wrote:
> > 
> > Hi,
> > 
> > I'm planning to build a linux-based, small sized PC for hearing aid  
> > acousticians.
> > It would be highly unfavorable, if the connection between Receiver and  
> > PC was
> > analog, because of the lower quality and the high number of cables.
> > I searched for a appropriate mainboard, and found the DG45FC, which  
> > fits my needs
> > perfectly, apart from the missing audio over HDMI support.
> > Is there any plan to support multichannel LPCM output over HDMI on the  
> > Intel G45
> > platform?
> 
> Yes.  Now waiting for the updated patch from Intel guys, hopefully it'll
> be available soon later.

It's ready now!

We did a lot of code refactor, testing and bug fixes in the last ten
days, and now it's ready for release :-)

Note that X.org intel video patches are also necessary for HDMI sound output.

However our 3 HDMI monitors have only 2-channel audio support, so
8-channel LPCM audio may not work for now.

Thank you,
Fengguang
