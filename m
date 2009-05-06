From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: cs4270: introduce CS4270_I2C_INCR
Date: Wed, 6 May 2009 09:44:34 +0100
Message-ID: <20090506084434.GA6573@sirena.org.uk>
References: <1241515501-6600-1-git-send-email-daniel@caiaq.de>
	<4A005283.50306@freescale.com>
	<20090505151538.GC24556@buzzloop.caiaq.de>
	<20090505180859.GA3953@sirena.org.uk>
	<20090505231924.GA28090@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E4D7A24604
	for <alsa-devel@alsa-project.org>;
	Wed,  6 May 2009 10:44:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090505231924.GA28090@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 06, 2009 at 01:19:24AM +0200, Daniel Mack wrote:

> All high-level i2c functions to write block data, namely
> i2c_smbus_write_block_data() and i2c_smbus_write_i2c_block_data(), put
> the length of the data being sent inside the block sent on the wire. I
> couldn't believe it myself, but even my hardware I2C analyzer clearly
> shows that. The API seems to assume that communication to I2C devices
> always wants data to be sent with a leading command, followed by the
> number of data bytes attached and then the data itself. Correct me if
> I'm wrong on that.

That's not the I2C API, that's the SMBus API.  SMBus is more restricted
than I2C - it essentially defines a protocol on top of I2C.  If the
device doesn't implement SMBus then you should use the I2C API directly.
