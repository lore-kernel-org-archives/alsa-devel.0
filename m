From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] Channel mapping API (take 2)
Date: Wed, 05 Sep 2012 08:49:29 +0200
Message-ID: <5046F5F9.7090002@canonical.com>
References: <s5hhard23jb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C1CC32652E8
 for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2012 08:49:30 +0200 (CEST)
In-Reply-To: <s5hhard23jb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/04/2012 05:47 PM, Takashi Iwai wrote:
> Hi,
>
> my proposal for channel mapping API seems accepted fairly well through
> discussions at Plumbers, so I continued to work on it and uploaded the
> updated version.
>
> The kernel part is found in sound-unstable tree topic/tlv-chmap branch
>    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git
>
> and the alsa-lib part is found in github tree topic/chmap branch
>    git://git.github.com/tiwai/alsa-lib.git
>
> The updated parts are:
>
> - SNDRV_CHMAP_NA was newly added, indicating the channel is not
>    available or silent.
>
> - The channel position value is masked in lower 16bit.
>    The upper bits are used for more channel attributes as bit flags.
>
>    #define SNDRV_CHMAP_POSITION_MASK	0xffff
>
>    The phase inverted channel has this bit:
>    #define SNDRV_CHMAP_PHASE_INVERSE	(0x01 << 16)
>
>    And the driver-specific non-standard channel position has this:
>    #define SNDRV_CHMAP_DRIVER_SPEC	(0x02 << 16)

Just a comment here:

If this is meant to be used for those (mostly pro-audio) cards that just 
have their outputs in simple numbers, maybe we should call it

#define SNDRV_CHMAP_NUMBERED

instead?

>
> - The alsa-lib API functions use snd_pcm_chmap_query_t and
>    snd_pcm_chmap_t instead of ambiguous integer arrays.
>
> ================================================================
> /** the channel map header */
> typedef struct snd_pcm_chmap {
> 	unsigned int channels;
> 	unsigned int pos[0];
> } snd_pcm_chmap_t;
>
> /** the header of array items returned from snd_pcm_query_chmaps() */
> typedef struct snd_pcm_chmap_query {
> 	enum snd_pcm_chmap_type type;
> 	snd_pcm_chmap_t map;
> } snd_pcm_chmap_query_t;
>
>
> snd_pcm_chmap_query_t **snd_pcm_query_chmaps(snd_pcm_t *pcm);
> void snd_pcm_free_chmaps(snd_pcm_chmap_query_t **maps);
> snd_pcm_chmap_t *snd_pcm_get_chmap(snd_pcm_t *pcm);
> int snd_pcm_set_chmap(snd_pcm_t *pcm, const snd_pcm_chmap_t *map);
> ================================================================
>
> The rest aren't so much changed.  Only slight bug fixes.
>
> A big remaining question is whether the current kernel-side
> implementation is OK.  We may add some PCM ops pointer instead of the
> current style using the direct control tlv/read/write override.

That seems nicer, probably.

Also, if nothing is implemented on the kernel side for the specific 
driver (e g we have many older drivers that I suspect no one will write 
an implementation for), what will alsa-lib return in that case?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
