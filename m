From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 20 Dec 2007 16:37:39 -0600
Message-ID: <476AEEB3.2010403@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>
	<20071220040633.GA6732@lixom.net> <476A7B23.2040905@freescale.com>
	<20071220223943.GA24138@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 43D842485F
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 23:37:48 +0100 (CET)
In-Reply-To: <20071220223943.GA24138@lixom.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Olof Johansson wrote:

>> I was just following the example from another board file.  However, the 'soc' 
>> node in the device tree does not have a compatible property, so I don't how to 
>> change this.
> 
> Then add an appropriate compatible entry to it, please.

None of the SOC nodes in any DTS have a "compatible" entry.  I understand the 
issue, but you're asking me to fix a larger problem, one that is beyond the 
scope of this patch.  You're saying that *all* SOC needs are incorrectly defined 
and need to be probed differently.

-- 
Timur Tabi
Linux kernel developer at Freescale
