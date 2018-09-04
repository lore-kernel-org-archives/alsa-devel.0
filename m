From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/5] Set SNDRV_PCM_INFO_SYNC_APPLPTR to
 indirect PCM usages
Date: Tue, 4 Sep 2018 18:36:04 +0900
Message-ID: <f370d699-a31d-d68e-aa31-58a0881f10fa@sakamocchi.jp>
References: <20180904061851.1934-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 480D12678CB
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 11:36:09 +0200 (CEST)
Received: by mail-pl1-f193.google.com with SMTP id f6-v6so1384319plo.1
 for <alsa-devel@alsa-project.org>; Tue, 04 Sep 2018 02:36:08 -0700 (PDT)
In-Reply-To: <20180904061851.1934-1-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 4 2018 15:18, Takashi Iwai wrote:
> Hi,
> 
> this is a patch set to pass the missing SNDRV_PCM_INFO_SYNC_APPLPTR
> flag to the drivers using the indirect PCM helpers.  Also, one cleanup
> of the indirect PCM helper usage in mips/hal2 driver is included.
> 
> 
> Takashi
> 
> ===
> 
> Takashi Iwai (5):
>    ALSA: rme32: Use SNDRV_PCM_INFO_SYNC_APPLPTR info flag
>    ALSA: mips: Use SNDRV_PCM_INFO_SYNC_APPLPTR info flag
>    ALSA: emu10k1: Use SNDRV_PCM_INFO_SYNC_APPLPTR info flag
>    ALSA: cs46xx: Use SNDRV_PCM_INFO_SYNC_APPLPTR info flag
>    ALSA: mips: Cleanup indirect PCM helper usages
> 
>   sound/mips/hal2.c             | 13 +++++--------
>   sound/pci/cs46xx/cs46xx_lib.c |  6 ++++--
>   sound/pci/emu10k1/emupcm.c    |  3 ++-
>   sound/pci/rme32.c             | 22 ++++++++--------------
>   4 files changed, 19 insertions(+), 25 deletions(-)

I reviewed all of the five patches:
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Regards

Takashi Sakamoto
