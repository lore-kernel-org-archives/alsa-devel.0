From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 20 Dec 2007 16:43:33 -0600
Message-ID: <476AF015.5040600@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	<20071220040633.GA6732@lixom.net>
	<476A7B23.2040905@freescale.com>	<20071220223943.GA24138@lixom.net>
	<476AEEB3.2010403@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <476AEEB3.2010403@freescale.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Timur Tabi <timur@freescale.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> Olof Johansson wrote:
> 
>>> I was just following the example from another board file.  However, the 'soc' 
>>> node in the device tree does not have a compatible property, so I don't how to 
>>> change this.
>> Then add an appropriate compatible entry to it, please.
> 
> None of the SOC nodes in any DTS have a "compatible" entry.

Not quite true; ep88xc, mpc8272ads, and pq2fads have them.

-Scott
