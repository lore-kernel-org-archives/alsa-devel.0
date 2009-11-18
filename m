From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: DaVinci: remove requirement that
	dma_params	is 1st in structure
Date: Wed, 18 Nov 2009 13:29:49 +0000
Message-ID: <20091118132949.GD698@sirena.org.uk>
References: <1258415554-31069-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AB049243D7
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 14:29:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1258415554-31069-1-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 16, 2009 at 04:52:31PM -0700, Troy Kisky wrote:
> Remove requirement that dma_params is 1st in the structures
> davinci_audio_dev and davinci_mcbsp_dev.
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

I've applied this patch but patches 2-4 don't apply against current
ASoC, even with a three way merge.  Could you please check against
current ASoC at

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33

and resend?  The patches look good and it's good to see that the default
has been changed to avoid channel swapping but they appear to have been
generated against an older tree.
