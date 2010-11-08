From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: s3c24xx: Fix compilation problem.
Date: Mon, 08 Nov 2010 13:47:59 +0000
Message-ID: <1289224079.3288.121.camel@odin>
References: <1289218491-17700-1-git-send-email-marek.belisko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7744124392
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 14:48:03 +0100 (CET)
Received: by eyg24 with SMTP id 24so2682914eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 08 Nov 2010 05:48:03 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-11-08 at 13:14 +0100, Marek Belisko wrote:
> When make mini2440_defconfig compilation end with undefined
> references to DMA functions. There was missing selection
> for S3C2410_DMA when compile ASoC audio for S3C24xx CPU.
> Tested on mini2440 board.
> 
> Signed-off-by: Marek Belisko <marek.belisko@gmail.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
