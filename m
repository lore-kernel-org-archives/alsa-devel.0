From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] Channel mapping API
Date: Tue, 21 Aug 2012 13:24:53 +0200
Message-ID: <50337005.7090404@canonical.com>
References: <s5hr4r0359e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 91F5E265352
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 13:24:52 +0200 (CEST)
In-Reply-To: <s5hr4r0359e.wl%tiwai@suse.de>
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

On 08/21/2012 12:31 PM, Takashi Iwai wrote:
> Hi,
>
> this is a progress report of my longstanding TODO, the channel map API
> implementation.  I'm going to cover this at Plumbers audio uconf, so
> we can discuss details there, too.
>
> The channel mapping API provides a method for user-space to query, get
> and set the channel map of a PCM stream.  It's required for assigning
> channels properly for multi-channel streams.
>
>
> * KERNEL IMPLEMENTATION
>
> In my latest attempt, I implemented with control elements.  A control
> element is created for each PCM substream with the corresponding
> device and substream index.  Then it gives a TLV for querying maps, a
> read op for obtaining the current map, and optionally a write op for
> setting the map.  The obvious merit by this way is that no extra
> kernel ABI is required.
>
> A couple of new helper functions are provided for assigning standard
> channel maps.  Currently, HD-audio and AC97 drivers has some
> implementation.
>
>
> * ALSA-LIB IMPLEMENTATION
>
> The additional alsa-lib API functions look like:
>
>    int **snd_pcm_query_chmaps(snd_pcm_t *pcm);
>    int *snd_pcm_get_chmap(snd_pcm_t *pcm);
>    int snd_pcm_set_chmap(snd_pcm_t *pcm, const int *map);
>
> snd_pcm_query_chmaps() returns the list of channel maps.  A channel
> map is represented by an integer array, beginning with the channel map
> type, followed by the number of channels, and the position of each
> channel, e.g.
>    { SND_CHMAP_FIXED, 4, SND_CHMAP_FL, SND_CHMAP_FR, SND_CHMAP_RL, SND_CHMAP_RR }
>
> snd_pcm_get_chmap() returns the currently assigned channel map for the
> given PCM stream.  If the PCM is before prepared, it fills UNKNOWN.
>
> When a driver allows user to change the channel map, user can call
> snd_pcm_set_chmap().  For example, HDMI allows you to choose whether
> it's 4.0 or 3.1 output.

Interesting. A few thoughts here:

1) You seem to have invented new constants for different channels 
(SND_CHMAP_FL for "front left" etc). There is already a channel 
enumeration in include/mixer.h, _snd_mixer_selem_channel_id. Is there a 
reason we can't just reuse it for this purpose?
If we can't, we should at least make sure that everywhere we have these 
declarations, they always correspond to the same value and add comments 
that they need to be kept in sync.

2) a chmap struct would probably be more elegant, something like:

struct snd_chmap {
	int type; /* or snd_pcm_chmap_type? */
	int count;
	int channels[SND_MIXER_SCHN_LAST+1]; /* Or variable length? */
}

3) Can you use snd_pcm_set_chmap before snd_pcm_prepare, and if so, it 
seems a bit strange that snd_pcm_get_chmap does not return what you have 
previously set.

4) The question of memory allocation for _get and _query, who is 
supposed to allocate and free the snd_chmap array?

5) I'm not sure I'm getting the _VAR and _PAIRED types, even though I 
read the documentation. Is this for the query only? Or if not, what 
would it mean to get/set a channelmap with _VAR type?

>
>
> * RESOURCES
>
> The latest kernel patchset is found in sound-unstable tree
> topic/tlv-chmap branch.
>    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable.git topic/tlv-chmap
>
> The alsa-lib portion is found in a tree on github topic/chmap branch.
>    git://github.com/tiwai/alsa-lib.git topic/chmap
>
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
