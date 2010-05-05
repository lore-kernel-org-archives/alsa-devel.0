From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/8610: add probing for
 individual DMA channels, not just DMA controllers
Date: Wed, 05 May 2010 10:59:44 -0500
Message-ID: <4BE195F0.9070400@freescale.com>
References: <1272923655-31807-1-git-send-email-timur@freescale.com>
	<2928D88F-057B-498C-8A11-F7193429A90D@freescale.com>
	<20100505112208.GD5754@opensource.wolfsonmicro.com>
	<g2ied82fe3e1005050439v70066822h7518ac53f97e97f6@mail.gmail.com>
	<20100505123545.GA7139@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id A4D7C2476B
	for <alsa-devel@alsa-project.org>;
	Wed,  5 May 2010 17:59:52 +0200 (CEST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o45FxjXl004274
	for <alsa-devel@alsa-project.org>; Wed, 5 May 2010 08:59:50 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o45FxoXc016363
	for <alsa-devel@alsa-project.org>; Wed, 5 May 2010 10:59:50 -0500 (CDT)
In-Reply-To: <20100505123545.GA7139@rakim.wolfsonmicro.main>
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
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Wed, May 05, 2010 at 06:39:01AM -0500, Timur Tabi wrote:
>> On Wed, May 5, 2010 at 6:22 AM, Mark Brown
> 
>>> Just looking at the scheduling here with regard to the merge window and
>>> the fact that this doesn't seem to hurt the existing drivers perhaps it
>>> makes sense to merge this via the PowerPC tree immediately?
> 
>> Aren't we a little late in the cycle for a patch that doesn't do anything?
> 
> It seems to be safe enough for -next.

Sure, -next is fine.

-- 
Timur Tabi
Linux kernel developer at Freescale
