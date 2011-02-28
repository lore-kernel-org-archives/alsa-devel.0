From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] add new Fermi 5xx codec IDs to snd-hda
Date: Mon, 28 Feb 2011 09:13:29 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF045687AE77@HQMAIL01.nvidia.com>
References: <1298855454.2347.27.camel@cartman.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id DB1CA103800
	for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2011 18:13:42 +0100 (CET)
In-Reply-To: <1298855454.2347.27.camel@cartman.lan>
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
To: Richard Samson <samson.richard@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Richard Samson wrote at Sunday, February 27, 2011 6:11 PM:
> ...
> I added a new entry in patch_hdmi.c to get sound working on my own 560
> Ti card :
> 
> --- patch_hdmi.c        2011-02-15 22:29:51.000000000 +0100
> +++ patch_hdmi_GTX-560Ti.c      2011-02-27 23:52:56.984613414 +0100
...
> patch_nvhdmi_8ch_89 },
>  { .id = 0x10de0014, .name = "GPU 14 HDMI/DP",  .patch =
> patch_nvhdmi_8ch_89 },
> +{ .id = 0x10de0016, .name = "GPU 16 HDMI/DP",   .patch =
> patch_nvhdmi_8ch_89 },
>  { .id = 0x10de0018, .name = "GPU 18 HDMI/DP",  .patch =
...

Acked-By: Stephen Warren <swarren@nvidia.com>

Hmm. When I submitted that last patch, I think I looked at the wrong branch
of our Windows drivers, and hence missed a couple IDs, and added a couple of
IDs that won't be used. Once this is merged, I'll follow up with another
patch to fix the other issues (or let me know if you just want me to provide
a single patch with everything in it, Takashi).

Thanks Richard.

-- 
nvpublic
