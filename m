From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv4] ASoC: Overhaul Samsung drivers
Date: Tue, 23 Nov 2010 14:23:30 +0000
Message-ID: <20101123142330.GI18960@rakim.wolfsonmicro.main>
References: <1288056632-24673-1-git-send-email-jassisinghbrar@gmail.com>
	<1290407690-28917-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA43D103A7C
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 15:23:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1290407690-28917-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 22, 2010 at 03:34:50PM +0900, Jassi Brar wrote:

>  Now that the arch/arm side of the updates has been applied in
> the Kgene's tree, I am submitting upgrade for the Samsung ASoC
> in the following 18 patches.

I've applied all of these, thanks.  There were some merges due to the
bugfix patches that have been going in but they were all trivial so I'm
fairly sure they're OK - please check, though.  The automatic clock
configuration in the I2S driver is particularly nice, it makes the
machine drivers much simpler.
