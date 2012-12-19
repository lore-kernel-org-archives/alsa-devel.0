From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core: Fix SOC_DOUBLE_RANGE() macros
Date: Wed, 19 Dec 2012 16:25:16 +0000
Message-ID: <50D1EA6C.5080706@ti.com>
References: <1355933916-6301-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F7DC265049
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2012 17:25:19 +0100 (CET)
In-Reply-To: <1355933916-6301-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 19/12/12 16:18, Mark Brown wrote:
> Although we've had macros defining double _RANGE controls for a while now
> they've not actually been backed up properly by the implementation, it's
> treated everything as mono. Fix that by implementing the handling in the
> stereo controls, ensuring that the mono controls don't mistakenly get
> treated as stereo.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
