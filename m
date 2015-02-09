From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [Patch V4 00/10] ASoC: QCOM: Add support for ipq806x SOC
Date: Sun, 8 Feb 2015 22:45:11 -0800
Message-ID: <20150209064511.GB19870@kwestfie-linux.qualcomm.com>
References: <1423169626-22166-1-git-send-email-kwestfie@codeaurora.org>
 <20150206223229.GG31311@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150206223229.GG31311@finisterre.sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 07, 2015 at 06:32:29AM +0800, Mark Brown wrote:
> On Thu, Feb 05, 2015 at 12:53:36PM -0800, Kenneth Westfield wrote:
> 
> > This patch series adds support for I2S audio playback on the Qualcomm
> > Technologies ipq806x SOC.
> 
> > The ipq806x SOC has audio-related hardware blocks in its low-power audio
> > subsystem (or LPASS).  One of the relevant blocks in the LPASS is its low-power
> > audio interface (or LPAIF).  This contains an MI2S port, which is what these
> > drivers are configured to use.  The LPAIF also contains a DMA engine that is
> > dedicated to moving audio samples into the transmit FIFO of the MI2S port.  In
> > addition, there is also low-power memory (LPM) within the audio subsystem, which
> > is used for buffering the audio samples.
> 
> This is implementing an AP centric audio system design where the AP
> directly programs all the audio hardware.  Given that pretty much all
> public Qualcomm systems use a DSP centric model where the AP interacts
> only with a DSP which deals with DMA and the physical interfaces it
> seems reasonable to suppose that this system also has a DSP which at
> some future point people are likely to want to use.
> 
> I'd really like to see some discussion as to how this is all supposed to
> be handled - how will these direct hardware access drivers and device
> trees work when someone does want to use the DSP (without causing
> problems), and how will we transition from one to the other.  This is
> particularly pressing if there are use cases where people will want to
> switch between the two modes at runtime.
> 
> What I'm trying to avoid here is being in a situation where we have
> existing stable DT bindings which we have to support but which conflict
> with the way that people want to use the systems.

The ipq806x SOC has no LPASS DSP.  On SOCs with a DSP, these drivers
would not be enabled.

These drivers are prefixed with "lpass" to differentiate themselves from
other drivers that would interact with a DSP, rather than the LPASS
hardware directly.


-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
