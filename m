From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] extend ad1938 codec driver to ad193x
 supporting ad1936/7/8/9
Date: Thu, 18 Mar 2010 11:18:48 +0000
Message-ID: <20100318111848.GB3080@opensource.wolfsonmicro.com>
References: <1268900221-6833-1-git-send-email-21cnbao@gmail.com>
	<1268900221-6833-2-git-send-email-21cnbao@gmail.com>
	<1268902095.3773.6.camel@odin>
	<3c17e3571003180208y34e4b5dekd2d23efa0723b641@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 48470243E4
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 12:18:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <3c17e3571003180208y34e4b5dekd2d23efa0723b641@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <barry.song@analog.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 18, 2010 at 05:08:01PM +0800, Barry Song wrote:
> On Thu, Mar 18, 2010 at 4:48 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> > Btw, have a look at wm8731.c. This driver supports both I2C and SPI and
> > is less churn than splitting out the code into three files.

> We have many discussion about a driver to support both spi and i2c in
> another device(ad714x). At the beginning, the way in wm8731.c is used,
> then after many comments, people agree splitting the driver to three
> modules is the best way. If you are interested in it, you may take a
> look at "input/misc: add Analog Devices AD714x captouch input driver"
> in linux-input maillist.

This was a discussion for the input subsystem and what makes sense here.
For ASoC we've been using the approach that WM8731 and other similar
drivers are using, please follow that approach with ASoC drivers.
Adding files per driver per bus type isn't helpful here.
