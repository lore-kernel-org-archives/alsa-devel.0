From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: s3c24xx: Fix compilation problem.
Date: Mon, 8 Nov 2010 17:20:49 +0000
Message-ID: <20101108172048.GD12581@opensource.wolfsonmicro.com>
References: <1289218491-17700-1-git-send-email-marek.belisko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 988382438A
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 18:20:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1289218491-17700-1-git-send-email-marek.belisko@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Belisko <marek.belisko@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 08, 2010 at 01:14:51PM +0100, Marek Belisko wrote:
> When make mini2440_defconfig compilation end with undefined
> references to DMA functions. There was missing selection
> for S3C2410_DMA when compile ASoC audio for S3C24xx CPU.
> Tested on mini2440 board.
> 
> Signed-off-by: Marek Belisko <marek.belisko@gmail.com>

Applied, thanks.
