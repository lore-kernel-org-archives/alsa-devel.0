From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH v5] drm/i915: pass ELD to HDMI/DP audio
	driver
Date: Mon, 5 Sep 2011 09:19:51 +0800
Message-ID: <20110905011951.GC24561@localhost>
References: <20110902081428.GA19621@localhost>
	<20110903211510.GA11600@localhost> <m3r53wa82c.fsf@jhcloos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 197861037EE
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 03:19:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3r53wa82c.fsf@jhcloos.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Cloos <cloos@jhcloos.com>
Cc: Keith Packard <keithp@keithp.com>, "Wang,
	Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>, Jeremy Bush <contractfrombelow@gmail.com>, Christopher White <c.white@pulseforce.com>, "Fu,
	Michael" <michael.fu@intel.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 04, 2011 at 06:57:23PM +0800, James Cloos wrote:
> >>>>> "WF" == Wu Fengguang <fengguang.wu@intel.com> writes:
> 
> WF> ... If only the stereo playback capability is reported, the user
> WF> won't be able to start 8-channel playback; if the 8-channel ELD is
> WF> reported, then user space applications may send 8-channel samples
> WF> down, however the user may actually be listening to the 2-channel
> WF> monitor and not connecting speakers to the 8-channel monitor.
> 
> WF>  Overall, it's more safe to report maximum profiles to the user
> WF> space, so that the user can at least be able to do 8-channel
> WF> playback if he want to.
> 
> Be aware that many TVs will either refuse the display anything or pop-up
> an OSD warning whenever they receive hdmi audio which they cannot handle.

OK, good to know that.

> Sending 8-channel in your example may render the stereo-only monitor useless.

Yes.

> That said, one step at a time is reasonable.  But eventually you will 
> require configurability and/or per-monitor audio control even when the
> video is cloned.

Fair enough.

Thanks,
Fengguang
