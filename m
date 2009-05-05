From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/2] ASoC: cs4270: introduce CS4270_I2C_INCR
Date: Wed, 6 May 2009 01:19:24 +0200
Message-ID: <20090505231924.GA28090@buzzloop.caiaq.de>
References: <1241515501-6600-1-git-send-email-daniel@caiaq.de>
	<4A005283.50306@freescale.com>
	<20090505151538.GC24556@buzzloop.caiaq.de>
	<20090505180859.GA3953@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 789BC24335
	for <alsa-devel@alsa-project.org>;
	Wed,  6 May 2009 01:19:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090505180859.GA3953@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 05, 2009 at 07:09:01PM +0100, Mark Brown wrote:
> > I planned to use that macro a second time for the register write-back at
> > resume time. But unfortunately, the i2c stack is so badly broken that it
> > does not allow the write of a whole data block without having the length
> > itself as part of the message (which is wrong for the codec).
> 
> Could you clarify what you mean when you say that the I2C block requires
> the length be part of the message?  The I2C stack needs to know the
> amount of data to write but I'm not aware of any restrictions it places
> on the content of the data.

All high-level i2c functions to write block data, namely
i2c_smbus_write_block_data() and i2c_smbus_write_i2c_block_data(), put
the length of the data being sent inside the block sent on the wire. I
couldn't believe it myself, but even my hardware I2C analyzer clearly
shows that. The API seems to assume that communication to I2C devices
always wants data to be sent with a leading command, followed by the
number of data bytes attached and then the data itself. Correct me if
I'm wrong on that.

Daniel
