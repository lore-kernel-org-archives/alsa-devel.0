From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/3] ASoC: cs4270: fix Master Capture
	Switch polarity
Date: Fri, 24 Apr 2009 10:45:29 -0500
Message-ID: <49F1DE99.7050104@freescale.com>
References: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EE5824389
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Apr 2009 17:45:52 +0200 (CEST)
In-Reply-To: <1240578026-1987-1-git-send-email-daniel@caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> The control modifies the MUTE register, hence the polarity must be
> inverted.

I have a question.  In alsamixer, the capture switch looks either like this:

                            ------

                          < Master >

or like this:


                            L    R
                            CAPTUR

                          < Master >

What exactly does this mean?  Which one is supposed to mean "muted"?
And how come even though this switch is a SOC_DOUBLE, I cannot control
the left and right channel independently with the < and > keys, and the
"M" key doesn't toggle it either.

-- 
Timur Tabi
Linux kernel developer at Freescale
