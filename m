From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 0/4] ASoC: Add HDA HDMI codec driver
Date: Fri, 9 Oct 2015 16:33:37 +0100
Message-ID: <20151009153336.GE3609@vkoul-mobl.iind.intel.com>
References: <1444393729-19745-1-git-send-email-vinod.koul@intel.com>
 <20151009125206.GR32532@n2100.arm.linux.org.uk>
 <20151009151747.GB3609@vkoul-mobl.iind.intel.com>
 <20151009152810.GW32532@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 03F052606E9
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 17:33:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151009152810.GW32532@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, tiwai@suse.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 09, 2015 at 04:28:10PM +0100, Russell King - ARM Linux wrote:
> > I think we should set capabilities based on the sink capabilities. And these
> > should be set after reading the ELD. We want to do that when stream is
> > opened and we query ELD and set the constarinats based on ELD.
> > I have not added that code but this was the idea and was planned to come
> > after this
> 
> Note that there's sound/core/pcm_drm_eld.c which should help you with
> that.  Please help to improve it if it doesn't meet your needs - it's
> a helper precisely to set the constraints based on ELD.
> 
> It tries to find the best fit of sample rate vs channels given a ELD
> array of SADs.

That looks great. Yes I will use this and enhance it wherever required. It
makese sense to keep adding there rather than in driver

> > So we have discussed this with Takashi and the general idea is that we add a
> > SW mechanism as well which will be based on i915 component framework to read
> > ELD reliably from display driver
> > 
> > I think as a general idea all the hdmi audio drivers should rely on component
> > interface generically to read ELD/ get notification (that was added
> > recently). Today on audio we have i915 component interface and IMHO this
> > should be made a generic audio-display component interface and used by all.
> > The callbacks are not really HDA based. But I don't really know on other
> > arch if that is doable or not...
> 
> Do you have a pointer to this work?
sound/hda/hdac_i915.c

-- 
~Vinod
