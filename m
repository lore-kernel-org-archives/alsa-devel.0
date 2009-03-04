From: Daniel Mack <daniel@caiaq.de>
Subject: PXA SSP and external clocked I2S again
Date: Wed, 4 Mar 2009 21:15:05 +0100
Message-ID: <20090304201505.GE12183@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D100103828
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 21:15:09 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Tim Ruetz <tim@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Hi,

as denoted yesterday, we've spend some more time on the PXA/SSP/I2S
issue and would like to share conclusions about out utterly frustrating
trial-and-error sessions during the last days, especially as reference
for everyone who tries to get a similar setup running.

The situation on our board is: we have a tunable master clock generator,
a CS4270 codec and an PXA303 connected to each other. In order to use
the master clock, the PXA needs to be set to an external clock mode and
for the CS4270 to operate properly, we need to provide a full 64 bits
I2S stream, even though not all of the data bits (in fact, currently
only 16 of them per channel) carry data.

The above thing was not possible with the pxa-ssp's current approach as
it entirely relyed on the network mode and the time slots mechanism
which is - according to the datasheets - supposed to do exactly this,
but which simply doesn't work at all. It might work for existing boards
without our constrains, but that's more or less due to coincidence.

Hence, we switched over to non-network mode and fiddled around with the
PSP bits a lot until we found a mode that fits our needs, at least as
long as we let the PXA be master in the game (which we did for test
purposes).

As soon as the clock direction changes (codec takes over control for
LRCLK and bitclk), the PSP feature fails badly again. The final solution
is now to never ever set the PXA to a real slave mode (DAIFMT_CBM_CFM)
but only provide the master clock to its input pin (SSPEXTCLK), set the
clock config to SSP_CLK_EXT and let the PXA derive the other clocks from
that one internally.

Another thing is: ALSA doesn't currently provide a way to configure a
DAI format where the I2S protocol has more clock bits than data bits.
One of the upcoming series of 4 patches adds them.

Best regards,
Daniel
