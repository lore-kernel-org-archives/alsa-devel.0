From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 01/23] soc: qcom dt-bindings: Add APR
	bus bindings
Date: Tue, 24 Apr 2018 16:59:07 +0100
Message-ID: <0cb15e17-7169-cfee-c444-d14743797ed3@linaro.org>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-2-srinivas.kandagatla@linaro.org>
 <20180424155226.fo6rgdea4kmqqjdy@rob-hp-laptop>
 <20180424155739.GC22073@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f171.google.com (mail-wr0-f171.google.com
 [209.85.128.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 324AB2675CD
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 17:59:09 +0200 (CEST)
Received: by mail-wr0-f171.google.com with SMTP id u18-v6so23232736wrg.3
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 08:59:09 -0700 (PDT)
In-Reply-To: <20180424155739.GC22073@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 24/04/18 16:57, Mark Brown wrote:
> On Tue, Apr 24, 2018 at 10:52:26AM -0500, Rob Herring wrote:
>> On Wed, Apr 18, 2018 at 04:31:35PM +0100, srinivas.kandagatla@linaro.org wrote:
>>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
>>> This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
>>> bus driver. This bus is used for communicating with DSP which provides
>>> audio and various other services to cpu.
> 
>> This should probably go under bindings/sound/ as it is at least mostly
>> sound related.
> 
> AIUI the same interface is used for other DSP functionality - they're
> upstreaming audio stuff right now but I believe there should be more to
> come.
> 
That's correct, this is not just for audio, APR is used for other dsp 
services too.

--srini
