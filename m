From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] ASoC: dapm: Convert pin switches to use
	snd_soc_card
Date: Wed, 15 Feb 2012 08:54:28 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178FACB836@HQMAIL01.nvidia.com>
References: <1329268340-25342-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 47BCF24151
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 17:54:37 +0100 (CET)
In-Reply-To: <1329268340-25342-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Mark Brown wrote at Tuesday, February 14, 2012 6:12 PM:
> Since the addition of the non-CODEC control adds card controls like the
> DAPM pin switch have been broken as they are expecting the private data
> for the control to be the CODEC but it's now the card. Fix that for the
> pin switches, an audit of other drivers is required.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Tested-by: Stephen Warren <swarren@nvidia.com>
(on a board using tegra_wm8903 machine driver)

-- 
nvpublic
