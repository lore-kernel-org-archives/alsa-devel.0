From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: PXA SSP - work in progress
Date: Fri, 13 Mar 2009 14:37:24 +0000
Message-ID: <20090313143720.GC8989@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 923E21037FA
	for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2009 16:06:51 +0100 (CET)
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
To: Daniel Mack <daniel@caiaq.de>, pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I worked a bit on the PXA SSP code last night and was able to come up
with a configuration which uses non-network mode for I2S and works well
on the Zylonite.  I'll post the current series I have in a followup to
this, if you could take a look that'd be great - I haven't yet worked
through all the testing I'd like to do.

Unfortunately it's going to have broken Daniel's configuration since I
inverted the sense of LRCLK as the chip seemed not to generate an LRCLK
with a non-zero frame delay; I need to check to see if this is just
something I've overlooked.  Hopefully Daniel's system should just have
inverted the left and right channels.

Having worked through non-network mode my feeling is that we should be
able to come up with something that can figure out the extra clock
cycles needed for Daniel's configuration with less of a special case.
Non-network mode does seem like a better default than network mode
because it avoids needing to look at the TDM configuration unless you
want to use that.
