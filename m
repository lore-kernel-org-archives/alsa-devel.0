From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: core: add support to card rebind
Date: Mon, 10 Sep 2018 07:30:55 +0100
Message-ID: <8c856984-889c-1604-ccc7-c6d5969f57ca@linaro.org>
References: <20180810093708.13290-1-srinivas.kandagatla@linaro.org>
 <20180906105425.GE5360@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DCC9C2676C6
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 08:30:57 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id 207-v6so19979606wme.5
 for <alsa-devel@alsa-project.org>; Sun, 09 Sep 2018 23:30:57 -0700 (PDT)
In-Reply-To: <20180906105425.GE5360@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, vkoul@kernel.org, rohitkr@codeaurora.org
List-Id: alsa-devel@alsa-project.org



On 06/09/18 11:54, Mark Brown wrote:
> On Fri, Aug 10, 2018 at 10:37:08AM +0100, Srinivas Kandagatla wrote:
>> Current behaviour of ASoC core w.r.t to component removal is that it
>> unregisters dependent sound card totally. There is no support to
>> rebind the card if the component comes back.
>> Typical use case is DSP restart or kernel modules itself.
> 
> This looks OK but needs rebasing against current code.
Thanks I will rebase and send the patch.

thanks,
srini
> 
