From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ASoC: Don't fail if we can't read the IRQ
	type in WM8903
Date: Tue, 6 Dec 2011 08:26:17 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1750B7734C@HQMAIL01.nvidia.com>
References: <1323168492-11003-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id A463024133
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 17:26:25 +0100 (CET)
In-Reply-To: <1323168492-11003-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote at Tuesday, December 06, 2011 3:48 AM:
> If we fail to read the IRQ type from the interrupt controller don't
> fail, just assume a value and solider on - we may fail later when we try
> to request the IRQ but it's possible we'll succeed.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Stephen Warren <swarren@nvidia.com>

Thanks.

-- 
nvpublic
