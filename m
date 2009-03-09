From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: snd-soc-pxa-ssp I2C/FIFO issues
Date: Mon, 9 Mar 2009 15:14:29 +0000
Message-ID: <20090309151428.GE13593@sirena.org.uk>
References: <74d0deb30903090747p3fbb8dd5l27cd7313d4be7de2@mail.gmail.com>
	<1236610986.6781.93.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 665BF2441F
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 16:14:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1236610986.6781.93.camel@vega.slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@kernel.org>
Cc: alsa-devel@alsa-project.org, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 09, 2009 at 03:03:06PM +0000, Liam Girdwood wrote:

> Iirc, PXA3x SSP is quite different in terms of "usability" compared to
> to PXA2x SSP. It might be worth diverging the SSP code a little here if
> your CPUs are different.

The PXA3xx variant is certainly rather more featureful in terms of the
clocking, though that one is already handled in the code.  For any
divergance that's needed in the rest of it I'd hope we'll be able to
keep the one driver but only replace some of the operations at runtime -
from memory hw_params() is the most likely place to need it.
