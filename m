From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH v3 00/10] ARM: mxs: add audio support
Date: Tue, 19 Jul 2011 20:48:49 +0800
Message-ID: <CAA+hA=Td_kQMV==BU=gHYe7jOiLPY_4qMJ4HtA9VOJ5F-Z5fBA@mail.gmail.com>
References: <1310731780-1645-1-git-send-email-b29396@freescale.com>
	<20110718203816.GA9457@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EC4CC2412E
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 14:48:52 +0200 (CEST)
Received: by gxk1 with SMTP id 1so1757858gxk.38
	for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2011 05:48:50 -0700 (PDT)
In-Reply-To: <20110718203816.GA9457@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2011/7/19 Wolfram Sang <w.sang@pengutronix.de>:
> On Fri, Jul 15, 2011 at 08:09:30PM +0800, Dong Aisheng wrote:
>
>> This patch series is to add audio support based on saif for mxs platform.
>> The driver only supports playback currently.
>> For capturing, due to hardware limitation that we have to use two saif
>> instances to implement full duplex (playback & recording), we need to
>> figure out a good design to fit in ASoC as the following work.
>
> So, since the codec problems seem to be resolved now (and they were lucki=
ly
> really just codec-problems):
>
> For the ASoC-patches (1-4):
>
> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
Hi Mark,

For ASoC patches (1-4), do you have any more comments?


> For the mach-mxs-Patches (5-9, 10 is already picked up), assuming patch 6=
 will
> lose the DIGCTRL-handling:
>
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>
>
> I think this series is good for 3.1. Now we just need the mxs-dma bugfix =
on
> top, but that's a different patch...
>
> Regards,
>
> =A0 Wolfram
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Wo=
lfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
