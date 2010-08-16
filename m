From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: Problem with MX27 ASoC audio
Date: Mon, 16 Aug 2010 11:36:19 +0200
Message-ID: <4C690693.80706@eukrea.com>
References: <AANLkTikAybX=rP-DfWm5z8eVcC1EaujyEofsSoSJQ1M8@mail.gmail.com>	<20100812125625.GA27749@pengutronix.de>	<AANLkTinCWxRNBeXxTHRFBDgmgM6vZTqTKgoCubNYSV5u@mail.gmail.com>	<20100812150145.GC11362@sirena.org.uk>
	<AANLkTiks+PBmKf6UrxwfLR2jGHO47-p4=o10Y-EE0kJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 68.mail-out.ovh.net (68.mail-out.ovh.net [91.121.185.69])
	by alsa0.perex.cz (Postfix) with SMTP id 91292103816
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Aug 2010 11:36:23 +0200 (CEST)
In-Reply-To: <AANLkTiks+PBmKf6UrxwfLR2jGHO47-p4=o10Y-EE0kJw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randolph Chung <rchung42@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Randolph,

Le 16/08/2010 11:27, Randolph Chung a =E9crit :
> Any ideas? I do not see any in-tree drivers that use MX27+I2S codecs,
> only MX27+AC97, which goes through a different path. Just wondering if
> the I2S path works for others in the capture case?
>
it's working (at least was working a few weeks ago) here on an i.MX27 =

using a TLV320AIC23B which is the I2S master, check : =

sound/soc/imx/eukrea-tlv320.c

Eric
