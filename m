From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: kirkwood: simplify clock handling
Date: Tue, 24 Sep 2013 19:38:43 +0100
Message-ID: <20130924183843.GI12758@n2100.arm.linux.org.uk>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1380046355-7920-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 5647A261A2C
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2013 20:39:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1380046355-7920-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 24, 2013 at 08:12:35PM +0200, Uwe Kleine-K=F6nig wrote:
> There is no need to not use extclk if it is identical to the main clk.
> The main motivation for this patch is dropping devm_clk_put which is
> used in a wrong way by all other users.

NAK.  There's patches around which switch this driver to always use
the external clock when it's available.  This patch prevents that
from happening because we no longer know whether it is the external
clock or not.

What we could do is just lose the reference to the second clock if
it turns out to be idential to the first - it'll get cleaned up if
the driver is unloaded anyway.  In other words, the call to
devm_clk_put() here can be viewed as merely an optimisation.
