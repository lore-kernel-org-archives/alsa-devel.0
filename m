From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 2/2] ASoC: qcom: add sdm845 sound card
 support
Date: Thu, 21 Jun 2018 16:09:47 +0100
Message-ID: <46f1a6af-a180-2568-d203-87323379c2fd@linaro.org>
References: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
 <1529578399-3633-3-git-send-email-rohitkr@codeaurora.org>
 <20180621123503.GD27187@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C2ADE2673F2
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 17:09:49 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id r15-v6so5781857wmc.1
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 08:09:49 -0700 (PDT)
In-Reply-To: <20180621123503.GD27187@vkoul-mobl>
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
To: Vinod <vkoul@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org



On 21/06/18 13:35, Vinod wrote:
> And this one is generic DT parsing and seems quite similar to one in apq8096.c
> Can we move these into a lib and use them instead of duplicating.
I totally agree with Vinod, We should probably come up with a library 
functions something like common.c so that we do not duplicate code.
This code is going be exactly same for most of the SoCs using qdsp.

thanks,
srini
