From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 06/15] ALSA: pcm: Add DRM helper to set
 constraint for format
Date: Wed, 2 Dec 2015 17:57:21 +0530
Message-ID: <20151202122716.GA22407@subhransu-desktop>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-6-git-send-email-subhransu.s.prusty@intel.com>
 <s5hsi3mpbvc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 37D77261B0E
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 07:56:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hsi3mpbvc.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 01, 2015 at 01:55:03PM +0100, Takashi Iwai wrote:
> On Tue, 01 Dec 2015 18:47:02 +0100,
> Subhransu S. Prusty wrote:
> > 
> > +static int eld_limit_formats(struct snd_pcm_runtime *runtime, void *eld)
> > +{
> > +	u64 formats = SNDRV_PCM_FMTBIT_S16_LE;
> > +	int i;
> > +	const u8 *sad, *eld_buf = eld;
> > +
> > +	sad = drm_eld_sad(eld_buf);
> > +	if (!sad)
> > +		goto format_constraint;
> > +
> > +	for (i = drm_eld_sad_count(eld_buf); i > 0; i--, sad += 3) {
> > +		if (sad_format(sad) == 1) { /* AUDIO_CODING_TYPE_LPCM */
> > +
> > +			/* 20 bit */
> > +			if (sad_sample_bits_lpcm(sad) & 0x2)
> > +				formats |= SNDRV_PCM_FMTBIT_S32_LE;
> > +
> > +			/* 24 bit */
> > +			if (sad_sample_bits_lpcm(sad) & 0x4)
> > +				formats |= SNDRV_PCM_FMTBIT_S24_LE;
> 
> Does it work correctly with HD-audio...?

It works correctly. Do you suspect something wrong?
> 
> 
> Takashi

-- 
