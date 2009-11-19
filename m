From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Patches for Samsung SoC PCM Controller driver
Date: Thu, 19 Nov 2009 10:25:31 +0000
Message-ID: <20091119102531.GB9763@rakim.wolfsonmicro.main>
References: <1258444397-23576-1-git-send-email-jassi.brar@samsung.com>
	<20091118130643.GC6592@rakim.wolfsonmicro.main>
	<1b68c6790911182025p4390faefvc8594d5e49dabd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AAFC5243C0
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 11:25:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6790911182025p4390faefvc8594d5e49dabd0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, ben-linux@fluff.org, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 19, 2009 at 01:25:47PM +0900, jassi brar wrote:

> well, the patches that were neither 64xx nor PCM specific, we marked
> "S3C AUDIO", those specific were marked "S3C64XX PCM" and the driver
> was marked "S3C PCM" since that is supposed to run all PCM controllers
> of S3C series.

The bit that's missing is that for the subsystem - "ASoC: " for the
ASoC bits.
