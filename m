From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: MPC5200: replace of_device with
	platform_device
Date: Wed, 24 Aug 2011 14:46:17 -0500
Message-ID: <4E555509.7080905@freescale.com>
References: <1314136106-26127-1-git-send-email-timur@freescale.com>
	<20110824091645.GD26317@sirena.org.uk> <4E551A5B.805@freescale.com>
	<20110824154456.GB16653@opensource.wolfsonmicro.com>
	<4E551DAA.2040509@freescale.com>
	<20110824155719.GC16653@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
	[216.32.180.30]) by alsa0.perex.cz (Postfix) with ESMTP id 7608424496
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 21:46:26 +0200 (CEST)
In-Reply-To: <20110824155719.GC16653@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Wed, Aug 24, 2011 at 10:50:02AM -0500, Timur Tabi wrote:
>> Mark Brown wrote:
>>> I'll apply it for 3.1, I was asking because I didn't know if the API
>>> change happened in 3.1 or was only present 3.2.  Thanks.
> 
>> I think the change happened in 3.0, or maybe even earlier.
> 
> Oh dear.  Can you check please, if it did there should be a CC stable?

Apparently it was broken from the start, as git-bisect blames this commit:

f0fba2ad1b6b53d5360125c41953b7afcd6deff0 is the first bad commit
commit f0fba2ad1b6b53d5360125c41953b7afcd6deff0
Author: Liam Girdwood <lrg@slimlogic.co.uk>
Date:   Wed Mar 17 20:15:21 2010 +0000

    ASoC: multi-component - ASoC Multi-Component Support

I suspect the problem is that the defconfig for the MPC5200 doesn't actually
enable audio, so when that platform was tested, none of the ASoC code was
actually compiled.

-- 
Timur Tabi
Linux kernel developer at Freescale
