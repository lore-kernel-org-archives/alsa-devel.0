From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 3/3] ALSA: firewire-motu: constify snd_rawmidi_ops
 structures
Date: Tue, 15 Aug 2017 17:50:13 +0900
Message-ID: <d51599f7-0cd3-15e4-3faa-a85ffe593823@sakamocchi.jp>
References: <1502784594-14670-3-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502784594-14670-3-git-send-email-Julia.Lawall@lip6.fr>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, bhumirks@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Aug 15 2017 17:09, Julia Lawall wrote:
> These snd_rawmidi_ops structures are only passed as the third
> argument of snd_rawmidi_set_ops.  This argument is const, so the
> snd_rawmidi_ops structures can be const too.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>   sound/firewire/motu/motu-midi.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/firewire/motu/motu-midi.c b/sound/firewire/motu/motu-midi.c
> index e3acfcc..e55cab6 100644
> --- a/sound/firewire/motu/motu-midi.c
> +++ b/sound/firewire/motu/motu-midi.c
> @@ -128,12 +128,12 @@ static void set_midi_substream_names(struct snd_motu *motu,
>   
>   int snd_motu_create_midi_devices(struct snd_motu *motu)
>   {
> -	static struct snd_rawmidi_ops capture_ops = {
> +	static const struct snd_rawmidi_ops capture_ops = {
>   		.open		= midi_capture_open,
>   		.close		= midi_capture_close,
>   		.trigger	= midi_capture_trigger,
>   	};
> -	static struct snd_rawmidi_ops playback_ops = {
> +	static const struct snd_rawmidi_ops playback_ops = {
>   		.open		= midi_playback_open,
>   		.close		= midi_playback_close,
>   		.trigger	= midi_playback_trigger,

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Thanks

Takashi Sakamoto
