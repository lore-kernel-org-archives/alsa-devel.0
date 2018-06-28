From: Rob Herring <robh@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 1/2] ASoC: qcom: dt-bindings: Add sdm845
 machine bindings
Date: Thu, 28 Jun 2018 08:04:05 -0600
Message-ID: <CAL_JsqJrpxz=W1zB8cr0CSUF9a+8yYMmNGQzQGEAcs3__D-GpQ@mail.gmail.com>
References: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
 <1529578399-3633-2-git-send-email-rohitkr@codeaurora.org> <20180625191737.GA13246@rob-hp-laptop>
 <5c976a29-b1ff-4fb5-9346-2288dfecd4c3@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5c976a29-b1ff-4fb5-9346-2288dfecd4c3@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Banajit Goswami <bgoswami@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 28, 2018 at 12:20 AM Rohit Kumar <rohitkr@codeaurora.org> wrote:
>
> Thanks Rob for reviewing.
>
>
> On 6/26/2018 12:47 AM, Rob Herring wrote:
> > On Thu, Jun 21, 2018 at 04:23:18PM +0530, Rohit kumar wrote:
> >> Add devicetree bindings documentation file for SDM845 sound card.
> >>
> >> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> >> ---
> >>   .../devicetree/bindings/sound/qcom,sdm845.txt      | 82 ++++++++++++++++++++++
> >>   1 file changed, 82 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> >> new file mode 100644
> >> index 0000000..68feb08
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> >> @@ -0,0 +1,82 @@
> >> +* Qualcomm Technologies Inc. SDM845 ASoC sound card driver
> >> +
> >> +This binding describes the SDM845 sound card, which uses qdsp for audio.
> >> +
> >> +- compatible:
> >> +    Usage: required
> >> +    Value type: <stringlist>
> >> +    Definition: must be "qcom,sdm845-sndcard"
> >> +
> >> +- qcom,audio-routing:
> > Use just 'audio-routing'.
>
> This is same which is being followed in apq8096 machine driver. As all
> qcom machine drivers will
> mostly follow the same design, Vinod asked to pull out the APIs in
> common file - https://patchwork.kernel.org/patch/10479625/ .
> Same is for qcom,model. I will add missing documentation for it in the
> next patchset.

Yes, I know. There are lots of <vendor>,model and others, and I'm
asking folks to drop the vendor prefix.

Rob
