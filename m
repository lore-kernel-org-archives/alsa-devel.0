From: Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
Subject: Re: DPCM: skip DAPM_STREAM_STOP event to BE,
 if still used by other FE
Date: Sun, 5 Jun 2016 14:58:59 +0800
Message-ID: <1465109939.29781.2.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by alsa0.perex.cz (Postfix) with ESMTP id C32DA261294
 for <alsa-devel@alsa-project.org>; Sun,  5 Jun 2016 08:59:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: lgirdwood@gmail.com, chipeng.chang@mediatek.com, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

> If this isn't happening that seems like a bug, I'm a bit surprised
> nobody else ran into it?  Shouldn't the counts of stream events that
> happen be symmetric (ie, we get as many stops as starts), or are we
> possibly missing some from things being switched in and out or
something?

This idea is same as the DPCM BE state control, in

int dpcm_be_dai_hw_free(..)
{
......
                /* do not free hw if this BE is used by other FE */
                if (be->dpcm[stream].users > 1)
                        continue;

and

int dpcm_be_dai_shutdown(...)
{
....
                if (--be->dpcm[stream].users != 0)
                        continue;

The BE receiving SND_SOC_DAPM_STREAM_STOP event, while still used by a
FE who is in STREAM_START state. The DAPM will just inactive BE related
widget/dai without checking. This just doesn't seems right.

And the last FE using the BE calls in to dpcm_fe_dai_shutdown(), will
run the process normally.


Actually, i trace the log, when one of the FE sent stop event to "still
in use BE", the BE power state will not be changed. Until the system
goes into
SNDRV_CTL_POWER_D3cold, the BE will be shutdown (i did set the
ignore_suspend=1). I didn't check why the BE is not turned off at the
point when receiving the stop event.

I'm also curious why no one seems to have the same issue. Probably there
is not much DPCM architecture system yet on the Linux?
