From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2] ASoC: msm8916-wcd-digital: Select
 REGMAP_MMIO to fix build error
Date: Mon, 14 Jan 2019 13:53:33 +0000
Message-ID: <ca2fdfe6-6097-39ad-5209-2fc67a28303c@linaro.org>
References: <20190111102040.11596-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 77A78266B63
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 14:53:35 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id p6so8915606wmc.1
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 05:53:35 -0800 (PST)
In-Reply-To: <20190111102040.11596-1-axel.lin@ingics.com>
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
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Thanks for the Patch!

On 11/01/2019 10:20, Axel Lin wrote:
> Fix below build error:
> ERROR: "__devm_regmap_init_mmio_clk" [sound/soc/codecs/snd-soc-msm8916-digital.ko] undefined!
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>


Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
