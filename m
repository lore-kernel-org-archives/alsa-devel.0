From: Stuart Longland <redhatter@gentoo.org>
Subject: Binding multiple registers to an enum
Date: Mon, 13 Sep 2010 09:31:51 +1000
Message-ID: <20100912233151.GU14056@atomos.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7499124454
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Sep 2010 01:32:01 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1Ouw1Z-0005tw-Jq
	for alsa-devel@alsa-project.org; Mon, 13 Sep 2010 09:31:57 +1000
Received: from [203.94.56.252] (helo=atomos.dmz.longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1Ouw1Z-0005tN-2q
	for alsa-devel@alsa-project.org; Mon, 13 Sep 2010 09:31:53 +1000
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
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi all,

Just working on the TLV320AIC3204 driver again... I've got an issue
where we get noise on recording inputs if I don't drive unused inputs to
the common mode.  Now there's a register which can do exactly this.

Each of the inputs can be routed through a difference series
resistance... this selection is done by enum controls, with the options
being: not-connected, 10k, 20k or 40k.  My plan, is that when
'not-selected' is chosen, I set the appropriate bit in the floating
input register so it gets connected to common-mode... and when something
else is chosen, that bit gets cleared.

I've tried lying to DAPM and telling it these bits control PGAs on the
inputs themselves... but it gets the wrong idea about which ones need to
be turned on.  Perhaps I should investigate that ... but the idea of
using PGA controls doesn't seem quite right.

I've looked at SOC_ENUM_EXT, which would do what I want (I already use
this to keep ADC OSR and DAC OSR settings in sync) however, these
controls have implications for signal routing, and therefore DAPM needs
to know about them, so really it'd be a SOC_DAPM_ENUM_EXT control I'd be
after.  I can't see such a thing however... how does one go about doing
this?

Regards,
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
