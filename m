From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 00/14] ALSA: PCM suspend cleanup
Date: Tue, 15 Jan 2019 17:32:29 +0100
Message-ID: <44e0d627-99cd-b2f6-3030-0da7161ab4ca@perex.cz>
References: <20190115162155.6308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C5532667F5
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 17:32:37 +0100 (CET)
In-Reply-To: <20190115162155.6308-1-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Dne 15.1.2019 v 17:21 Takashi Iwai napsal(a):
> Hi,
> 
> this is a patch set to clean up the PCM suspend calls by introducing
> the PCM device PM ops.  This won't change much for ASoC but reduce
> lots of snd_pcm_suspend*() calls in other sound drivers.
> 
> Note that this patch series itself won't fix anything about the recent
> PM issue reported for Intel ASoC, but it was inspired through the
> discussion there.
> 
> 
> thanks,
> 
> Takashi
>

This change looks fine.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

Thanks,
  Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
