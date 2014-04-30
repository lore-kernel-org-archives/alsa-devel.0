From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: rt5640: correct 5640's device ID
Date: Wed, 30 Apr 2014 10:09:32 -0600
Message-ID: <5361203C.7000503@wwwdotorg.org>
References: <1398838125-13546-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id D5B392650AC
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 18:09:37 +0200 (CEST)
In-Reply-To: <1398838125-13546-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 04/30/2014 12:08 AM, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
> 
> This patch correct rt5640's device ID
> 
> Signed-off-by: Bard Liao <bardliao@realtek.com>
> ---
> We will send another patch to fix the issue about the "Failed to add route"
> error.

Tested-by: Stephen Warren <swarren@nvidia.com>

(On NVIDIA Tegra Beaver/RT5640, Dalmore/RT5640, Jetson TK1/RT5639)

Note that this patch alone (on top of next-20140429) completely
eliminates any of the "failed to add route" errors that I mentioned
earlier, although perhaps there's still a need to investigate why they
happened.
