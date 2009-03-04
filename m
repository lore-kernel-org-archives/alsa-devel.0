From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/4] ASoC: Use network mode with 2
	slots	for 16-bit stereo in pxa-ssp/Zylonite
Date: Wed, 4 Mar 2009 14:29:36 +0000
Message-ID: <20090304142934.GA433@sirena.org.uk>
References: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
	<20090304013424.GA5165@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E7B5224561
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 15:29:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090304013424.GA5165@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 02:34:24AM +0100, Daniel Mack wrote:

> Hence the question: how does your I2S signal look like at the moment?
> How many clocks do you measure in one frame cylce, how many of them are
> actually filled with data? And which format does the userspace use to
> send samples in?

> We finally got a mode now that outputs 2x16 bit on a 2x32 bits I2S
> frame, padded with zeros. But that is in non-network modes, more
> about that tomorrow ...

Zylonite generates I2S signals which look OK but which don't have any
padding.
