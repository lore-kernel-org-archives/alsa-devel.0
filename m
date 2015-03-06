From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [Patch V7 02/10] ASoC: qcom: Document LPASS CPU bindings
Date: Thu, 5 Mar 2015 17:51:31 -0800
Message-ID: <20150306015131.GA15850@kwestfie-linux.qualcomm.com>
References: <1425428519-12224-1-git-send-email-kwestfie@codeaurora.org>
 <1425428519-12224-3-git-send-email-kwestfie@codeaurora.org>
 <7E5AFC65-1705-4BDC-B57F-0444E83A8987@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7E5AFC65-1705-4BDC-B57F-0444E83A8987-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, ALSA Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, MSM Mailing List <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 05, 2015 at 12:52:30PM -0600, Kumar Gala wrote:
> 
> On Mar 3, 2015, at 6:21 PM, Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> 
> > +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.txt
> > @@ -0,0 +1,49 @@
> > +* Qualcomm Technologies LPASS CPU DAI
> > +
> > +Required subnodes:
> > +
> > +- qcom,adsp		: Audio DSP sub-node
> > +
> > +Optional Audio DSP subnode properties:
> > +
> > +- status		: "disabled" indicates the adsp is not available.
> > +
> 
> What is the intent of this subnode?
> 

>From the cover letter:
Even though the ipq806x LPASS does not contain an audio DSP, other SOCs
do have one.  For those SOCs, the audio DSP typically controls the
hardware blocks in the LPASS.  Hence, different CPU DAI driver(s) would
need to be used in order to facilitate audio with the DSP.  As such, the
LPASS DT contains an adsp subnode, which is disabled for this SOC.  The
same subnode should be enabled and populated for other SOCs that do
contain an audio DSP.  Not using the audio DSP would require different
CPU DAI driver(s), in addition to possible bootloader and/or firmware
changes.

This was the result of a request from Mark.  See here:
http://thread.gmane.org/gmane.linux.drivers.devicetree/109331/focus=11633

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
