From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 33/34] ARM: imx: remove header file
	mach/irqs.h
Date: Tue, 18 Sep 2012 16:13:02 +0800
Message-ID: <20120918081300.GC6377@S2101-09.ap.freescale.net>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-34-git-send-email-shawn.guo@linaro.org>
 <201209171132.52380.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 184C9261716
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 10:12:48 +0200 (CEST)
Received: by pbbro8 with SMTP id ro8so12587164pbb.38
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 01:12:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201209171132.52380.arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 17, 2012 at 11:32:52AM +0000, Arnd Bergmann wrote:
> We already have some fiq specific stuff in the
> include/linux/platform_data/asoc-imx-ssi.h header file,
> so I think it's best to put this declaration there, too.
> 
That's indeed a better place.  Thanks for the idea, Arnd.

Shawn
