From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: add sdm845 sound card support
Date: Wed, 20 Jun 2018 10:53:01 +0100
Message-ID: <53db13d7-b4bd-0e06-4110-ce75fd0bdd3c@linaro.org>
References: <1529320591-22434-1-git-send-email-rohitkr@codeaurora.org>
 <20180619050527.GR25852@vkoul-mobl>
 <8562b574-3738-8983-53e7-64366590fad4@codeaurora.org>
 <20180619162230.GF13316@vkoul-mobl>
 <f7891675-4c98-7fc6-b80f-840ada9a1c5b@codeaurora.org>
 <20180620093106.GI13316@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
 [209.85.128.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 25D8126720C
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 11:53:02 +0200 (CEST)
Received: by mail-wr0-f194.google.com with SMTP id o12-v6so2583175wrm.12
 for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2018 02:53:02 -0700 (PDT)
In-Reply-To: <20180620093106.GI13316@vkoul-mobl>
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
To: Vinod <vkoul@kernel.org>, Rohit Kumar <rohitkr@codeaurora.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org



On 20/06/18 10:31, Vinod wrote:
>> Here clock will be enabled twice but disable will be called only once when
>> count = 0.
>>
>> This will make the clock always enabled. So, I think we should keep either
>> mutex lock or atomic variable to synchronize this.
> we are using DPCM here right?

We should probably model this clk as DAPM widget so we do not need to 
handle this in machine code.

--srini
