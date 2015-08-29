From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: fireworks/bebob/dice/oxfw:
	fix	substreams counting at vmalloc failure
Date: Sat, 29 Aug 2015 08:46:24 +0200
Message-ID: <55E15540.9020401@ladisch.de>
References: <1440812326-6008-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 787122605F2
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 08:47:15 +0200 (CEST)
In-Reply-To: <1440812326-6008-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> In PCM core, when hw_params() in each driver returns error, the state of
> PCM substream is kept as 'open'. In this case, current drivers for sound
> units on IEEE 1394 bus doesn't decrement substream counter in hw_free()
> correctly. This causes these drivers to keep streams even if not
> required.
>
> This commit fixes this bug. When snd_pcm_lib_alloc_vmalloc_buffer()
> fails, hw_params function in each driver returns without incrementing the
> counter.
>
> Reported-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> ---
>  sound/firewire/bebob/bebob_pcm.c         | 20 ++++++++++++++++----
>  sound/firewire/dice/dice-pcm.c           | 18 ++++++++++++++----
>  sound/firewire/fireworks/fireworks_pcm.c | 18 ++++++++++++++----
>  sound/firewire/oxfw/oxfw-pcm.c           | 17 +++++++++++++----
>  4 files changed, 57 insertions(+), 16 deletions(-)
