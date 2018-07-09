From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card
	support
Date: Mon, 9 Jul 2018 15:02:11 +0100
Message-ID: <887331ff-8892-66a7-20bc-0fce447c792f@linaro.org>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709111437.GB16082@sirena.org.uk>
 <b5a3f0e2-d420-603d-f9a0-f93bdbd2619f@linaro.org>
 <20180709124117.GG16082@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AE6626739D
 for <alsa-devel@alsa-project.org>; Mon,  9 Jul 2018 16:02:13 +0200 (CEST)
Received: by mail-wr1-f65.google.com with SMTP id a3-v6so1889624wrt.2
 for <alsa-devel@alsa-project.org>; Mon, 09 Jul 2018 07:02:13 -0700 (PDT)
In-Reply-To: <20180709124117.GG16082@sirena.org.uk>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org



On 09/07/18 13:41, Mark Brown wrote:
>> AFAIU, The issue with that mechanism or EPROBEDEFER is that it works only
>> for first time.. for the second time(restart usecase) there are no hooks
>> like bind/unbind.
> This is not the case, the card will be unbound at the ASoC level when
> any of the components are removed and then probed again when they
> reappear.
> 
I did try this and It works only for first time! May be am missing 
something!

snd_soc_component_del_unlocked() unregisters the sound card totally. so 
for the second time (After DSP stop) there is no registered sound card 
in place.. Am not sure how this is supposed to work?

The reason I think it works for the first time is because of EPROBEDEFER 
from the machine driver.

Here are the steps I do with DSP:

Step1: Start DSP, can see sound card after all the services are ON.
Step2: Stop DSP, there is no audio card.
Step3: Start DSP, I can see all the components in debugfs but not the 
sound card.

This is what I do w.r.t code:
 From machine driver in snd_soc_register_card() in probe()
 From Audio services driver snd_soc_register_component() in probe() and
snd_soc_unregister_component() in remove()

When DSP is stopped the audio services disappear and 
snd_soc_unregister_component() is invoked.


thanks,
srini
