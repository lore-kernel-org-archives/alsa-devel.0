From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: Re: [PATCH] SoC: max98357a: use flags argument of
 devm_gpiod_get to set direction
Date: Tue, 19 May 2015 11:30:54 -0700
Message-ID: <20150519183053.GA11187@kwestfie-linux.qualcomm.com>
References: <1432018689-7124-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id F2CB9260584
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 20:30:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1432018689-7124-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Mon, May 18, 2015 at 11:58:09PM -0700, Uwe Kleine-K??nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functions)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additional
> parameter that allows to specify direction and initial value for output.
> 
> Use this to simplify the driver. Furthermore this is one caller less
> that stops us making the flags argument to gpiod_get*() mandatory.
> 
> Fixes: af5adf129369 ("ASoC: max98357a: Add MAX98357A codec driver")
> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>

Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
