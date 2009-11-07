From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/6] ASoC/mpc5200: add to_psc_dma_stream()
 helper
Date: Sat, 7 Nov 2009 12:33:20 +0000
Message-ID: <20091107123320.GE3228@sirena.org.uk>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083423.18908.21177.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D3BFB103817
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 13:33:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091107083423.18908.21177.stgit@angua>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 07, 2009 at 01:34:31AM -0700, Grant Likely wrote:

> +/* Utility for retrieving psc_dma_stream structure from a substream */
> +inline struct psc_dma_stream *
> +to_psc_dma_stream(struct snd_pcm_substream *substream, struct psc_dma *psc_dma)
> +{
> +	if (substream->pstr->stream == SNDRV_PCM_STREAM_CAPTURE)
> +		return &psc_dma->capture;
> +	return &psc_dma->playback;
> +}

Traditionally this'd be an if () else but it makes no difference either
way to the generated code.
