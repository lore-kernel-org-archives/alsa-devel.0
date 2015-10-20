From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: WM8962: mark cache_dirty flag after software
 reset in pm_resume
Date: Tue, 20 Oct 2015 08:55:19 +0100
Message-ID: <20151020075519.GA10520@ck-lbox>
References: <1445309232-24094-1-git-send-email-jiada_wang@mentor.com>
 <1445309232-24094-2-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445309232-24094-2-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 20, 2015 at 11:47:11AM +0900, Jiada Wang wrote:
> By doing software reset of wm8962 in pm_resume, all registers which
> have already been set will be reset to default value without regmap
> interface be involved, thus driver need to mark cache_dirty flag,
> to let regcache can be updated by regcache_sync().
> 
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
