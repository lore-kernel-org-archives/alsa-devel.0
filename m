From: Hui Wang <hui.wang@canonical.com>
Subject: Re: [RFC 0/4] ASoC: Add HDA HDMI codec driver
Date: Thu, 22 Oct 2015 10:22:32 +0800
Message-ID: <56284868.2040008@canonical.com>
References: <1444393729-19745-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FDD4266817
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 04:22:52 +0200 (CEST)
In-Reply-To: <1444393729-19745-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, tiwai@suse.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

On 10/09/2015 08:28 PM, Vinod Koul wrote:
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
>
> Question/Comments welcome...
Hello Vinod,

Is this driver supposed to be working for Bay Trail and Cherry Trail as 
well? Right now we have an OEM product based on the Cherry Trail 
platform, there is no analog audio codec on it, the only audio device on 
the product is the HDMI audio (just like this one 
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/096979.html). 
So could you please share some information about the support status for 
Cherry Trail HDMI audio, e.g. is the driver developed by your team? Is 
it still an out-of-tree driver right now? And do you plan to upstream it 
under the hdac_hdmi.c framework?

Thanks,
Hui.

>
> Subhransu S. Prusty (4):
>    ASoC: hdac-hdmi: Add hdmi driver
>    ASoC: hdac_hdmi: Add PM support for HDMI
>    ASoC: hdac_hdmi: Add hdac hdmi dai ops
>    ASoC: hdac_hdmi: Setup and start infoframe
>
>   sound/soc/codecs/Kconfig     |   4 +
>   sound/soc/codecs/Makefile    |   2 +
>   sound/soc/codecs/hdac_hdmi.c | 694 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 700 insertions(+)
>   create mode 100644 sound/soc/codecs/hdac_hdmi.c
>
