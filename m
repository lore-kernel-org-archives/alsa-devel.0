From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [PATCH] asoc: bfin: add i2s driver for blackfin
	bf60x processor
Date: Tue, 5 Jun 2012 11:41:56 +0800
Message-ID: <CAHG8p1CGUAFCQbqN=dsMwQG9W+Ads2vVyo40c7Ay=X+wYaDVRQ@mail.gmail.com>
References: <1338840199-19714-1-git-send-email-scott.jiang.linux@gmail.com>
	<20120604150732.GM7538@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E0CF5244E6
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 05:41:57 +0200 (CEST)
Received: by obbup19 with SMTP id up19so8344591obb.38
	for <alsa-devel@alsa-project.org>; Mon, 04 Jun 2012 20:41:56 -0700 (PDT)
In-Reply-To: <20120604150732.GM7538@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> Overall this is mostly good, the main thing that's jumping out at me is
> that the SPORT API looks like it doesn't really have too many device
> specifics in it so it's a bit surprising that we need completely
> separate I2S and DMA drivers for the two chip generations.
>
These two sports are totally different, bf5xx is full duplex, while
bf6xx is half duplex.
So we combine two sports on bf6xx to one logic sport.
I carefully reviewed these drivers, only dma driver can be merged to
one. Do I need to do this?

>> =A0config SND_BF5XX_SOC_SSM2602
>> =A0 =A0 =A0 tristate "SoC SSM2602 Audio support for BF52x ezkit"
>
> This bit also needs updating...
>
Do you mean config name or prompt?

>
>> +void sport_tx_start(struct sport_device *sport)
>> +{
>
> Is it not possible to make the SPORT API the same between the 5xx and
> the 6xx such that we can share all the drivers between the two chip
> generations with just the SPORT code varying?
>
The dai driver introduce too many chip specific settings in the bf5xx desig=
n.
Also sport behavior has many differences, for example tx and rx
channel is not independent on bf5xx.
I need to use many macros to seperate these differences.
