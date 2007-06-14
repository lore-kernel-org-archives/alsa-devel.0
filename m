From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [RFC][ASoC] New device/driver arch
Date: Thu, 14 Jun 2007 20:06:56 +0200
Message-ID: <20070614180656.GA22664@roarinelk.homelinux.net>
References: <1181842832.26658.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DCA4247BB
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jun 2007 20:06:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1181842832.26658.42.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>, Nobin Mathew <nobin.mathew@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Liam,

Is it possible to have 2 physical I2S units (which are connected to the same
codec) be repesented as a single ASoC device? (The SH7760 has 2 I2S units
which are "halfduplex" (only transmit OR capture at a time). My dev platform
simply uses the second unit for capture


I need a trigger callback in the  machine driver to properly support
multichannel I2S audio on Au1200 (the  Au1200 can only do stereo; to get
more channels we double/quadruple the I2S LRCLK coming from the codec;
however the CPLD needs to be told when a new sample starts; although
maybe that can be worked around in VHDL)

Thanks for the great work
	Manuel Lauss
