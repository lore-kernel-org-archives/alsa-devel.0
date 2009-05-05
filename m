From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: cs4270: introduce CS4270_I2C_INCR
Date: Tue, 5 May 2009 19:09:01 +0100
Message-ID: <20090505180859.GA3953@sirena.org.uk>
References: <1241515501-6600-1-git-send-email-daniel@caiaq.de>
	<4A005283.50306@freescale.com>
	<20090505151538.GC24556@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 75F2010382F
	for <alsa-devel@alsa-project.org>;
	Tue,  5 May 2009 20:09:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090505151538.GC24556@buzzloop.caiaq.de>
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

On Tue, May 05, 2009 at 05:15:38PM +0200, Daniel Mack wrote:

> I planned to use that macro a second time for the register write-back at
> resume time. But unfortunately, the i2c stack is so badly broken that it
> does not allow the write of a whole data block without having the length
> itself as part of the message (which is wrong for the codec).

Could you clarify what you mean when you say that the I2C block requires
the length be part of the message?  The I2C stack needs to know the
amount of data to write but I'm not aware of any restrictions it places
on the content of the data.

I've applied the first patch.
