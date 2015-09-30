From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Codec: wm8962: balance
	pm_runtime_enable
Date: Wed, 30 Sep 2015 08:48:25 +0100
Message-ID: <20150930074825.GJ5432@ck-lbox>
References: <1443588853-8778-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 912182606B5
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 10:10:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1443588853-8778-1-git-send-email-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 30, 2015 at 01:54:13PM +0900, Jiada Wang wrote:
> pm_runtime_enable is called in probe to enable runtime PM
> for wm8962 codec, but pm_runtime_disable isn't called in remove
> callback, nor is called in error path if probe fails after runtime
> PM is enabled, this causes unbalanced pm_runtime_enable.
> 
> This patch Adds pm_runtime_disable in remove callback and error path,
> to balance pm_runtime_enable.
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
