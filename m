From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: SAMSUNG: Fix initial return value
Date: Fri, 3 Dec 2010 16:42:25 +0000
Message-ID: <20101203164225.GY859@rakim.wolfsonmicro.main>
References: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AD329103B5E
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 17:42:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1291368453-30905-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 03, 2010 at 06:27:33PM +0900, Seungwhan Youn wrote:
> This patch fixed intial return value to be a '0' as asuccess on
> set_audio_clock_heirachy(). This avoids unintended error on initialize.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
> ---
>  sound/soc/s3c24xx/smdk_spdif.c |    2 +-

Could you regenerate against current for-2.6.38 please?  The move to the
Samsung directory means this won't apply any more.
