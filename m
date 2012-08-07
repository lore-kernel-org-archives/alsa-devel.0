From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Tue, 7 Aug 2012 18:05:23 +0100
Message-ID: <20120807170523.GY16861@opensource.wolfsonmicro.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
 <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
 <CAOMZO5AekbYTnrSM+jK_PBeHDx6vKT4DbxbuXhUwA6uD3PAZFQ@mail.gmail.com>
 <CAOMZO5BwZnhR=Fa3VaCEFTQGso9US3jSYXi5EzQjG35MP23k4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 46D1B265FB2
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 19:51:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5BwZnhR=Fa3VaCEFTQGso9US3jSYXi5EzQjG35MP23k4g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Tabi Timur-B04825 <B04825@freescale.com>, kernel@pengutronix.de, =?iso-8859-1?Q?Ga=EBtan?= Carlier <gcembed@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 07, 2012 at 12:22:41AM -0300, Fabio Estevam wrote:

> So is my original patch correct? Maybe I should change the wording of
> the commit log?

Yeah, just say something about removing mono support since it doesn't
work.
