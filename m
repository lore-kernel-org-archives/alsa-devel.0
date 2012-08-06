From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Mon, 6 Aug 2012 23:28:37 +0000
Message-ID: <CAOZdJXWKHdb1q8PBd0Brg_D2CObwUwJ3jWuCPJ+=yO9rcRADiw@mail.gmail.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
 <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
 <CAOMZO5AekbYTnrSM+jK_PBeHDx6vKT4DbxbuXhUwA6uD3PAZFQ@mail.gmail.com>
 <20120806220136.GE26698@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 354AD265E0E
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 00:58:56 +0200 (CEST)
In-Reply-To: <20120806220136.GE26698@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <3787B85E6F899443AF2C059842290C0D@mgd.freescale.com>
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
Cc: Estevam Fabio-R49496 <r49496@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Fabio Estevam <festevam@gmail.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "gcembed@gmail.com" <gcembed@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 6, 2012 at 5:01 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>
> Is the device using I2S?  I2S doesn't really support stero properly...

Every use case of I2S I've seen has been stereo only.  What do you
mean that it doesn't support stereo properly?

-- 
Timur Tabi
Linux kernel developer at Freescale
