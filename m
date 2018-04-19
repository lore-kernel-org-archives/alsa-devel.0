From: Andrew Chant <achant@google.com>
Subject: Re: [alsa-devel] [PATCH 4/4] ALSA: usb: add UAC3 BADD profiles support
Date: Thu, 19 Apr 2018 17:42:57 +0800
Message-ID: <CANVWZtHn9jYczuhZiKyeC5yf1jjeKFySHv6RkY0ekDj5fD1h+w@mail.gmail.com>
References: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com> <1523658266-2259-5-git-send-email-ruslan.bilovol@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523658266-2259-5-git-send-email-ruslan.bilovol@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>, Jorge <jorge.sanjuan@codethink.co.uk>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 14, 2018 at 6:24 AM, Ruslan Bilovol
<ruslan.bilovol@gmail.com> wrote:
> Recently released USB Audio Class 3.0 specification
> contains BADD (Basic Audio Device Definition) document
> which describes pre-defined UAC3 configurations.
>
> BADD support is mandatory for UAC3 devices, it should be
> implemented as a separate USB device configuration.
> As per BADD document, class-specific descriptors
> shall not be included in the Device=E2=80=99s Configuration
> descriptor ("inferred"), but host can guess them
> from BADD profile number, number of endpoints and
> their max packed sizes.
>
> This patch adds support of all BADD profiles from the spec
>
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> ---
>  sound/usb/card.c       |  14 +++
>  sound/usb/clock.c      |   9 +-
>  sound/usb/mixer.c      | 313 +++++++++++++++++++++++++++++++++++++++++++=
++++--
>  sound/usb/mixer_maps.c |  65 ++++++++++
>  sound/usb/stream.c     |  83 +++++++++++--
>  sound/usb/usbaudio.h   |   2 +
>  6 files changed, 466 insertions(+), 20 deletions(-)

> --- a/sound/usb/mixer_maps.c
> +++ b/sound/usb/mixer_maps.c
> @@ -482,3 +482,68 @@ struct usbmix_ctl_map {
>         { 0 } /* terminator */
>  };
>
> +/*
> + * Control map entries for UAC3 BADD profiles
> + */
> +
> +static struct usbmix_name_map uac3_badd_generic_io_map[] =3D {
> +       { UAC3_BADD_FU_ID2, "Generic Out Playback" },
> +       { UAC3_BADD_FU_ID5, "Generic In Capture" },
> +       { 0 }                                   /* terminator */
> +};
> +static struct usbmix_name_map uac3_badd_headphone_map[] =3D {
> +       { UAC3_BADD_FU_ID2, "Headphone Playback" },
> +       { 0 }                                   /* terminator */
> +};
> +static struct usbmix_name_map uac3_badd_speaker_map[] =3D {
> +       { UAC3_BADD_FU_ID2, "Speaker Playback" },
> +       { 0 }                                   /* terminator */
> +};
> +static struct usbmix_name_map uac3_badd_microphone_map[] =3D {
> +       { UAC3_BADD_FU_ID5, "Mic Capture" },
> +       { 0 }                                   /* terminator */
> +};
> +/* Covers also 'headset adapter' profile */
> +static struct usbmix_name_map uac3_badd_headset_map[] =3D {
> +       { UAC3_BADD_FU_ID2, "Headset Playback" },
> +       { UAC3_BADD_FU_ID5, "Headset Capture" },
> +       { UAC3_BADD_FU_ID7, "Side Tone Mixing" },
Can you please call this "Sidetone"?
This better matches other Sidetone control names in the sound tree and
makes it compatible with existing Android userspace usage.
