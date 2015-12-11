From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [RFC PATCH] ASoC: dpcm: Apply symmetry for DPCM
Date: Fri, 11 Dec 2015 19:09:26 +0000
Message-ID: <1449860966.2499.17.camel@loki>
References: <1449804831-58929-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449804831-58929-1-git-send-email-koro.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: broonie@kernel.org, tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, PC Liao <pc.liao@mediatek.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2015-12-11 at 11:33 +0800, Koro Chen wrote:
> From: PC Liao <pc.liao@mediatek.com>
> 
> DPCM does not fully support symmetry attributes. soc_pcm_apply_symmetry()
> is skipped in soc_pcm_open() for DPCM, without being applied elsewhere.
> So HW parameters cannot be correctly limited, and user space can do
> playback/capture at different rates while HW actually does not support it.
> soc_pcm_params_symmetry() will return error and the second stream stops.
> 
> This patch adds soc_pcm_apply_symmetry() for FE, BE, and codec DAIs
> in DPCM path that was skipped in soc_pcm_open().
> 
> Signed-off-by: PC Liao <pc.liao@mediatek.com>
> Signed-off-by: Koro Chen <koro.chen@mediatek.com>

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
