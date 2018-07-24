From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 04/12] ASoC: dt-bindings: add dt bindings
 for wcd9335 audio codec
Date: Tue, 24 Jul 2018 12:48:57 +0100
Message-ID: <1f700d0e-57f0-9d9d-cb32-a12c4c4b7243@linaro.org>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-5-srinivas.kandagatla@linaro.org>
 <20180724110602.GA2414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id B357426733D
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 13:48:59 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so2255056wmc.0
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 04:48:59 -0700 (PDT)
In-Reply-To: <20180724110602.GA2414@sirena.org.uk>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, robh+dt@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org



On 24/07/18 12:06, Mark Brown wrote:
> On Mon, Jul 23, 2018 at 04:54:02PM +0100, Srinivas Kandagatla wrote:
>> This patch adds bindings for wcd9335 audio codec which can support both SLIMbus
>> and I2S/I2C interface.
> 
> ...
> 
>> +Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
>> +It supports both I2S/I2C and SLIMbus audio interfaces.
> 
> This is a standalone audio CODEC but it also has a MFD binding?  I'd
> have just expected a single binding for a single device.
> 
Thanks for the suggestion!

You are right, I should probably remove the mfd bindings totally.
and move them to codec bindings. And register codec and other blocks 
like soundwire controller as mfd cells. like wm8994.

--srini
