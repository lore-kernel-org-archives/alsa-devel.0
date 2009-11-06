From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] S3C64XX I2S: Enable audio-bus clock
Date: Fri, 6 Nov 2009 13:13:31 +0000
Message-ID: <20091106131330.GB10371@rakim.wolfsonmicro.main>
References: <1257498024-29163-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 72C7524660
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2009 14:13:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257498024-29163-1-git-send-email-jassi.brar@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassi.brar@samsung.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 06, 2009 at 06:00:24PM +0900, Jassi Brar wrote:
> Added the missing clk_enable after acquiring the 'audio-bus' clock.

I'll apply this but I beleive the driver ought to be smarter with the
clocks - AFAICT from the documentation the audio bus clock is not
guaranteed to be needed.
