From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [alsa-devel] [RFC PATCH 14/14] ASoC: qcom: document apq8016
 machine driver bindings
Date: Tue, 5 May 2015 22:41:13 -0700
Message-ID: <20150506054113.GB5639@kwestfie-linux.qualcomm.com>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1430414306-11469-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150503000307.GG27804@kwestfie-linux.qualcomm.com>
 <55486E6D.9010402@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55486E6D.9010402-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 05, 2015 at 12:17:01AM -0700, Srinivas Kandagatla wrote:
> On 03/05/15 01:03, Kenneth Westfield wrote:
> >On Thu, Apr 30, 2015 at 06:18:26PM +0100, Srinivas Kandagatla wrote:
> >>This patch adds bindings for apq8016 machine driver.
> >>On APQ8016 4 MI2S can be configured to different sinks like internal
> >>codec/external codec, this connection is controlled via 2 iomux
> >>registers.
> >>
> >>+sound: sound {
> >>+	compatible = "qcom,apq8016-sndcard";
> >>+	reg = <0x07702000 0x4>, <0x07702004 0x4>;
> >>+	reg-names = "mic-iomux", "spkr-iomux";
> >>+	qcom,model = "DB410c";
> >>+
> >>+	/* I2S - Internal codec */
> >>+	internal-dai-link@0 {
> >>+		cpu { /* PRIMARY */
> >>+			sound-dai = <&lpass MI2S_PRIMARY>;
> >>+		};
> >>+		codec {
> >>+			sound-dai = <&wcd_codec 0>;
> >>+		};
> >>+	};
> >>+
> >>+	/* External Primary or External Secondary -ADV7533 HDMI */
> >>+	external-dai-link@0 {
> >>+		external;
> >>+		cpu { /* QUAT */
> >>+			sound-dai = <&lpass MI2S_QUATERNARY>;
> >>+		};
> >>+		codec {
> >>+			sound-dai = <&adv_bridge 0>;
> >>+		};
> >>+	};
> >>+};
> >
> >OK, although I will need to double-check this with the spec, it seems
> >(from the patches) that there are 4 I2S ports, 2 of which are being
> >used.  Usually, multi-channel audio is sent to the primary dai (which
> >is MI2S), which then gets sent to the other ports by HW.  If that holds
> >true for this SOC, then the external cpu dai should be labelled I2S,
> >not MI2S.  If not, then both should be labelled as I2S (and the DAI
> >channel constraints should be reduced to 1-2).
> >
> I have got very limited access to documentation, which obviously
> does not have any info related to channel capabilities. I was
> thinking that all the playback ports support multi-channel. I might
> be wrong though.

After checking the specs, the four playback DAIs are, in fact,
multi-channel.  Therefore, MI2S_ is the correct prefix for them.

> 
> >Looking at patch 12, the internal DAI is labelled Headset and the
> >external DAI is labelled HDMI.
> This naming is very specific to the SBC board.
> 
>   I will check the spec to see if the QUAT
> >I2S port can handle multi-channel.
> External HDMI bridge on the other side only supports 2-channels, but
> if you can re-check on the channel capabilities would be good.

Ah, ok.  Then no need to worry about multi-channel playback.  Just need
to ensure the codec drivers constrain the channels to mono/stereo.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
