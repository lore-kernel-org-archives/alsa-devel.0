From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 2/2] ASoC: qcom: add apq8016 sound card
	support
Date: Tue, 09 Jun 2015 19:22:08 +0100
Message-ID: <55772ED0.2060405@linaro.org>
References: <1433854702-23654-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1433854776-23852-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150609170738.GI14071@sirena.org.uk> <557727BF.8040807@linaro.org>
 <20150609180435.GV14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id CC6B0261507
 for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2015 20:27:19 +0200 (CEST)
Received: by wibut5 with SMTP id ut5so26000193wib.1
 for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2015 11:27:19 -0700 (PDT)
In-Reply-To: <20150609180435.GV14071@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org
List-Id: alsa-devel@alsa-project.org



On 09/06/15 19:04, Mark Brown wrote:
> On Tue, Jun 09, 2015 at 06:51:59PM +0100, Srinivas Kandagatla wrote:
>> On 09/06/15 18:07, Mark Brown wrote:
>
>>> Why not just do these one time at probe, we don't undo them when we shut
>>> the DAI down?
>
>> If I do that Am afraid that the driver would loose the flexibility of
>> selecting different MI2S from DT level. Hardcoding which MI2S can got to
>> external or internal codec is something that I wanted to avoid from the
>> start.
>
> I don't understand why we'd loose anything - we get init() callbacks on
> the DAIs when they're instantiated?
>
Yes, got it. At dai_link init() level we can do it without losing any 
flexibility.

My bad, I thought you initially suggested me to add this to platform 
probe() level.

>> I will add the shutdown code to reset the configuration.
>
> OK.
>
