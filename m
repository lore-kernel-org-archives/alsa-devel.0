From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] ASoC: samsung: i2s: Fixup last IRQ unsafe
	spin lock call
Date: Fri, 21 Oct 2016 16:20:54 +0200
Message-ID: <66f6ed61-c775-4504-baa4-2af02037982b@samsung.com>
References: <CGME20161021131846eucas1p27e73aba30a83a17e121c571259cbc7c3@eucas1p2.samsung.com>
 <1477055928-11712-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14])
 by alsa0.perex.cz (Postfix) with ESMTP id AA15C2671D3
 for <alsa-devel@alsa-project.org>; Fri, 21 Oct 2016 16:21:00 +0200 (CEST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0OFE000CJIIXB320@mailout4.w1.samsung.com> for
 alsa-devel@alsa-project.org; Fri, 21 Oct 2016 15:20:57 +0100 (BST)
In-reply-to: <1477055928-11712-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@kernel.org
Cc: sbkim73@samsung.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, krzk@kernel.org
List-Id: alsa-devel@alsa-project.org

On 10/21/2016 03:18 PM, Charles Keepax wrote:
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

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
