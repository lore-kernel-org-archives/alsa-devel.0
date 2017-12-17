From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib][PATCH v3 0/4] add SNDRV_PCM_FORMAT_{S,
	U}20
Date: Sun, 17 Dec 2017 17:37:56 +0900
Message-ID: <53606aed-3dd1-8a1d-37d9-58a305d609ae@sakamocchi.jp>
References: <4937250f-311b-ab79-dacd-6980ffdb2145@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id BB71F267028
 for <alsa-devel@alsa-project.org>; Sun, 17 Dec 2017 09:38:02 +0100 (CET)
In-Reply-To: <4937250f-311b-ab79-dacd-6980ffdb2145@maciej.szmigiero.name>
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
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Dec 14 2017 22:50, Maciej S. Szmigiero wrote:
> This format is similar to an existing 20-bit PCM format
> SNDRV_PCM_FORMAT_{S,U}20_3, however it occupies 4 bytes instead of 3.
> 
> Changes from v1: Split the monolithic submission into separate
> commits. (Note that v2 wasn't tagged as such.)
> 
> Changes from v2: Add commas at the end of two possible last entries of
> the snd_pcm_format_t enum so diffs will be more readable when new PCM
> formats are added in the future, remove asserts from
> snd_pcm_linear_{get,put}_index().
> 
> Maciej S. Szmigiero (4):
>    asound.h: add SNDRV_PCM_FORMAT_{S,U}20
>    pcm: add and describe SND_PCM_FORMAT_{S,U}20
>    pcm: linear, route: handle linear formats with 20-bit sample on 4
>      bytes
>    pcm: plug: add SND_PCM_FORMAT_{S,U}20 to linear_preferred_formats
> 
>   include/pcm.h          | 20 ++++++++++++++++++--
>   include/sound/asound.h |  9 +++++++++
>   src/pcm/pcm.c          | 10 ++++++++++
>   src/pcm/pcm_linear.c   | 14 +++++++++++---
>   src/pcm/pcm_local.h    |  4 ++++
>   src/pcm/pcm_misc.c     | 41 ++++++++++++++++++++++++++++++++++++++---
>   src/pcm/pcm_plug.c     | 11 +++++++++++
>   src/pcm/pcm_route.c    |  6 ++++--
>   src/pcm/plugin_ops.h   | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
>   9 files changed, 151 insertions(+), 14 deletions(-)

I reviewed all of these four patches.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


I found some minor issues in current implementation of linear
interpolation in alsa-lib.

* 'src/pcm/plugin_ops.h' includes some unused macros:
  * COPY_LABELS/COPY_END
  * GETU_LABELS/GETU_END
  * NORMS_LABELS/NORMS_END
* 'put32_labels' includes wrong comments for 18/20 bits formats.
* A reorder of entries in below tables may allow us to simplify
   implementation of snd_pcm_linear_get_index() and
   snd_pcm_linear_put_index().
  * get16_labels
  * put16_labels
  * get32_labels
  * put32_labels

Anyway, the above issues are irrelevant to your patchset. Your work
can be merged to alsa-lib independently.


Thanks

Takashi Sakamoto
