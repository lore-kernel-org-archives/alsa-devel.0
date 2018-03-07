From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH] ASoC: dapm: add support to pinctrl dapm
Date: Wed, 7 Mar 2018 16:20:37 +0000
Message-ID: <a9ebf59b-401b-27b2-f6d8-025438f0e16e@linaro.org>
References: <20180305123213.2045-1-srinivas.kandagatla@linaro.org>
 <20180305155208.GK8588@sirena.org.uk>
 <21635274-1d7b-5ed9-6832-2e12fd844f7a@linaro.org>
 <20180307151329.GJ7290@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A635267255
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 17:20:39 +0100 (CET)
Received: by mail-wm0-f45.google.com with SMTP id w128so5939801wmw.0
 for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2018 08:20:39 -0800 (PST)
In-Reply-To: <20180307151329.GJ7290@sirena.org.uk>
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
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org



On 07/03/18 15:13, Mark Brown wrote:
> On Mon, Mar 05, 2018 at 08:35:48PM +0000, Srinivas Kandagatla wrote:
>> On 05/03/18 15:52, Mark Brown wrote:
> 
>>> This doesn't look right - we're trying to synchronize with the DAPM
>>> async queue from something that should be run inside that very queue.
>>> What is this supposed to be doing?
> 
>> I thought this is supposed to ensure that any pending asynchronous I/O is
>> completed before touching pinctrl framework.
> 
> No, it completes all the pending DAPM operations.  async I/O is part of
> that but it's not the only thing.

Thanks for explaining, I will remove the synchronizing part and send a 
next version,

thanks,
srini
> 
