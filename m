From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [RESEND PATCH v2 13/15] dt-bindings: sound: qcom:
 Add devicetree bindings for apq8096
Date: Tue, 2 Jan 2018 16:28:35 -0800
Message-ID: <20180103002835.GW478@tuxbook>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-14-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f53.google.com (mail-pg0-f53.google.com [74.125.83.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 3080C26719C
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 01:28:41 +0100 (CET)
Received: by mail-pg0-f53.google.com with SMTP id q67so58929pga.9
 for <alsa-devel@alsa-project.org>; Tue, 02 Jan 2018 16:28:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171214173402.19074-14-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, sboyd@codeaurora.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, David Brown <david.brown@linaro.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu 14 Dec 09:34 PST 2017, srinivas.kandagatla@linaro.org wrote:

> +++ b/Documentation/devicetree/bindings/sound/qcom,apq8096.txt

Wouldn't it be possible to describe all(?) qdsp based machines in this
one document? I.e. should we name it a little bit more generic?

> @@ -0,0 +1,22 @@
> +* Qualcomm Technologies APQ8096 ASoC sound card driver
> +
> +This binding describes the APQ8096 sound card, which uses qdsp for audio.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: must be "qcom,apq8096-sndcard"
> +
> +- qcom,audio-routing:
> +	Usage: Optional
> +	Value type: <stringlist>
> +	Definition:  A list of the connections between audio components.

Double space before A

> +		  Each entry is a pair of strings, the first being the
> +		  connection's sink, the second being the connection's
> +		  source. Valid names could be power supplies, MicBias
> +		  of codec and the jacks on the board:
> +Example:
> +	sound {
> +		compatible	= "qcom,snd-apq8096";

Indentation

> +		qcom,model = "DB820c";
> +	};

Regards,
Bjorn
