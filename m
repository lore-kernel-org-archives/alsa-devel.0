From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [RFC 0/4] ASoC: Add HDA HDMI codec driver
Date: Tue, 13 Oct 2015 13:08:27 +0000
Message-ID: <1444741706.2926.16.camel@intel.com>
References: <1444393729-19745-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 989F4261A3B
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 15:08:35 +0200 (CEST)
In-Reply-To: <1444393729-19745-1-git-send-email-vinod.koul@intel.com>
Content-Language: en-US
Content-ID: <AA08FA8B8243CF46933E98256A259513@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Patches Audio <patches.audio@intel.com>, "arnaud.pouliquen@st.com" <arnaud.pouliquen@st.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>, "ykk@rock-chips.com" <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2015-10-09 at 13:28 +0100, Vinod Koul wrote:
> Yes, this patch series attempts to add yet another HDMI driver to
> ASoC. This codec appears as HDA codec over HDA link. Although
> the codec reside in display we have a HDA link from audio block
> to this codec. The communication to codec is over HDA link
> 
> Thanks to i915 component infrastructure, we do not need to worry
> about keeping the codec on, this is done by i915 for us.
> 
> Based on discussion with Mark here at ELCE and other attempts by
> various folks on HDMI, I wanted to show on list the stuff we have
> done and discuss and try to see how we converge various attempts
> 
> The driver here only supports stereo and doesn't do multichannel
> just yet, will add later once we converge here. The support for
> using i915 component notification by David will be added later
> on.

Apart from comments from Russell I didn't get any other comments.

So as a solution for many HDMI approaches in ASoC should we converge on usage of
component framework for talking to display and not have hard dependency to display
code. That sounds okay on X86 but I am not sure if other arch's can do this...

Also as discussed with Russell, we should use drivers/video/hdmi.c for HDMI
infoframes and sound/core/pcm_drm_eld.c for eld parsing. No open coding these :)

Lastly, sink properties should be the properties of the connected device as read from
ELD. That seems okay to me, other please chime in

I will send updated patchset based on above.

Thanks
-- 
~Vinod
