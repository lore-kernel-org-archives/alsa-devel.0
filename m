From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: don't print
 EPROBE_DEFER as error
Date: Mon, 21 Aug 2017 10:31:35 -0300
Message-ID: <CAOMZO5AWQjVfsbJmZMO974SGQy1yGvZsSSZR-QBZzhDFrdfejQ@mail.gmail.com>
References: <20170818163335.23695-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 33F0C266C78
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 15:31:37 +0200 (CEST)
Received: by mail-oi0-f43.google.com with SMTP id r200so18800700oie.2
 for <alsa-devel@alsa-project.org>; Mon, 21 Aug 2017 06:31:37 -0700 (PDT)
In-Reply-To: <20170818163335.23695-1-l.stach@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wladimir J . van der Laan" <laanwj@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Chris Healy <cphealy@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, patchwork-lst@pengutronix.de, Ilia Mirkin <imirkin@alum.mit.edu>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 18, 2017 at 1:33 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Probe deferral is to be expected during normal operation, so avoid
> printing an error when it is encountered.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
