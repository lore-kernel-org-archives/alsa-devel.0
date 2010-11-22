From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: s3c24xx: test wrong variable
Date: Mon, 22 Nov 2010 14:00:02 +0000
Message-ID: <20101122140002.GB18960@rakim.wolfsonmicro.main>
References: <1290361223-15211-1-git-send-email-segoon@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 92AAC103A15
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 15:00:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1290361223-15211-1-git-send-email-segoon@openwall.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasiliy Kulikov <segoon@openwall.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 21, 2010 at 08:40:21PM +0300, Vasiliy Kulikov wrote:
> After clk_get() mclk is checked three times instead of mout_epll
> and sclk_spdif checks.
> 
> Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>

Applied, thanks.
