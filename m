From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 0/2] ASoC: omap-mcbsp: CPU version check
	changes
Date: Tue, 17 Jan 2012 15:49:24 +0200
Message-ID: <4F157C64.7030708@bitmer.com>
References: <1326806170-7425-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 9109D24604
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 14:48:13 +0100 (CET)
In-Reply-To: <1326806170-7425-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 01/17/2012 03:16 PM, Peter Ujfalusi wrote:
> Hello,
> 
> The following patches changes the way we check CPU versions to
> enable different features (FIFO, and some register differencies).
> In this way we are not going to need to change (and bloat) the
> checks for future versions of OMAP.
> 
While we understand this is only a half step better than currently but
better than adding new cpu_is_omap4+ tests so for both:

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
