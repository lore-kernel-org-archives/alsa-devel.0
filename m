From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsl: Add .owner to struct
	snd_soc_card
Date: Thu, 22 Dec 2011 14:13:47 +0000
Message-ID: <20111222141346.GY4546@opensource.wolfsonmicro.com>
References: <1324559094.10821.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 20416103E17
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 15:13:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1324559094.10821.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 22, 2011 at 09:04:54PM +0800, Axel Lin wrote:
> Missed .owner of struct snd_soc_card will prevent the module from being
> removed from underneath its users.

Applied, thanks.
