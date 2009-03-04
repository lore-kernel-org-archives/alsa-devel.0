From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 1/4] ASoC: Use network mode with 2
	slots	for 16-bit stereo in pxa-ssp/Zylonite
Date: Wed, 4 Mar 2009 02:34:24 +0100
Message-ID: <20090304013424.GA5165@buzzloop.caiaq.de>
References: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B08224422
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 02:34:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Phillip,

glad to see someone is wasting time with that issue, too :)

On Tue, Mar 03, 2009 at 04:10:51PM +0100, Philipp Zabel wrote:
> For consistency with 24-bit and 32-bit modes, don't send 16-bit stereo
> in one 32-bit transfer. Use 2 slots instead on Zylonite. It should result
> in exactly the same behaviour.
> Now it is possible to use 16-bit single slot transfers in pxa-ssp, which
> are needed for Magician to get two frame clock pulses per sample
> (one for each channel).

We've been fiddling around with these modes and registers for
another two days in a row now and figured out that literally all the
documentation about these registers is entirly bogus. In particular,
the network mode with the associated timeslots simply does not work at
all, according to our measurements.

Hence the question: how does your I2S signal look like at the moment?
How many clocks do you measure in one frame cylce, how many of them are
actually filled with data? And which format does the userspace use to
send samples in?

We finally got a mode now that outputs 2x16 bit on a 2x32 bits I2S
frame, padded with zeros. But that is in non-network modes, more
about that tomorrow ...

Thanks,
Daniel
