From: Daniel Mack <daniel@caiaq.de>
Subject: Re: ASoC updates for 2.6.34
Date: Mon, 12 Apr 2010 13:31:58 +0200
Message-ID: <20100412113158.GV30801@buzzloop.caiaq.de>
References: <20100405183840.GA2688@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B2904103843
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Apr 2010 13:32:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100405183840.GA2688@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 05, 2010 at 07:38:40PM +0100, Mark Brown wrote:
> The following changes since commit fb48e3c6a4d8888aff61fbf567aadac7d206e973:
>   Graham Gower (1):
>         ASoC: Fix passing platform_data to ac97 bus users and fix a leak
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34
> 
> This is rather large for a stable update due to the inclusion of
> Daniel's backported fix for corruption of DMA data due to use of
> dma_data by both capture and playback streams (which is large but
> straightforward)

Do you think it is safe to push this ASoC-DMA patch to stable@ as well?
I posted backported version already and I believe they're fine.

Thanks,
Daniel
