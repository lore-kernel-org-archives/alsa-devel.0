From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap-pcm: No need to set constraint
	at open time
Date: Tue, 5 Feb 2013 15:15:44 +0200
Message-ID: <20130205151544.00b6ae18e83c115f976abf96@bitmer.com>
References: <1360068219-32156-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id EEADE260315
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2013 14:15:50 +0100 (CET)
In-Reply-To: <1360068219-32156-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 5 Feb 2013 13:43:39 +0100
Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> The same constraint is going to be set in the snd_dmaengine_pcm_open()
> function, so there is no need to set it here as well.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/omap/omap-pcm.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>
Reviewed-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
