From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] soc/lapis: add machine driver
Date: Tue, 6 Dec 2011 10:25:19 +0000
Message-ID: <20111206102519.GD28840@opensource.wolfsonmicro.com>
References: <1322819115-15808-1-git-send-email-tomoya.rohm@gmail.com>
	<20111202153401.GX8245@opensource.wolfsonmicro.com>
	<CANKRQniyjT_2Ko=EYmffu3_NzDJQTMm9nY6rUp-DQ70e6AVQpA@mail.gmail.com>
	<20111205183223.GB7467@opensource.wolfsonmicro.com>
	<CANKRQnhEFvubv0b63z34=_xn4x4q=20enofqPrMsFetj1x7-NQ@mail.gmail.com>
	<057C8CCF-453E-4DC2-8E22-3D260973D35E@cirrus.com>
	<CANKRQniQSUWyaKUcn24ungmAu0ABHhBZ1=YhGz5jAp02X=KTAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5286D103B7C
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 11:25:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CANKRQniQSUWyaKUcn24ungmAu0ABHhBZ1=YhGz5jAp02X=KTAA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, "Austin,
	Brian" <Brian.Austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, "qi.wang@intel.com" <qi.wang@intel.com>, Liam Girdwood <lrg@ti.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kok.howg.ewe@intel.com" <kok.howg.ewe@intel.com>, Daniel Mack <zonque@gmail.com>, "yong.y.wang@intel.com" <yong.y.wang@intel.com>, "joel.clark@intel.com" <joel.clark@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 06, 2011 at 11:37:52AM +0900, Tomoya MORINAGA wrote:

> Thanks.  However, i2c access code is not included in Samsung.
> Though OMAP includes i2c access code like below,
>   omap/sdp3430.c: twl_i2c_read_u8(TWL4030_MODULE_INTBR, &pin_mux,
>   omap/sdp3430.c: twl_i2c_write_u8(TWL4030_MODULE_INTBR, pin_mux,
> this code doesn't seem applicable for me.

> Could you show best practice for i2c access of machine driver?

I2C access by machine drivers is not good practice.  If you must do it
for some reason use the standard ASoC functions to read and write
registers.
