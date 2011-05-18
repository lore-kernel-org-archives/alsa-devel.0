From: Stephen Warren <swarren@nvidia.com>
Subject: ASoC "long name" generation,
 without enumerating all machine_is_xxx() calls
Date: Wed, 18 May 2011 13:07:33 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A47AA7@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id BFEDD24337
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 22:07:39 +0200 (CEST)
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
To: "Liam Girdwood (lrg@ti.com)" <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Liam,

I have a question about your recent "long name" change:

commit 22de71ba03311cdc1063757c50a1488cb90a1fca
ASoC: core - allow ASoC more flexible machine name

The question is: How to generate the long name. The only example I could
find of this was:

+	if (machine_is_omap_4430sdp())
+		snd_soc_sdp4430.name = "SDP4430";
+	else if (machine_is_omap4_panda())
+		snd_soc_sdp4430.name = "Panda"

(from http://patchwork.ozlabs.org/patch/67831/)

But, I don't really want to call machine_is_xxx for every single machine
the tegra-wm8903 driver can support; upstream there are 5 so far, and
more similar derivatives downstream. That said, I suppose the code is
already switching on machine_is_xxx to pick the correct dapm_route map,
so I could just assign the name there, and fold multiple identical
machines onto a single name.

It looks like the kernel doesn't have any kind of machine_name() API;
the code in e.g. arch/arm/kernel/setup.c that prints the machine name at
boot stores it in a static that's only exposed through syss/similar file.

Thanks for any hints!

-- 
nvpublic
