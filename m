From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 5/6] ASoC: Convert WM8903 to direct regmap
	API usage
Date: Fri, 2 Dec 2011 12:30:28 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174FDB061F@HQMAIL01.nvidia.com>
References: <20111202192330.GA4333@opensource.wolfsonmicro.com>
	<1322854095-14437-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1322854095-14437-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 09A59103827
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 21:31:21 +0100 (CET)
In-Reply-To: <1322854095-14437-5-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Mark Brown wrote at Friday, December 02, 2011 12:28 PM:
> Converting to an rbtree cache as regcache doesn't have a flat cache.
> Since the top of the register map is fairly sparse this should be an
> overall win.

> +static bool wm8903_readable_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case WM8903_FLL_CONTROL_1:
> +	case WM8903_FLL_CONTROL_2:
> +	case WM8903_FLL_CONTROL_3:
> +	case WM8903_FLL_CONTROL_4:

Those four symbols don't exist.

-- 
nvpublic
