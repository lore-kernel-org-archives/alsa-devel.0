From: Randolph Chung <rchung42@gmail.com>
Subject: Re: Problem with MX27 ASoC audio
Date: Wed, 18 Aug 2010 15:53:16 +0800
Message-ID: <AANLkTimSMLLcOVzxocQV_nQ57wwxKLUGQUt7wn2wPa2p@mail.gmail.com>
References: <AANLkTikAybX=rP-DfWm5z8eVcC1EaujyEofsSoSJQ1M8@mail.gmail.com>
	<20100812125625.GA27749@pengutronix.de>
	<AANLkTinCWxRNBeXxTHRFBDgmgM6vZTqTKgoCubNYSV5u@mail.gmail.com>
	<20100812150145.GC11362@sirena.org.uk>
	<AANLkTiks+PBmKf6UrxwfLR2jGHO47-p4=o10Y-EE0kJw@mail.gmail.com>
	<4C690693.80706@eukrea.com>
	<AANLkTi=Jst17bqqH6H=jdPYZSGdz5G7yiOJQ=aRLm-3x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D3BA2440B
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 09:53:18 +0200 (CEST)
Received: by gwb17 with SMTP id 17so95920gwb.38
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2010 00:53:17 -0700 (PDT)
In-Reply-To: <AANLkTi=Jst17bqqH6H=jdPYZSGdz5G7yiOJQ=aRLm-3x@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>, alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

> Nonetheless, the system still doesn't behave properly when record and
> playback are happening at the same time. Here's a simple test:

Actually the problem is due to "mismatched" recording and playback
rates. My test was recording at 8kHz and playing back at 48kHz. The
codec driver only supports playback rate = capture rate. When the
playback starts the codec starts clocking at 48kHz which causes the
xruns.

Will see if the codec driver (tlv320aic3x) can be fixed up.

randolph
