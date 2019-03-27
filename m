From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH -next] ASoC: fix SND_SOC_LOCHNAGAR_SC kconfig warning
Date: Wed, 27 Mar 2019 17:41:56 +0000
Message-ID: <20190327174156.GJ46536@ediswmail.ad.cirrus.com>
References: <fb9f38e4-c4c9-400e-fb16-fa2714eb8d00@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fb9f38e4-c4c9-400e-fb16-fa2714eb8d00@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, moderated for non-subscribers <alsa-devel@alsa-project.org>, Piotr Stankiewicz <piotrs@opensource.cirrus.co>, Richard Fitzgerald <rf@opensource.cirrus.com>, patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 27, 2019 at 08:43:19AM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kconfig warning for SND_SOC_LOCHNAGAR_SC:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_LOCHNAGAR_SC
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && MFD_LOCHNAGAR [=n]
>   Selected by [m]:
>   - SND_SOC_ALL_CODECS [=m] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=m] && COMPILE_TEST [=y]
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Piotr Stankiewicz <piotrs@opensource.cirrus.com>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Cc: patches@opensource.cirrus.com
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
