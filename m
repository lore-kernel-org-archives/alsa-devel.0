From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - Fix dai usage in
	pcm_new()	platform handlers
Date: Wed, 22 Jun 2011 19:36:16 +0100
Message-ID: <20110622183616.GB13847@sirena.org.uk>
References: <1308765929-14482-1-git-send-email-zonque@gmail.com>
	<20110622181023.GA18574@opensource.wolfsonmicro.com>
	<BANLkTi=xrqpcTvJJpz0dwVAOQ0ZXict4Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 04C44103A53
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 20:36:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTi=xrqpcTvJJpz0dwVAOQ0ZXict4Pw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 08:21:06PM +0200, Daniel Mack wrote:

> I thought so too, but I'm facing an Ooops on 3.0.0-rc4, while the same
> platform code was running fine on 2.6.39. And while searching for
> potential reasons for this regression, this commit was quite obvious.
> But maybe that's indeed fixing the wrong side. What happens is that
> pxa2xx_pcm_preallocate_dma_buffer() is called for
> SNDRV_PCM_STREAM_CAPTURE, but pcm->streams[1].substream is NULL.

Is this the same issue that Timur was having where he was relying on the
channel count of one of the DAI drivers to tell him if the substream was
allocated instead of looking to see if the substream was allocated which
is the more direct and reliable thing to do?  Looking at the code it
appears that's the case for PXA.
