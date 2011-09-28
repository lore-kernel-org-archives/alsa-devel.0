From: Patrick Lai <plai@codeaurora.org>
Subject: Re: Signaling user-space through kcontrol
Date: Wed, 28 Sep 2011 09:27:31 -0700
Message-ID: <4E834AF3.6020800@codeaurora.org>
References: <4E82BB4C.1030801@codeaurora.org>
	<1317190544.1573.1646.camel@vkoul-udesk3>
	<4E82C307.30407@codeaurora.org>
	<1317193412.1573.1647.camel@vkoul-udesk3>
	<4E82CC33.7060608@codeaurora.org>
	<20110928104855.GA28309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 243F6103959
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 19:11:09 +0200 (CEST)
In-Reply-To: <20110928104855.GA28309@sirena.org.uk>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

> Something like that specific example should probably be reported via the
> snd_jack accessory detection infrastructure which can then offer a
> consistent interface between all sound cards with minimal work on the
> part of the individual driver.  There will doubtless be other examples
> though.

Agree that should go through consistent interface but not exactly sure
if going through input device interface is appropriate though. Isn't
the same reasoning why it has been decided to create ALSA specific API
for headset detection?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
