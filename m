From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: Fix some static checker
	warnings
Date: Thu, 31 Mar 2016 18:33:41 +0100
Message-ID: <56FD5F75.4010702@linaro.org>
References: <1459423312-6334-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160331173137.GM2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 84CD4266742
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 19:33:43 +0200 (CEST)
Received: by mail-wm0-f53.google.com with SMTP id 20so122913809wmh.1
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 10:33:43 -0700 (PDT)
In-Reply-To: <20160331173137.GM2350@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, plai@codeaurora.org, kwestfie@codeaurora.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org



On 31/03/16 18:31, Mark Brown wrote:
> On Thu, Mar 31, 2016 at 12:21:52PM +0100, Srinivas Kandagatla wrote:
>> This patch fixes below static checker warning plus suggestions from Dan.
>>
>> sound/soc/qcom/lpass-platform.c:555 lpass_platform_pcm_new()
>> error: uninitialized symbol 'ret'.
>
> Please submit one patch per change, each with a clear changelog, as
> covered in SubmittingPatches.  This makes it much easier to review
> things since it's easier to tell if the patch does what it was intended
> to do.

Thanks,
I will do that.

--srini

>
