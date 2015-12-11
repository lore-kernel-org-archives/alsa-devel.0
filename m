From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8974: set cache type for regmap
Date: Fri, 11 Dec 2015 12:54:21 +0000
Message-ID: <20151211125421.GQ6058@localhost.localdomain>
References: <1449833229-3301-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449833229-3301-1-git-send-email-mans@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 11, 2015 at 11:27:08AM +0000, Mans Rullgard wrote:
> Attempting to use this codec driver triggers a BUG() in regcache_sync()
> since no cache type is set.  The register map of this device is fairly
> small and has few holes so a flat cache is suitable.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
