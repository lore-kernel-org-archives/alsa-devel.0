From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH 1/2] hda - fix ELD memory leak
Date: Tue, 15 Nov 2011 10:19:00 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1740805DDA@HQMAIL01.nvidia.com>
References: <20111115143155.GA28175@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A23124340
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 19:19:09 +0100 (CET)
In-Reply-To: <20111115143155.GA28175@localhost>
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
To: Wu Fengguang <fengguang.wu@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
	Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Wu Fengguang wrote at Tuesday, November 15, 2011 7:32 AM:
> memset(eld) clears eld->proc_entry which will leak the struct
> snd_info_entry when unloading the module.
>
> Fix it by
> - remove memset(eld)
> - set eld->eld_valid to true _after_ all eld fields have been filled
> - don't access the other eld fields when (eld->eld_valid == false)
>
> Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>

Acked-by: Stephen Warren <swarren@nvidia.com>

-- 
nvpublic
