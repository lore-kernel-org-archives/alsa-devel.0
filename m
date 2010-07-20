From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add configurable delay
 after digimic enable
Date: Tue, 20 Jul 2010 13:55:13 +0100
Message-ID: <20100720125513.GB30148@rakim.wolfsonmicro.main>
References: <1279630149-3337-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9203924589
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 14:55:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279630149-3337-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 20, 2010 at 03:49:09PM +0300, Peter Ujfalusi wrote:
> When digital microphones are connected to twl, delay is
> needed after enabling the digimic interface of the codec.
> Add new parameter for the setup data, which can be used
> to pass the apropriate delay in ms after the digimic
> interface has been enabled.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
