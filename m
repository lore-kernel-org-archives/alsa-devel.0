From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: Add rate defines for 352k8 and 384k
Date: Tue, 7 Jun 2016 13:26:31 +0100
Message-ID: <20160607122631.GO20422@localhost.localdomain>
References: <1465137301-21042-1-git-send-email-clive.messer@digitaldreamtime.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 640FC2606D6
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2016 14:26:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1465137301-21042-1-git-send-email-clive.messer@digitaldreamtime.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: DigitalDreamtime <clive.messer@digitaldreamtime.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 05, 2016 at 03:35:01PM +0100, DigitalDreamtime wrote:
> Add SNDRV_PCM_RATE_352800 and SNDRV_PCM_RATE_384000 defines to pcm.h,
>  for 352k8 and 384k sample rates.
> 
> Add SNDRV_PCM_RATE_8000_384000 define to pcm.h.
> 
> Update rates list in pcm_native.c.
> 
> Yes, we can use CONTINUOUS/KNOT and constraints, to support the x8
>  sample rates, but having the defines requires less code in drivers.
> Many more DAC chips are now supporting the x8 44k1/48k multiples.
> >From a high-res viewpoint, the DXD standard is 352k8, 24 bit.
> That alone should justify the addition of a define for it.
> 
> Signed-off-by: DigitalDreamtime <clive.messer@digitaldreamtime.co.uk>
> ---

Certainly looks like these rates are going to become pretty
widely used from our side so for what is worth:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

I am sure Brian would weight in on the side of this one as
well but he is on holiday this week.

Thanks,
Charles
