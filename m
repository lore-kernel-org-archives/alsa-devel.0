From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/20] ASoC: S3C64XX: I2S: Make
	BCLK	independent of sample size
Date: Wed, 10 Mar 2010 12:31:18 +0000
Message-ID: <20100310123117.GA6850@sirena.org.uk>
References: <1268207349-9979-1-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-2-git-send-email-jassi.brar@samsung.com>
	<1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B603F10387C
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 13:31:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1268207349-9979-3-git-send-email-jassi.brar@samsung.com>
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

On Wed, Mar 10, 2010 at 04:48:52PM +0900, Jassi Brar wrote:
> For some CPU-CODEC and source clock combination we might need to set
> BCLK to N*Sample_size*LRCLK, where N may be even 3 or 4, not just 2.

> We can simply remove the dependency of BCLK on sample size as there
> is already a callback(S3C_I2SV2_DIV_BCLK) available to set required BCLK.

I've applied this but I'd rather see the code changed so that the BCLK
is set automatically by default and the explict divider configuration
disables that.  This way we get the best of both worlds - most users
won't need to worry about the BCLK configuration but those that need to
configure it can do so.  An awful lot of users don't really understand
audio hardware and find having to learn about which clock rates they
need and so on a bit of a learning curve.
