From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoC: support more sample rates on
 raumfeld devices
Date: Wed, 13 Jan 2010 13:02:09 +0000
Message-ID: <20100113130208.GD27473@rakim.wolfsonmicro.main>
References: <1263378338-21791-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BE83C103853
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 14:02:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1263378338-21791-1-git-send-email-daniel@caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 13, 2010 at 11:25:38AM +0100, Daniel Mack wrote:
> Add support for sample rates other than 44100Khz on raumfeld audio
> devices. Force the codec's supported sample rates as the table of
> supported rates which is calculated at run-time does not suffice: if we
> call snd_soc_dai_set_sysclk() at stream startup, half of the possible
> rates are missing.

I'm not massively enthusiastic about this - I'd much rather be able to
give the CODEC a hook to let it know what MCLK rates it can have and a
callback to update them.  It's a perfect case for the clock API but of
course we can't use that off-SoC :/
