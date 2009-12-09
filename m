From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/7] ASoC: S3C64XX: Move gpio pin setup in
	platform	init code
Date: Wed, 9 Dec 2009 11:01:14 +0000
Message-ID: <20091209110114.GD19851@opensource.wolfsonmicro.com>
References: <1260332984-11505-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE4C42435D
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 12:01:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1260332984-11505-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassisinghbrar@gmail.com
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 09, 2009 at 01:29:44PM +0900, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jassi.brar@samsung.com>

> Like for other IPs, the configuration of MUX'ed GPIO to I2S mode
> should be done in platform initialization code.

> Signed-off-by: Jassi Brar <jassi.brar@samsung.com>

This is also OK but with the arch/arm dependency.
