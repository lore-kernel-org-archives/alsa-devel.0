From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 21/23] ASoC: qdsp6: dt-bindings: Add
 apq8096 machine bindings
Date: Wed, 25 Apr 2018 17:16:15 +0100
Message-ID: <d243f265-a567-e8c5-56b0-ebffe5104a55@linaro.org>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-22-srinivas.kandagatla@linaro.org>
 <20180424162517.msxscjfg36xc22mo@rob-hp-laptop>
 <655a593b-021c-3bf2-35c2-eb77cb0a4b95@linaro.org>
 <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com
 [209.85.128.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 954A526772B
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 18:16:17 +0200 (CEST)
Received: by mail-wr0-f171.google.com with SMTP id q3-v6so43896430wrj.6
 for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2018 09:16:17 -0700 (PDT)
In-Reply-To: <CAL_JsqJXpei5vFUKwrQGaV4q3Twkg=SKF=Cx_my7KaLmOc42NQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Banajit Goswami <bgoswami@codeaurora.org>, rohkumar@qti.qualcomm.com, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Patrick Lai <plai@codeaurora.org>, spatakok@qti.qualcomm.com, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, David Brown <david.brown@linaro.org>, Mark Brown <broonie@kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gross <andy.gross@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org



On 25/04/18 16:04, Rob Herring wrote:
>> I can list the values for the HDMI playback use-case, but the list would
>> grow as we start adding wcd9335 codec support.
> If you don't have the values, then how does one validate a DT is correct?
> 
I can list all the sources and sinks wired on the board in next version.

> Honestly, a single property like this seems insufficient to describe
> audio routing.

This is how all the audio drivers do routing in DT, non DT is also 
pretty much inline with this.


--srini
> 
>>>> +
