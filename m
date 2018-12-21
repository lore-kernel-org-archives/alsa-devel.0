From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: qdsp6: q6asm-dai: Fix a NULL vs
	IS_ERR() bug
Date: Fri, 21 Dec 2018 12:29:45 +0000
Message-ID: <a9ebd36d-c13a-487d-79cc-72bd14134bab@linaro.org>
References: <20181221090516.GB2735@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 574A9267AC2
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 13:29:47 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id n190so5167406wmd.0
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 04:29:47 -0800 (PST)
In-Reply-To: <20181221090516.GB2735@kadam>
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



On 21/12/2018 09:05, Dan Carpenter wrote:
> The q6asm_audio_client_alloc() doesn't return NULL, it returns error
> pointers.
> 
> Fixes: 22930c79ac5c ("ASoC: qdsp6: q6asm-dai: Add support to compress offload")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks for the patch!

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
