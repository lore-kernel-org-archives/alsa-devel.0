From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Support for GT440 HDMI audio
Date: Tue, 6 Dec 2011 08:30:06 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1750B7734F@HQMAIL01.nvidia.com>
References: <20111206132918.GC2128@debbox.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A69124157
	for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2011 17:30:12 +0100 (CET)
In-Reply-To: <20111206132918.GC2128@debbox.it>
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
To: Andrey Tataranovich <tataranovich@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Andrey Tataranovich wrote at Tuesday, December 06, 2011 6:29 AM:
>  Please include following patch to add support for NVidia GT440 HDMI audio.
> This patch working for me on Debian Squeeze with patched alsa-source 1.0.23-dfsg+4.

> @@ -556,6 +556,8 @@ static struct hda_codec_preset snd_hda_p
...
> +	{ .id = 0x10de0014, .name = "GT440 HDMI",
> +	  .patch = patch_nvhdmi_8ch_89 },

That entry is already included in the latest driver; your patch was
created against quite an old driver.

-- 
nvpublic
