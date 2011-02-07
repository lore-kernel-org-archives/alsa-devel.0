From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: WL1273 FM Radio driver...
Date: Mon, 07 Feb 2011 16:09:04 +0200
Message-ID: <1297087744.15320.56.camel@masi.mnp.nokia.com>
References: <1297075922.15320.31.camel@masi.mnp.nokia.com>
	<4D4FDED0.7070008@redhat.com>
	<20110207120234.GE10564@opensource.wolfsonmicro.com>
	<4D4FEA03.7090109@redhat.com>
	<20110207131045.GG10564@opensource.wolfsonmicro.com>
	<4D4FF821.4010701@redhat.com>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A7512438B
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 15:09:11 +0100 (CET)
In-Reply-To: <4D4FF821.4010701@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, hverkuil@xs4all.nl, lrg@slimlogic.co.uk, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-02-07 at 11:48 -0200, ext Mauro Carvalho Chehab wrote:
> Em 07-02-2011 11:10, Mark Brown escreveu:
> > On Mon, Feb 07, 2011 at 10:48:03AM -0200, Mauro Carvalho Chehab wrote:
> >> Em 07-02-2011 10:02, Mark Brown escreveu:
> >>> On Mon, Feb 07, 2011 at 10:00:16AM -0200, Mauro Carvalho Chehab wrote:
> > 
> >>>> the MFD part (for example, wl1273_fm_read_reg/wl1273_fm_write_cmd/wl1273_fm_write_data). 
> >>>> The logic that are related to control the radio (wl1273_fm_set_audio,  wl1273_fm_set_volume,
> >>>> etc) are not related to access the device via the MFD bus. They should be at
> >>>> the media part of the driver, where they belong.
> > 
> >>> Those functions are being used by the audio driver.
> > 
> >> Not sure if I understood your comments. Several media drivers have alsa drivers:
> > 
> > There is an audio driver for this chip and it is using those functions.
> 
> Where are the other drivers that depend on it?

There's the MFD driver driver/mfd/wl1273-core.c, which is to offer the
(I2C) I/O functions to the child drivers:
drivers/media/radio/radio-wl1273.c and sound/soc/codecs/wl1273.c.

Both children depend on the MFD driver for I/O and the codec also
depends on the presence of the radio-wl1273 driver because without the
v4l2 part nothing can be done...

Matti

> 
> Mauro
> 
