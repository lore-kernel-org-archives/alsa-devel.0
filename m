From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ALSA: compress_core: Ensure device is
	stopped when	stream closed
Date: Fri, 26 Apr 2013 14:56:27 +0100
Message-ID: <20130426135627.GB27501@opensource.wolfsonmicro.com>
References: <20130426134706.GA27501@opensource.wolfsonmicro.com>
 <20130426134850.GX5019@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 65851260816
 for <alsa-devel@alsa-project.org>; Fri, 26 Apr 2013 15:56:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130426134850.GX5019@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

>> +     if ((data->stream.runtime->state == SNDRV_PCM_STATE_RUNNING) ||
>> +         (data->stream.runtime->state == SNDRV_PCM_STATE_PAUSED))
>> +             data->stream.ops->trigger(&data->stream, SNDRV_PCM_TRIGGER_STOP);
>> +
>
>A switch statement would be more idiomatic for this sort of thing.
>

This follows the general style used in other functions in the
source file. I'm happy to upload a version that uses a switch
instead if that's preferred.
