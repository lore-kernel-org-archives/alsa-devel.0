From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ASoC: Ensure supplies are maintained for
 force enabled widgets
Date: Fri, 11 Feb 2011 08:56:51 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310F60612@HQMAIL01.nvidia.com>
References: <1297424653-20320-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id A3CA0245F7
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 17:57:01 +0100 (CET)
In-Reply-To: <1297424653-20320-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote at Friday, February 11, 2011 4:44 AM:
> If a widget has been force enabled then not only do we need to keep the
> widget itself enabled, we also need to keep any supplies the widget
> requires enabled. The user could force all the individual widgets on but
> this requires too much knowledge of device internals.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Tested-by: Stephen Warren <swarren@nvidia.com>

Thanks, this fixes the problem.

-- 
nvpublic
