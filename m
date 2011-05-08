From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-cache: Allow codec->cache_bypass
 to be used with snd_soc_hw_bulk_write_raw()
Date: Sun, 8 May 2011 14:38:23 +0100
Message-ID: <20110508133823.GB13923@opensource.wolfsonmicro.com>
References: <1304601491-22751-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A383C1037EE
	for <alsa-devel@alsa-project.org>;
	Sun,  8 May 2011 15:38:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304601491-22751-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lrg@ti.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 02:18:11PM +0100, Dimitris Papastamos wrote:
> If we specifically want to write a block of data to the hw bypassing the
> cache, then allow this to happen inside snd_soc_hw_bulk_write_raw().
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Applied, thanks.
