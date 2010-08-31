From: Randolph Chung <rchung42@gmail.com>
Subject: Re: Questions about alsa driver for i.Mx27 + wm8974:
 playback time shorter than the original record time
Date: Tue, 31 Aug 2010 09:21:35 -0700
Message-ID: <AANLkTin+mZr75vin9AB0W+zHLXrTtP6UGuAyUSfKpXgE@mail.gmail.com>
References: <1282824338.1106.44.camel@UT43>
	<20100826124137.GA3509@opensource.wolfsonmicro.com>
	<1283271700.10728.8.camel@UT43>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E43E21037F5
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 18:21:36 +0200 (CEST)
Received: by iwn4 with SMTP id 4so5838327iwn.38
	for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2010 09:21:36 -0700 (PDT)
In-Reply-To: <1283271700.10728.8.camel@UT43>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jjinfo@nudt.edu.cn
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, s.hauer@pengutronix.de
List-Id: alsa-devel@alsa-project.org

>
> Yes, it seems to be this reason that causes problem.
> When I playback a stereo wav file(8kHz,16bit, stereo), everything goes
> well.But when trying to playback a mono wav (8kHz,16bit, mono)file,
> problem stills exist.
>
> What's the possible reason for incorrect handling of mono file?
> How to solve it so I can playback mono file correctly?

The imx-ssi driver does not support mono-channel playback. I've also
looked at this a bit but couldn't quite figure it out. Maybe Sasha
(cc'ed) can give some pointers?

randolph
