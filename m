From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Lockups reading from i.MX51 SSI registers
Date: Mon, 20 Aug 2012 10:24:24 -0300
Message-ID: <CAOMZO5D0HnhLAwo0Ee+McciU7ZKOTJeBxoNU+vXFEwi9K7V96w@mail.gmail.com>
References: <20120810195005.GP24328@opensource.wolfsonmicro.com>
 <20120810195638.GF1451@pengutronix.de>
 <20120810201456.GL25520@pengutronix.de>
 <20120810210647.GG1451@pengutronix.de>
 <CAOMZO5DAs=jm-08tWdfdLG_nm=gdi-Q_RReiUKGM_RCgB82dwA@mail.gmail.com>
 <20120817222738.GH18871@opensource.wolfsonmicro.com>
 <CAOMZO5BgeW_z-zf3Auw6RCJg1o5L=DqWdVeF+0Xb_W=6hZJMnQ@mail.gmail.com>
 <20120820131845.GD26991@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C5E9265E16
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 15:24:24 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so9047941obb.38
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2012 06:24:24 -0700 (PDT)
In-Reply-To: <20120820131845.GD26991@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Christoph Fritz <chf.fritz@googlemail.com>, Sascha Hauer <kernel@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 8/20/12, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Aug 17, 2012 at 08:35:49PM -0300, Fabio Estevam wrote:
>
>> Are you running a dt or non-dt kernel? In case of a dt kernel, can you
>> share the dts file?
>
> Non-DT.

Please try this patch:
http://www.spinics.net/lists/arm-kernel/msg190040.html

Regards,

Fabio Estevam
