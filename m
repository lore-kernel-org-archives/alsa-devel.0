From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ASoC: dpcm: Make BE prepare possible in
	suspend state
Date: Wed, 28 Oct 2015 08:34:25 +0000
Message-ID: <1446021265.2443.3.camel@loki>
References: <1445998534-38246-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 38E6D2606E8
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2015 09:34:30 +0100 (CET)
In-Reply-To: <1445998534-38246-1-git-send-email-koro.chen@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, tiwai@suse.de, s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, broonie@kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-10-28 at 10:15 +0800, Koro Chen wrote:
> During suspend/resume, there is a flow that if a driver does not support
> SNDRV_PCM_INFO_RESUME, it will fail at snd_pcm_resume(), and user space
> can then issue SNDRV_PCM_IOCTL_PREPARE to let audio continue to play.
> 
> However, in dpcm_be_dai_prepare() it only allows BEs to be prepared
> in state SND_SOC_DPCM_STATE_HW_PARAMS or SND_SOC_DPCM_STATE_STOP.
> The BE state will then stay in SND_SOC_DPCM_STATE_SUSPEND, consequently
> dpcm_be_dai_shutdown() is skipped in the end of playback and
> be_substream->runtime is not cleared while this runtime is actually freed
> by snd_pcm_detach_substream(). If another suspend comes, a NULL pointer
> dereference will happen in snd_pcm_suspend() when accessing
> BE substream's runtime.
> 
> Signed-off-by: Koro Chen <koro.chen@mediatek.com>

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
