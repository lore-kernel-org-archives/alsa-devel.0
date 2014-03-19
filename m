From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: Regression caused by "ASoC: core: Rework
 SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV"
Date: Wed, 19 Mar 2014 17:46:02 +0100
Message-ID: <20140319174602.667f04ba@skate>
References: <20140130144807.5b102b28@skate>
 <alpine.DEB.2.10.1401300856050.10630@heelrod.ad.cirrus.com>
 <20140130160554.694a8a84@skate>
 <alpine.DEB.2.10.1401300922150.10630@heelrod.ad.cirrus.com>
 <alpine.DEB.2.10.1401300934340.10630@heelrod.ad.cirrus.com>
 <20140130175658.11469081@skate>
 <alpine.DEB.2.10.1401301108450.10630@heelrod.ad.cirrus.com>
 <20140130181607.6a694b8f@skate>
 <alpine.DEB.2.10.1401301122200.10630@heelrod.ad.cirrus.com>
 <20140210152244.19f9d647@skate>
 <alpine.DEB.2.02.1403191030070.14838@heelrod>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id C46B326510C
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 17:46:08 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1403191030070.14838@heelrod>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: Lior Amsalem <alior@marvell.com>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory =?UTF-8?B?Q2zDqW1lbnQ=?= <gregory.clement@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Dear Brian Austin,

On Wed, 19 Mar 2014 10:31:12 -0500, Brian Austin wrote:

> I found the issue WRT the CS42L51. It was actually the shift values for 
> the kcontrols were wrong :)
> 
> I have the changes and will be sending the patch shortly.  Your CC'd as 
> reporter if that's OK.

Excellent! Thanks for the investigation. I'll be testing your patch
next week as I get access to the appropriate platform.

Can you ensure to Cc: stable@ to get the patch included in the
appropriate previous kernel releases?

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
