From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH] ASoC: qcom: add sdm845 sound card support
Date: Wed, 20 Jun 2018 15:58:41 +0530
Message-ID: <20180620102841.GJ13316@vkoul-mobl>
References: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
 <20180619050527.GR25852@vkoul-mobl>
 <8562b574-3738-8983-53e7-64366590fad4@codeaurora.org>
 <20180619162230.GF13316@vkoul-mobl>
 <f7891675-4c98-7fc6-b80f-840ada9a1c5b@codeaurora.org>
 <20180620093106.GI13316@vkoul-mobl>
 <53db13d7-b4bd-0e06-4110-ce75fd0bdd3c@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id A222A266E0E
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 12:28:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <53db13d7-b4bd-0e06-4110-ce75fd0bdd3c@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org, Rohit Kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On 20-06-18, 10:53, Srinivas Kandagatla wrote:
> On 20/06/18 10:31, Vinod wrote:
> > > Here clock will be enabled twice but disable will be called only once when
> > > count = 0.
> > > 
> > > This will make the clock always enabled. So, I think we should keep either
> > > mutex lock or atomic variable to synchronize this.
> > we are using DPCM here right?
> 
> We should probably model this clk as DAPM widget so we do not need to handle
> this in machine code.

Sure that would be even better, but my point was that we need not worry
about .startup racing in case of DPCM as it holds a card mutex before it
calls PCM ops.. so it is already serialized..

-- 
~Vinod
