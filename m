From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH] ASoC: qcom: Return an error for invalid
 PCM trigger command
Date: Tue, 14 Apr 2015 16:31:12 -0700
Message-ID: <20150414233112.GA15118@kwestfie-linux.qualcomm.com>
References: <1428927809-4919-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id BD960265456
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2015 01:31:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1428927809-4919-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 13, 2015 at 02:23:29PM +0200, Takashi Iwai wrote:
> Fix a compile warning
>   sound/soc/qcom/lpass-cpu.c: In function ???lpass_cpu_daiops_trigger???:
>   sound/soc/qcom/lpass-cpu.c:224:2: warning: ???ret??? may be used uninitialized in this function [-Wmaybe-uninitialized]
>     return ret;
>       ^
> Although switch () lists the most of existing cases, it's still better
> to cover the rest as an error properly.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/soc/qcom/lpass-cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
