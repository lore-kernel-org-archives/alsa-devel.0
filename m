From: Leanne Girdwood <girdwood@gmail.com>
Subject: Re: [PATCH 0/7] Add capture support to compress API
Date: Thu, 18 Apr 2013 20:20:43 +1000
Message-ID: <CAE3SLkuPN_8SJxLq1PxrS0hxUwaB+7nVNi8XSJDfzDus+jhBHw@mail.gmail.com>
References: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com
 [209.85.217.180])
 by alsa0.perex.cz (Postfix) with ESMTP id ED6F1264EFC
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 12:21:03 +0200 (CEST)
Received: by mail-lb0-f180.google.com with SMTP id t11so2517039lbi.39
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 03:21:03 -0700 (PDT)
In-Reply-To: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, vinod.koul@intel.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

REMOVE THIS ADDRESS FROM THIS MAILING LIST PLEASE


On 18 April 2013 19:58, Richard Fitzgerald
<rf@opensource.wolfsonmicro.com>wrote:

> This chain of patches does some clearing up and add capture
> support to the compressed API.
>
> Missing is support for capture streams that don't use the
> copy callback. Also I have included two patches at the end
> of the chain that remove the buffer pointers and just use
> the cumulative values however as our setup uses the copy
> callback these are untested past build so should be taken
> with caution.
>
> Thanks,
> Charles
>
> Thess patches apply to:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>   branch "for-next"
>
> based on top of commit
>   126825e ALSA: snd-usb: add quirks handler for DSD streams
>
> - RichF
>
> Charles Keepax (7):
>   ALSA: compress_core: Update calc_avail to use cumulative values
>   ALSA: compress_core: Calculate avail correctly for capture streams
>   ALSA: compress_core: Deconstify copy callback buffer
>   ALSA: compress_core: Add support for capture streams
>   ASoC: soc-compress: Deduce stream direction
>   ALSA: compress_core: Remove unused hw_pointer
>   ALSA: compress_core: Rework writes to use cumulative values
>
>  include/sound/compress_driver.h |    4 +-
>  sound/core/compress_offload.c   |  117
> +++++++++++++++++++++++++-------------
>  sound/soc/soc-compress.c        |   11 +++-
>  3 files changed, 87 insertions(+), 45 deletions(-)
>
> --
> 1.7.2.5
>
>
