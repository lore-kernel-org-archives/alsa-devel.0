From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [alsa-lib][PATCH 3/4] pcm: linear,
 route: handle linear formats with 20-bit sample on 4 bytes
Date: Tue, 5 Dec 2017 14:50:55 +0900
Message-ID: <0eaf46f0-5ea3-0d37-7570-731e31ad1485@sakamocchi.jp>
References: <06db78be-2d91-c996-5a5b-d408ff4a84fa@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 179A02676AA
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 06:50:57 +0100 (CET)
In-Reply-To: <06db78be-2d91-c996-5a5b-d408ff4a84fa@maciej.szmigiero.name>
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
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Nov 30 2017 07:17, Maciej S. Szmigiero wrote:
> The previous patch has added 20-bit PCM formats SND_PCM_FORMAT_{S,U}20 to
> alsa-lib.
> We need to extend the linear format conversion code with handling of these
> sample formats so they can also be utilized by applications that only
> recognize the more typical ones like SND_PCM_FORMAT_S16.
> 
> Since the conversion arrays are indexed by a format bit width divided by 8
> the easiest way to handle these formats is to treat them like they were
> 40-bit wide (the next free integer multiple of 8 bits).
> This doesn't create a collision risk with a future format since there can't
> really be a 40-bit sample format that occupies 4 bytes.
> 
> Make sure we use the getput conversion method for these formats since a
> direct conversion from / to them is not supported.
> 
> While we are at it let's also add asserts on a format bit width value
> in snd_pcm_linear_get_index() and snd_pcm_linear_put_index() received from
> snd_pcm_format_width() so we won't try to access memory outside a
> conversion array if for some reason this function had returned a value that
> is not in the expected range.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>   src/pcm/pcm_linear.c | 16 +++++++++++++---
>   src/pcm/pcm_route.c  |  6 ++++--
>   src/pcm/plugin_ops.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
>   3 files changed, 63 insertions(+), 9 deletions(-)
> 
> diff --git a/src/pcm/pcm_linear.c b/src/pcm/pcm_linear.c
> index 0d61e927323f..e4973a308004 100644
> --- a/src/pcm/pcm_linear.c
> +++ b/src/pcm/pcm_linear.c
> @@ -90,6 +90,7 @@ int snd_pcm_linear_get_index(snd_pcm_format_t src_format, snd_pcm_format_t dst_f
>   		endian = 0;
>   	pwidth = snd_pcm_format_physical_width(src_format);
>   	width = snd_pcm_format_width(src_format);
> +	assert(width >= 8 && width <= 32);
> 
> ...
> > @@ -121,6 +125,7 @@ int snd_pcm_linear_put_index(snd_pcm_format_t 
src_format, snd_pcm_format_t dst_f
>   		endian = 0;
>   	pwidth = snd_pcm_format_physical_width(dst_format);
>   	width = snd_pcm_format_width(dst_format);
> +	assert(width >= 8 && width <= 32);
>   	if (pwidth == 24) {
>   		switch (width) {
>   		case 24:

I can understand your intention to insert these assert(), while it's 
better not to include them in this series of patch.

A call of 'snd_pcm_format_physical_width()' and 'snd_pcm_format_width()'
returns 4 for 'SNDRV_PCM_FORMAT_IMA_ADPCM'. Furthermore, both of them
returns -EINVAL for 'SNDRV_PCM_FORMAT_MPEG', 'SNDRV_PCM_FORMAT_GSM' and
'SNDRV_PCM_FORMAT_SPECIAL'. They can bring wrong calculation to the
resampling function, in the worse case result in any fault.

However, this is another issue, at least out of your aim for this
patchset. It's a kind of bug for wider influence. I think to have
another opportunity to discuss about the way to handle such special
formats in the resampling layer. Would you please post this patchset
again without these assertions?

(Additionally, I suspect that current implementation of the resampling
layer itself is not enough proper for non-PCM samples such as float, DSD
and so on.)

And next time, please follow a below instruction.
1.use '--subject-prefix' option with 'alsa-lib][PATCH v3' for
   git-format-patch so that subject of your patches includes better
   information for reviewers.
   (If it's for kernel stuffs, just use '--v')
2. use '--cover-letter' option for git-format-patch so that you can
   write changelog of your successive work.
3.use '--thread' option for git-send-email (or add 'sendemail.thread'
   entry into your local repository) so that posted patches spin in one
   message thread.


Thanks

Takashi Sakamoto
