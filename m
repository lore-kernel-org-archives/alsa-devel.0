From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH v6 01/10] ASoC: phycore-ac97: Add DT support
Date: Wed, 29 May 2013 10:41:58 -0500
Message-ID: <CAOZdJXVL2uP-qW=kydgS-t3C=C+6Cn9D3FWqbMuoK2c-EnckyA@mail.gmail.com>
References: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
 <1369752478-30260-2-git-send-email-mpa@pengutronix.de>
 <20130529135342.GB29528@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 76F80264F00
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 17:42:00 +0200 (CEST)
Received: from mail-vc0-f171.google.com (mail-vc0-f171.google.com
 [209.85.220.171])
 by muin.pair.com (Postfix) with ESMTPSA id 870798FC30
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 11:41:58 -0400 (EDT)
Received: by mail-vc0-f171.google.com with SMTP id m17so6467259vca.2
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 08:41:58 -0700 (PDT)
In-Reply-To: <20130529135342.GB29528@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Sascha Hauer <kernel@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 29, 2013 at 8:53 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>
>
> This function is unavailable until patch #7, right?


May I suggest that Markus run this script:

for i in 1 2 3 4 5 6 7 8 9
do
  git checkout HEAD^
  make
done

It's important that each commit in a patchset be compilable, otherwise
git-bisect will break.
