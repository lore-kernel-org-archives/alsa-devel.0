From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] ARM DaVinci: Add ALSA SoC driver for
	the Lyrtech SFFSDR board
Date: Wed, 19 Nov 2008 11:11:17 +0000
Message-ID: <20081119111116.GB13250@sirena.org.uk>
References: <1227076652-23370-1-git-send-email-hugo@hugovil.com>
	<1227076652-23370-3-git-send-email-hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 239991037F1
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 12:11:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227076652-23370-3-git-send-email-hugo@hugovil.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 19, 2008 at 01:37:32AM -0500, Hugo Villeneuve wrote:
> The PCM3008 is used on the Lyrtech SFFSDR board, in conjunction with an
> FPGA that generates the bit clock and the master clock

> Signed-off-by: Hugo Villeneuve <hugo@hugovil.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but I'll...

> +	printk(KERN_INFO "sffsdr_hw_params: rate = %d Hz\n", fs);

...change this to a pr_debug() before pushing it since displaying this
every time playback or record starts is excessive for normal use.
