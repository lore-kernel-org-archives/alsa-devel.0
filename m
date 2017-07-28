From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 3/3] ASoC: codecs: msm8916-wcd-digital:
 select DMIC source in CIC filter path
Date: Fri, 28 Jul 2017 16:11:21 +0100
Message-ID: <57f0b0db-5795-5999-0dc3-f9a161ed0340@linaro.org>
References: <20170725234822.18763-1-srinivas.kandagatla@linaro.org>
 <20170725234822.18763-4-srinivas.kandagatla@linaro.org>
 <20170728133206.7ynzrbfvreclltkx@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id CA2AC2676F1
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 17:11:23 +0200 (CEST)
Received: by mail-wm0-f44.google.com with SMTP id t201so128435291wmt.1
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 08:11:23 -0700 (PDT)
In-Reply-To: <20170728133206.7ynzrbfvreclltkx@sirena.org.uk>
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



On 28/07/17 14:32, Mark Brown wrote:
> On Wed, Jul 26, 2017 at 01:48:22AM +0200, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch fixes a missing selection of DMIC in CIC filter source path.
>> Without this patch dmic is not functional.
> 
> What happens when someone needs this filter connected somewhere else -
> shouldn't this be controlled as part of the DAPM routing?
There are only two paths for this, one is DMIC and other is AMIC.

Yes, its possible to add these as dapm routing, i will give it a go in 
next version.

thanks,
srini
