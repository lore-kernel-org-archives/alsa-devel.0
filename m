From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v6 02/24] soc: qcom: Add APR bus driver
Date: Thu, 26 Apr 2018 13:05:39 +0100
Message-ID: <35bf7a17-8d76-285f-987b-bf74e2b8e5b8@linaro.org>
References: <20180426094606.4775-1-srinivas.kandagatla@linaro.org>
 <20180426094606.4775-3-srinivas.kandagatla@linaro.org>
 <20180426113911.GA21755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D36326772B
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 14:05:41 +0200 (CEST)
Received: by mail-wm0-f54.google.com with SMTP id t11so5628182wmt.0
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 05:05:41 -0700 (PDT)
In-Reply-To: <20180426113911.GA21755@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 26/04/18 12:39, Mark Brown wrote:
> On Thu, Apr 26, 2018 at 10:45:44AM +0100, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support toi APR bus (Asynchronous Packet Router) driver.
>> ARP driver is made as a bus driver so that the apr devices can added removed
> 
> What is the plan for getting this patch merged?  I think the only review
> I've seen from maintainers thus far has been from Rob on the DT binding.
It was initially reviewed by Bjorn and Rohit. I requested Andy to have 
quick look at this.

I was hoping that APR driver would go via Andy's ARM patches. And the 
rest via your tree.

"depends on QCOM_APR" should prevent drivers from building without apr.

> It's obviously going to be a dependency for everything else.
> 
> Also just saw ARP->APR there.
I will fix that!
> 

--srini
