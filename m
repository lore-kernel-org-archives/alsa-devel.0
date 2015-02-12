From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [Patch V4 00/10] ASoC: QCOM: Add support for
	ipq806x SOC
Date: Wed, 11 Feb 2015 17:05:52 -0800
Message-ID: <20150212010551.GA7330@kwestfie-linux.qualcomm.com>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
 <20150206223229.GG31311@finisterre.sirena.org.uk>
 <20150209064511.GB19870@kwestfie-linux.qualcomm.com>
 <20150211022634.GO2593@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150211022634.GO2593@finisterre.sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, srinivas.kandagatla@linaro.org, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 10, 2015 at 06:26:34PM -0800, Mark Brown wrote:
> On Sun, Feb 08, 2015 at 10:45:11PM -0800, Kenneth Westfield wrote:
> > On Sat, Feb 07, 2015 at 06:32:29AM +0800, Mark Brown wrote:
> 
> > > I'd really like to see some discussion as to how this is all supposed
> to
> > > be handled - how will these direct hardware access drivers and device
> > > trees work when someone does want to use the DSP (without causing
> > > problems), and how will we transition from one to the other.  This is
> > > particularly pressing if there are use cases where people will want to
> > > switch between the two modes at runtime.
> 
> > > What I'm trying to avoid here is being in a situation where we have
> > > existing stable DT bindings which we have to support but which
> conflict
> > > with the way that people want to use the systems.
> 
> > The ipq806x SOC has no LPASS DSP.  On SOCs with a DSP, these drivers
> > would not be enabled.
> 
> OK, but I'm guessing that they're using the same IP that is in other
> SoCs which do have the DSP so even if you don't care for this device it
> might still be an issue.
> 
> > These drivers are prefixed with "lpass" to differentiate themselves from
> > other drivers that would interact with a DSP, rather than the LPASS
> > hardware directly.
> 
> Right, it may be that all that's needed here is some indication as to
> how to describe a system which *does* have a DSP.  Perhaps require that
> the devices be children of the DSP, that way if people want to access
> the hardware directly they can load a dummy driver for the DSP that just
> passes things through if they don't want to use the DSP?

Replacing DSP-based drivers with LPASS-based drivers would be something that
should be handled by Kconfig selections.  For the DT, the DSP-related
nodes and the LPASS-related nodes shouldn't overlap.  There should be a
DSP-based DT binding and a separate LPASS-based DT binding.  Tying one
or the other to the sound node (but not both), should work.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
