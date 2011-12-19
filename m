From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH v3] ASoC: Tegra machine ASoC driver for
 boards using ALC5332 codec
Date: Mon, 19 Dec 2011 13:00:33 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF176BE92B19@HQMAIL01.nvidia.com>
References: <1324324312-11478-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 9290624936
	for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2011 22:01:32 +0100 (CET)
In-Reply-To: <1324324312-11478-1-git-send-email-leon@leon.nu>
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
To: Leon Romanovsky <leon@leon.nu>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrey Danin <danindrey@mail.ru>
List-Id: alsa-devel@alsa-project.org

Leon Romanovsky wrote at Monday, December 19, 2011 12:52 PM:
> At this stage only Toshiba AC100/Dynabook supported.
> 
> Signed-off-by: Leon Romanovsky <leon@leon.nu>
> Signed-off-by: Andrey Danin <danindrey@mail.ru>

Acked-by: Stephen Warren <swarren@nvidia.com>

I also attempted to test this, but couldn't persuade any audio to come
out. What more do I need to test this, beyond the obvious addition of
platform device registration and clocks to board-paz00.c? Thanks.

-- 
nvpublic
