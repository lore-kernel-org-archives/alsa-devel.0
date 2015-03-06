From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [Patch V7 02/10] ASoC: qcom: Document LPASS CPU bindings
Date: Fri, 6 Mar 2015 14:03:53 -0800
Message-ID: <20150306220342.GA25363@kwestfie-linux.qualcomm.com>
References: <1425428519-12224-1-git-send-email-kwestfie@codeaurora.org>
 <1425428519-12224-3-git-send-email-kwestfie@codeaurora.org>
 <7E5AFC65-1705-4BDC-B57F-0444E83A8987@codeaurora.org>
 <20150306015131.GA15850@kwestfie-linux.qualcomm.com>
 <D5A5C916-4D40-4C51-8307-9CA90FC68347@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <D5A5C916-4D40-4C51-8307-9CA90FC68347@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 06, 2015 at 10:07:01AM -0600, Kumar Gala wrote:
> On Mar 5, 2015, at 7:51 PM, Kenneth Westfield <kwestfie@codeaurora.org> wrote:
> > On Thu, Mar 05, 2015 at 12:52:30PM -0600, Kumar Gala wrote:
> >> On Mar 3, 2015, at 6:21 PM, Kenneth Westfield <kwestfie@codeaurora.org> wrote:
> >> 
> >>> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
> >>> @@ -0,0 +1,49 @@
> >>> +* Qualcomm Technologies LPASS CPU DAI
> >>> +
> >>> +Required subnodes:
> >>> +
> >>> +- qcom,adsp		: Audio DSP sub-node
> >>> +
> >>> +Optional Audio DSP subnode properties:
> >>> +
> >>> +- status		: "disabled" indicates the adsp is not available.
> >>> +
> >> 
> >> What is the intent of this subnode?
> >> 
> > 
> > From the cover letter:
> > Even though the ipq806x LPASS does not contain an audio DSP, other SOCs
> > do have one.  For those SOCs, the audio DSP typically controls the
> > hardware blocks in the LPASS.  Hence, different CPU DAI driver(s) would
> > need to be used in order to facilitate audio with the DSP.  As such, the
> > LPASS DT contains an adsp subnode, which is disabled for this SOC.  The
> > same subnode should be enabled and populated for other SOCs that do
> > contain an audio DSP.  Not using the audio DSP would require different
> > CPU DAI driver(s), in addition to possible bootloader and/or firmware
> > changes.
> > 
> > This was the result of a request from Mark.  See here:
> > http://thread.gmane.org/gmane.linux.drivers.devicetree/109331/focus=11633
> 
> Two quick comments before I read Mark?s comments.
> 
> 1. Its not normal practice to put something into a DT that does not exist.  Having a node, but marking it disabled implies existence.

Will change the DT definition to optional.

> 2. How would one normally address the audio DSP if it did exist.  I?m just wondering if having a subnode is the proper solution vs maybe a phandle

The audio DSP is, in fact, contained within the audio subsystem.  The
representation of that relationship in the DT, I believe, would be a subnode.
OTOH, if there is a strong sentiment towards using a phandle, that would be
fine with me.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
