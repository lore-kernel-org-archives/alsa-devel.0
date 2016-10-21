From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ASoC: samsung: i2s: Fixup last IRQ unsafe
	spin lock call
Date: Fri, 21 Oct 2016 16:31:29 +0300
Message-ID: <20161021133129.GA3289@kozik-lap>
References: <1477055928-11712-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id B5952267219
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2016 15:32:02 +0200 (CEST)
Received: by mail-lf0-f66.google.com with SMTP id x23so5704185lfi.1
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2016 06:32:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1477055928-11712-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, sbkim73@samsung.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, krzk@kernel.org, broonie@kernel.org, s.nawrocki@samsung.com
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2016 at 02:18:48PM +0100, Charles Keepax wrote:
> Unfortunately, I seem to have missed a case where an IRQ safe spinlock was
> required, in samsung_i2s_dai_remove, when I fixed up the other calls in
> this patch:
> 
> 316fa9e09ad7 ("ASoC: samsung: Use IRQ safe spin lock calls")
> 
> This causes a lockdep warning when unbinding and rebinding the audio card:
> 
> [  104.357664]        CPU0                    CPU1
> [  104.362174]        ----                    ----
> [  104.366692]   lock(&(&pri_dai->spinlock)->rlock);
> [  104.371372]                                local_irq_disable();
> [  104.377283]                                lock(&(&substream->self_group.lock)->rlock);
> [  104.385259]                                lock(&(&pri_dai->spinlock)->rlock);
> [  104.392469]   <Interrupt>
> [  104.395072]     lock(&(&substream->self_group.lock)->rlock);
> [  104.400710]
> [  104.400710]  *** DEADLOCK ***
> 
> Fixes: ce8bcdbb61d9 ("ASoC: samsung: i2s: Protect more registers with a spinlock")
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  sound/soc/samsung/i2s.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
