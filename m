From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: ASoC: About amp driver
Date: Mon, 15 Jun 2009 20:15:53 +0900
Message-ID: <4A362D69.2010609@samsung.com>
References: <4A35FE49.4090805@samsung.com>
	<20090615090756.GA6106@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout5.samsung.com (mailout5.samsung.com [203.254.224.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 1835224441
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Jun 2009 13:16:06 +0200 (CEST)
Received: from epmmp1 (mailout5.samsung.com [203.254.224.35])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KLA007US1YHJS@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 15 Jun 2009 20:15:53 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KLA00FK31YHGL@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 15 Jun 2009 20:15:53 +0900 (KST)
In-reply-to: <20090615090756.GA6106@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/15/2009 6:07 PM, Mark Brown wrote:
> On Mon, Jun 15, 2009 at 04:54:49PM +0900, Joonyoung Shim wrote:
> 
>> I have one question. Currently, the amp driver of ASoC is included in machine
>> driver. (ex. neo1973_wm8753 machine driver)
>> I want to use the same amp driver in more than one machine driver, but then the
>> same amp driver code exists double in each machine driver.
> 
>> So, how about spliting between the amp driver and the machine driver? and Is it
>> possible?
> 
> Put the generic bits of the amp driver in sound/soc/codecs (there won't
> be much).  At the minute you'll need to glue it in in via the machine
> driver in the same way that OpenMoko does, there's not really any
> support for multiple devices in the analouge part of the audio
> subsystem.  This is on my radar to deal with, I have some systems where
> it is relevant, but it's not there yet.

This is heard me there is no way to split the amp driver from machine driver
at the minute.

The lm4857 amp driver is a complete i2c driver seperated in neo1973_wm8753.c.
It makes me confused that two complete drivers exist in a same file.
The controls of the lm4857 amp driver is depended only by neo1973 machine
driver because of registration through init() of snd_soc_dai_link.
I considered following some modification to solve this dependency.
For example, the amp_init field is added in snd_soc_dai_link struct and the
machine driver assigns the init function of amp driver in amp_init field of
dai_link, and snd_soc_init_card() calls amp_init() of dai_link as init() call
in soc-core.

Is this wrong solution?

Thank you for your reply.
