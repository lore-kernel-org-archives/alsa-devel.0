From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Codec driver gets probed prior to the machine
	driver
Date: Sun, 09 Jun 2013 17:12:57 +0200
Message-ID: <51B49B79.2040007@metafoo.de>
References: <CAOMZO5BzaAmt0BNXvSw+a18QorOBmEjGwaA5PoQ_D6mVb6QiUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B31D2602F2
 for <alsa-devel@alsa-project.org>; Sun,  9 Jun 2013 17:09:38 +0200 (CEST)
In-Reply-To: <CAOMZO5BzaAmt0BNXvSw+a18QorOBmEjGwaA5PoQ_D6mVb6QiUw@mail.gmail.com>
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
Cc: Shawn Guo <shawn.guo@linaro.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

On 06/09/2013 04:50 PM, Fabio Estevam wrote:
> Hi,
> 
> When running linux-next 20130607 on a mx6qsabrelite I see that the audio
> drivers fail to probe. Added some printk's to better illustrate the
> problem:
> 
> mmcblk0: mmc0:b5a1 SD04G 3.69 GiB **** reading the chip ID sgtl5000: probe
> of 0-000a failed with error -5 ****** enabling the codec clock 
> imx-sgtl5000 sound.13: ASoC: CODEC (null) not registered imx-sgtl5000
> sound.13: snd_soc_register_card failed (-517) platform sound.13: Driver
> imx-sgtl5000 requests probe defer
> 
> The problem here is that the codec driver (sgtl5000) is being probed prior
> to the machine driver (imx-sgtl5000).
> 
> The reading of the chip ID fails because at this point in time there is no
> codec clock, which is turned on by imx-sgtl5000.

This sounds as if the CODEC driver should enable the CODEC clock and not the
machine driver.

> 
> Running 3.10-rc4, the order of the events is as expected: imx-sgtl5000 is
> called first and sgtl5000 is called later. In this case the probe works as
> usual.

There are two probe functions one for the i2c driver, one for the codec. The
I2C driver probe will be called as soon as the I2C device gets registered.
The codec probe will be called once all components for the ASoC sound card
(CPU DAI, codec, platform) are ready. Since you are checking the ID in the
I2C probe callback there is no guarantee that it will be called before or
after the machine driver will be probed.

> 
> Tried doing a bisect, but this was not succesful due to several bisect 
> breakages (build issues and non-booting kernels) on  its way.
> 

Well, your commit b871f1ad ("ASoC: sgtl5000: Read SGTL5000_CHIP_ID in
i2c_probe") moved things around. From one probe callback to the other.

- Lars
