From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 2/5] ASoC: qcom: Add support to parse
 common audio device nodes
Date: Fri, 6 Jul 2018 18:51:20 +0100
Message-ID: <84b6f1f7-b9c1-fd0c-b684-1e07d35663ba@linaro.org>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-3-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B1802676AD
 for <alsa-devel@alsa-project.org>; Fri,  6 Jul 2018 19:51:21 +0200 (CEST)
Received: by mail-wr1-f66.google.com with SMTP id u7-v6so4955020wrn.12
 for <alsa-devel@alsa-project.org>; Fri, 06 Jul 2018 10:51:21 -0700 (PDT)
In-Reply-To: <1530870195-13576-3-git-send-email-rohitkr@codeaurora.org>
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
To: Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 06/07/18 10:43, Rohit kumar wrote:
> This adds support to parse cpu, platform and codec
> device nodes and add them in dai-links. Also, add
> API to add slave components associated with machine
> driver.
> 
> Signed-off-by: Rohit kumar<rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig  |   3 +
>   sound/soc/qcom/Makefile |   1 +
>   sound/soc/qcom/common.c | 150 ++++++++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/common.h |  14 +++++
>   4 files changed, 168 insertions(+)
>   create mode 100644 sound/soc/qcom/common.c

common.c seems to miss

MODULE_LICENSE("GPL v2");

this will be an issue for snd card module auto-loading!

Also patch 5/5 can go with this.

Other than that it looks good.

Once these 2 fixed you can add my Ack

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini

>   create mode 100644 sound/soc/qcom/common.h
