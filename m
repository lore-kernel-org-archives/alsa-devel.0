From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoC: CS4270: export de-emphasis
 filter as ALSA control
Date: Wed, 28 Oct 2009 20:27:13 -0500
Message-ID: <4AE8EF71.3030404@freescale.com>
References: <1256779472-30754-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id CE04824476
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 02:27:41 +0100 (CET)
In-Reply-To: <1256779472-30754-1-git-send-email-daniel@caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> The CS4270 codec features an de-emphasis filter for compensation of
> audio material filtered by an 50/15 uS algorithm. Not sure whether we
> should always enable it for 44100Hz sampling frequency, but it should at
> least be configurable by the user.
>
> Signed-off-by: Daniel Mack<daniel@caiaq.de>
> Cc: Timur Tabi<timur@freescale.com>
> Cc: Mark Brown<broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Timur Tabi <timur@freescale.com>
