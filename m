From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/6] Misc PCM fixes
Date: Wed, 14 Jun 2017 10:57:30 +0900
Message-ID: <66b4737c-ebb8-ba73-2f51-53374673627e@sakamocchi.jp>
References: <20170613141812.21220-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 0979E2668BF
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 03:57:32 +0200 (CEST)
In-Reply-To: <20170613141812.21220-1-tiwai@suse.de>
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

On Jun 13 2017 23:18, Takashi Iwai wrote:
> Hi,
> 
> this is a kind of gleaning work, a collection of small cleanups of
> ALSA PCM implementations.
> 
> 
> Takashi
> 
> ===
> 
> Takashi Iwai (6):
>    ALSA: pcm: Clean up SNDRV_PCM_IOCTL_PAUSE code
>    ALSA: pcm: Apply power lock globally to common ioctls
>    ALSA: pcm: Allow dropping stream directly after resume
>    ALSA: pcm: Preprocess PAUSED or SUSPENDED stream before PREPARE
>    ALSA: pcm: Use common PCM_RUNTIME_CHECK() for sanity checks
>    ALSA: pcm: Skip ack callback without actual appl_ptr update
> 
>   sound/core/pcm_lib.c    |  3 ++
>   sound/core/pcm_native.c | 84 +++++++++++++++++++++----------------------------
>   2 files changed, 39 insertions(+), 48 deletions(-)

I reviewed all of changes in this patchset:

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Regards

Takashi Sakamoto
