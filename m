From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 4/5] ARM: dts: rockchip: Add shared file
	for audio related nodes for veyron boards
Date: Tue, 17 May 2016 15:30:28 +0200
Message-ID: <14374712.skXTGdLur6@phil>
References: <1462790795-25345-1-git-send-email-enric.balletbo@collabora.com>
 <CAFqH_51XmijOmfY2K1Yxcq1=x8T6m5nC0C5_2Qz-7FVR02HrMA@mail.gmail.com>
 <4872705.Eu1B24CGhn@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gloria.sntech.de (gloria.sntech.de [95.129.55.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 1778C26148F
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 15:30:36 +0200 (CEST)
In-Reply-To: <4872705.Eu1B24CGhn@phil>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Enric Balletbo Serra <eballetbo@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Am Dienstag, 17. Mai 2016, 11:36:23 schrieb Heiko Stuebner:
> Am Dienstag, 17. Mai 2016, 10:14:55 schrieb Enric Balletbo Serra:
> > Hi Heiko,
> > 
> > 2016-05-16 0:06 GMT+02:00 Heiko Stuebner <heiko@sntech.de>:
> > > Am Montag, 9. Mai 2016, 12:46:34 schrieb Enric Balletbo i Serra:
> > >> Set i2s block to "okay", add sound node for max98090 with gpios for
> > >> HP and Mic detect and pinctrl, and add a max98090 device and ts3a227e
> > >> to
> > >> the correct i2c bus.
> > >> 
> > >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > > 
> > > I only got a "applied" reply from Marks scripts for patch 3/5, so only
> > > today saw that all 3 actually got applied.
> > > 
> > > Anyway, I've applied this to my dts32-branch for 4.8 now [0] with some
> > > modifications regarding
> > > - the commit subject+message
> > > - ordering
> > > - io_domains access (via the phandle now)
> > > - regulator suspend property
> > > so maybe take a look and holler if you see a mistake.
> > 
> > The changes looks good to me, thanks.
> > 
> > > I was able to get audio over the headphones (so definitly an
> > > improvement), but so far not over the built-in speakers. Did you need
> > > to do something special in the configuration for this?
> > 
> > I added an UCM file [1] to my setup to test this and tested as follows
> > (you can also use alsamixer but as you know this is not safe though ;)
> > )
> > 
> > # enable the speaker at bootup:
> > alsaucm -c ROCKCHIP-I2S set _verb HiFi
> > # set speaker to half loudness:
> > amixer set Speaker 50%
> > # play something
> > aplay music.wav
> > # enable headphones (disable speaker):
> > alsaucm -c ROCKCHIP-I2S set _verb HiFi set _enadev Headphone
> > # set headphones to half loudness:
> > amixer set Headphone 50%
> > # play something
> > aplay music.wav
> > # disable headphones (enable speaker):
> > alsaucm -c ROCKCHIP-I2S set _verb HiFi set _disdev Headphone
> 
> woohoo ... sound on the speakers :-D

one thing I'm not sure about is the naming though.

The ucm profiles most likely are board-specific and looking at the other alsa 
ucm subdirs, they really are named after their boards (like daisy-i2s for 
some exynos chromebooks). Hogging ROCKCHIP-I2S for veyron chromebooks seems 
wrong especially wrt. other Rockchip devices. Shouldn't this be named 
VEYRON-I2S or so instead - same on the kernel side probably.


Heiko
