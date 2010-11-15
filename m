From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: RX1950: Fix hw_params function
Date: Mon, 15 Nov 2010 12:27:36 +0000
Message-ID: <20101115122736.GA12986@rakim.wolfsonmicro.main>
References: <1289652821-5435-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 22027103831
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 13:27:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1289652821-5435-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 13, 2010 at 02:53:41PM +0200, Vasily Khoruzhick wrote:
> Unfortunatelly, I misunderstood datasheet, and on s3c244x-iis
> when MPLLin source for master clock is selected, prescaler has
> no effect. Remove dividor calculation for 44100 rate; remove 88200
> rate at all, rx1950 can't do it.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Applied, thanks.
