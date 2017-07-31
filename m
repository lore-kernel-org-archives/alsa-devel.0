From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 4/6] ASoC: codecs: msm8916-wcd-analog:
 set default micbias voltage to 1.8
Date: Mon, 31 Jul 2017 11:27:23 +0100
Message-ID: <60dca225-d9d2-8570-2779-cf55bf605b87@linaro.org>
References: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
 <20170726003512.18965-5-srinivas.kandagatla@linaro.org>
 <20170728134038.y5wnrurmwn4bxxsh@sirena.org.uk>
 <94765031-d840-bcae-11e3-16e1e55a7aa7@linaro.org>
 <20170728140108.ds5x4irfep4ss3lv@sirena.org.uk>
 <0f96d65a-f7d9-0139-e0c4-49069e717f34@linaro.org>
 <20170731100705.lbnodjfgnwxwhqyt@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 42086266A51
 for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2017 12:27:24 +0200 (CEST)
Received: by mail-wm0-f48.google.com with SMTP id m85so71451669wma.0
 for <alsa-devel@alsa-project.org>; Mon, 31 Jul 2017 03:27:24 -0700 (PDT)
In-Reply-To: <20170731100705.lbnodjfgnwxwhqyt@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org



On 31/07/17 11:07, Mark Brown wrote:
> On Fri, Jul 28, 2017 at 03:45:08PM +0100, Srinivas Kandagatla wrote:
>> On 28/07/17 15:01, Mark Brown wrote:
>>> On Fri, Jul 28, 2017 at 02:54:59PM +0100, Srinivas Kandagatla wrote:
> 
>>>> This was set to 2.7v previously for special headsets which have high
>>>> impedance.
> 
>>> So obviously this will break existing users.  That's not OK.
> 
>> This would not break any exiting users, as this part is applicable for only
>> headset detect usecase. I will try to address this in ("PATCH 5/6 ASoC:
>> codecs: msm8916-wcd-analog: add MBHC support") patch.
> 
>> The default voltage for most common usecase should be set to 1.8v anyway.
> 
> Just leave it at the hardware default like we do for everything else in
> ASoC.
Yep, makes sense, the hw default is at 1.8v.

thanks,
srini
> 
