From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Tue, 7 Aug 2012 18:04:51 +0100
Message-ID: <20120807170450.GX16861@opensource.wolfsonmicro.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
 <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
 <CAOMZO5AekbYTnrSM+jK_PBeHDx6vKT4DbxbuXhUwA6uD3PAZFQ@mail.gmail.com>
 <20120806220136.GE26698@opensource.wolfsonmicro.com>
 <CAOZdJXWKHdb1q8PBd0Brg_D2CObwUwJ3jWuCPJ+=yO9rcRADiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 12ABB265F9F
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 19:51:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOZdJXWKHdb1q8PBd0Brg_D2CObwUwJ3jWuCPJ+=yO9rcRADiw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Fabio Estevam <festevam@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "gcembed@gmail.com" <gcembed@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 06, 2012 at 11:28:37PM +0000, Tabi Timur-B04825 wrote:
> On Mon, Aug 6, 2012 at 5:01 PM, Mark Brown

> > Is the device using I2S?  I2S doesn't really support stero properly...

> Every use case of I2S I've seen has been stereo only.  What do you
> mean that it doesn't support stereo properly?

Sorry, I meant mono.
