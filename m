From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: pxassp dma pointer not moving
Date: Mon, 23 Feb 2009 17:46:46 +0000
Message-ID: <20090223174646.GF2078@sirena.org.uk>
References: <20090222214721.GB5893@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C8341037EC
	for <alsa-devel@alsa-project.org>; Mon, 23 Feb 2009 18:46:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090222214721.GB5893@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 22, 2009 at 10:47:21PM +0100, Daniel Mack wrote:

> I2S codec (CS4270) next to it. Things do work in general, including the
> setup of the SSP engine and clocks, and when using the OSS compat layer,
> I can see data on the bus. With the native ALSA API, however, the DMA

One other thing to check here is that because the OSS API will iterate
through several different calls to hw_params() since it sets each
parameter individually it's possible that the configuration done in one
of the intermediate states is causing your configuration to spring to
life.  It might be worth looking at what's different about the setup
done by the OSS API and working back from there.
