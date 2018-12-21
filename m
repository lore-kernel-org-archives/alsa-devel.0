From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/4] ASoC: qdsp6: q6asm-dai: Fix a small
 memory leak
Date: Fri, 21 Dec 2018 12:29:31 +0000
Message-ID: <2630a14e-ba15-0ed2-11f7-d217569a31c0@linaro.org>
References: <20181221090610.GC2735@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AE50A267A78
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 13:29:33 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id m1so5158860wml.2
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 04:29:33 -0800 (PST)
In-Reply-To: <20181221090610.GC2735@kadam>
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
To: Dan Carpenter <dan.carpenter@oracle.com>, Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 21/12/2018 09:06, Dan Carpenter wrote:
> We can't return directly if snd_dma_alloc_pages() fails; we first need
> to free prtd->audio_client and prtd.
> 
> Fixes: 22930c79ac5c ("ASoC: qdsp6: q6asm-dai: Add support to compress offload")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---


Thanks for the patch! I was due to send something similar!

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
