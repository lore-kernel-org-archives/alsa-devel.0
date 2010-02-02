From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ALSA: ASoC: fix PXA SSP port resume
Date: Tue, 02 Feb 2010 10:51:28 +0000
Message-ID: <1265107888.4194.59.camel@odin>
References: <20100129140001.GB4768@rakim.wolfsonmicro.main>
	<1265081575-24583-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D8F710381A
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 11:51:32 +0100 (CET)
Received: by ewy23 with SMTP id 23so2578926ewy.4
	for <alsa-devel@alsa-project.org>; Tue, 02 Feb 2010 02:51:32 -0800 (PST)
In-Reply-To: <1265081575-24583-1-git-send-email-daniel@caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Looks fine except for commit message (sorry to nitpick).

On Tue, 2010-02-02 at 11:32 +0800, Daniel Mack wrote:
> Unconditionally save the register states in resume 

I assume you mean suspend here ?

> and restore them
> again at resume time. Register contents are not preserved over suspend,

were not being preserved

> and the driver takes false assumptions about them otherwise.
> 

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
