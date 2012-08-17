From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Lockups reading from i.MX51 SSI registers
Date: Fri, 17 Aug 2012 16:08:47 -0300
Message-ID: <CAOMZO5DAs=jm-08tWdfdLG_nm=gdi-Q_RReiUKGM_RCgB82dwA@mail.gmail.com>
References: <20120810195005.GP24328@opensource.wolfsonmicro.com>
 <20120810195638.GF1451@pengutronix.de>
 <20120810201456.GL25520@pengutronix.de>
 <20120810210647.GG1451@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f179.google.com (mail-gh0-f179.google.com
 [209.85.160.179])
 by alsa0.perex.cz (Postfix) with ESMTP id DBC6526522A
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2012 20:39:02 +0200 (CEST)
Received: by ghbg2 with SMTP id g2so4351799ghb.38
 for <alsa-devel@alsa-project.org>; Fri, 17 Aug 2012 12:08:48 -0700 (PDT)
In-Reply-To: <20120810210647.GG1451@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Christoph Fritz <chf.fritz@googlemail.com>, Sascha Hauer <kernel@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 10, 2012 at 6:06 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> One clock is for the bus which must be turned on. The other is for the
> bitclock which we currently can ignore since we only support clock slave
> mode.
> On an i.MX5 ssi[123]_ipg_gate must be turned on by the ssi driver. From
> a quick look to the clock code it looks correct.

I tested audio playback on a mx51evk board last week using linux-next
and it worked fine (it has a sgtl5000).

I don't have any hardware with ac97 to try it.

Also, for the playback to work you need to install the SDMA firmware.

Regards,

Fabio Estevam
