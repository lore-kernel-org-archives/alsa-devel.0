From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problem with mplayer and OSS on at91sam9g20(kernel
 2.6.30)
Date: Fri, 25 Sep 2009 09:03:16 +0200
Message-ID: <4ABC6B34.7080200@ladisch.de>
References: <4ABB67CA.6000003@atmel.com> <20090924145755.GB5105@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 5CE5C1038C7
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Sep 2009 09:07:38 +0200 (CEST)
In-Reply-To: <20090924145755.GB5105@sirena.org.uk>
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
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> I'd expect it's getting upset because it's being called with an
> invalid rate (OSS emulation calls hw_params with partially initialised
> parameters)

But even the uninitialized parameters conform to the constraints that
were set by the driver, so they should never be invalid.

Sedji, try running mplayer with -v, this should give more log messages
with the parameters that mplayer is trying to set.


Best regards,
Clemens
