From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: qdsp6: q6asm-dai: Off by one in
 of_q6asm_parse_dai_data()
Date: Fri, 21 Dec 2018 12:31:13 +0000
Message-ID: <034ee933-9e9c-0370-67d7-e0bb86f4c509@linaro.org>
References: <20181221090442.GA2735@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 72D01267AC5
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 13:31:15 +0100 (CET)
Received: by mail-wr1-f66.google.com with SMTP id p4so5093918wrt.7
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 04:31:15 -0800 (PST)
In-Reply-To: <20181221090442.GA2735@kadam>
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



On 21/12/2018 09:04, Dan Carpenter wrote:
> The q6asm_fe_dais[] array has MAX_SESSIONS (8) elements so the >
> comparison should be >= or we access one element beyond the end of the
> array.
> 
> Fixes: 22930c79ac5c ("ASoC: qdsp6: q6asm-dai: Add support to compress offload")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Thanks for the patch!

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
