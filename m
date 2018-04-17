From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/3] PCM cleanups
Date: Tue, 17 Apr 2018 12:05:54 +0900
Message-ID: <f061499c-adf6-7bf6-8cbf-709a62270ff5@sakamocchi.jp>
References: <20180416121417.27452-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 6CE212675D4
 for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2018 05:06:01 +0200 (CEST)
In-Reply-To: <20180416121417.27452-1-tiwai@suse.de>
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

On Apr 16 2018 21:14, Takashi Iwai wrote:
> Hi,
> 
> this is a patch series for minor cleanups of PCM core codes.
> Mostly to unify the direction-separated PCM callbacks to unified
> ones.
> 
> 
> Takashi
> 
> ===
> 
> Takashi Iwai (3):
>    ALSA: pcm: Clean up with snd_pcm_avail() and snd_pcm_hw_avail()
>      helpers
>    ALSA: pcm: Unify playback and capture poll callbacks

For the above two patches, I find no behaviour changes of PCM core.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

>    ALSA: pcm: Unify delay calculation in snd_pcm_status() and
>      snd_pcm_delay()
> 
>   sound/core/pcm_compat.c |  10 +--
>   sound/core/pcm_lib.c    |  15 +----
>   sound/core/pcm_local.h  |  18 +++++
>   sound/core/pcm_native.c | 175 ++++++++++++------------------------------------
>   4 files changed, 67 insertions(+), 151 deletions(-)


Regards

Takashi Sakamoto
