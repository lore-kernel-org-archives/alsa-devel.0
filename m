From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: use designated initializers
Date: Sat, 17 Dec 2016 19:17:13 +0900
Message-ID: <fec3a80d-32b1-427a-605c-13309b70ba6c@sakamocchi.jp>
References: <20161217005944.GA140281@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161217005944.GA140281@beast>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Dec 17 2016 09:59, Kees Cook wrote:
> Prepare to mark sensitive kernel structures for randomization by making
> sure they're using designated initializers. These were identified during
> allyesconfig builds of x86, arm, and arm64, with most initializer fixes
> extracted from grsecurity.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  sound/synth/emux/emux_seq.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/synth/emux/emux_seq.c b/sound/synth/emux/emux_seq.c
> index a0209204ae48..55579f6b8cb2 100644
> --- a/sound/synth/emux/emux_seq.c
> +++ b/sound/synth/emux/emux_seq.c
> @@ -33,13 +33,13 @@ static int snd_emux_unuse(void *private_data, struct snd_seq_port_subscribe *inf
>   * MIDI emulation operators
>   */
>  static struct snd_midi_op emux_ops = {
> -	snd_emux_note_on,
> -	snd_emux_note_off,
> -	snd_emux_key_press,
> -	snd_emux_terminate_note,
> -	snd_emux_control,
> -	snd_emux_nrpn,
> -	snd_emux_sysex,
> +	.note_on = snd_emux_note_on,
> +	.note_off = snd_emux_note_off,
> +	.key_press = snd_emux_key_press,
> +	.note_terminate = snd_emux_terminate_note,
> +	.control = snd_emux_control,
> +	.nrpn = snd_emux_nrpn,
> +	.sysex = snd_emux_sysex,
>  };

Regards

Takashi Sakamoto
