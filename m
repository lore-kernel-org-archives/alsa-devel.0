From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH v4 1/4] ALSA: usb-audio: UAC3. Add support for mixer unit.
Date: Mon, 14 May 2018 23:54:42 +0300
Message-ID: <CAB=otbT1WtPkrYuGwR0qEwFEjc=B26SNa-4pZS3_wk1ZHVaLXg@mail.gmail.com>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180511152537.32267-1-jorge.sanjuan@codethink.co.uk> <20180511152537.32267-2-jorge.sanjuan@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180511152537.32267-2-jorge.sanjuan@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 11, 2018 at 6:25 PM, Jorge Sanjuan
<jorge.sanjuan@codethink.co.uk> wrote:
> This adds support for the MIXER UNIT in UAC3. All the information
> is obtained from the (HIGH CAPABILITY) Cluster's header. We don't
> read the rest of the logical cluster to obtain the channel config
> as that wont make any difference in the current mixer behaviour.
>
> The name of the mixer unit is not yet requested as there is not
> support for the UAC3 Class Specific String requests.
>
> Tested in an UAC3 device working as a HEADSET with a basic mixer
> unit (same as the one in the BADD spec) with no controls.

I tested this patch in a similar use-case (with a simple mixer unit),
but _with_ controls and along with patch [1] from this series, which
added parsing input terminal's channels.
So everything works fine, I see all needed requests handling and
mixer unit creation on ALSA side, which I can use now.

So, as a bottom line:
Reviewed-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Tested-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-May/136030.html

>
> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
> ---
>  include/uapi/linux/usb/audio.h | 19 +++++++--
>  sound/usb/mixer.c              | 88 ++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 97 insertions(+), 10 deletions(-)
>
> diff --git a/include/uapi/linux/usb/audio.h b/include/uapi/linux/usb/audio.h
> index 3a78e7145689..13d98e6e0db1 100644
> --- a/include/uapi/linux/usb/audio.h
> +++ b/include/uapi/linux/usb/audio.h
> @@ -285,9 +285,22 @@ static inline __u8 uac_mixer_unit_iChannelNames(struct uac_mixer_unit_descriptor
>  static inline __u8 *uac_mixer_unit_bmControls(struct uac_mixer_unit_descriptor *desc,
>                                               int protocol)
>  {
> -       return (protocol == UAC_VERSION_1) ?
> -               &desc->baSourceID[desc->bNrInPins + 4] :
> -               &desc->baSourceID[desc->bNrInPins + 6];
> +       switch (protocol) {
> +       case UAC_VERSION_1:
> +               return &desc->baSourceID[desc->bNrInPins + 4];
> +       case UAC_VERSION_2:
> +               return &desc->baSourceID[desc->bNrInPins + 6];
> +       case UAC_VERSION_3:
> +               return &desc->baSourceID[desc->bNrInPins + 2];
> +       default:
> +               return NULL;
> +       }
> +}
> +
> +static inline __u16 uac3_mixer_unit_wClusterDescrID(struct uac_mixer_unit_descriptor *desc)
> +{
> +       return (desc->baSourceID[desc->bNrInPins + 1] << 8) |
> +               desc->baSourceID[desc->bNrInPins];
>  }
>
>  static inline __u8 uac_mixer_unit_iMixer(struct uac_mixer_unit_descriptor *desc)
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 76417943ff85..129c1397f0cb 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -719,6 +719,66 @@ static int get_term_name(struct snd_usb_audio *chip, struct usb_audio_term *iter
>  }
>
>  /*
> + * Get logical cluster information for UAC3 devices.
> + */
> +static int get_cluster_channels_v3(struct mixer_build *state, unsigned int cluster_id)
> +{
> +       struct uac3_cluster_header_descriptor c_header;
> +       int err;
> +
> +       err = snd_usb_ctl_msg(state->chip->dev,
> +                       usb_rcvctrlpipe(state->chip->dev, 0),
> +                       UAC3_CS_REQ_HIGH_CAPABILITY_DESCRIPTOR,
> +                       USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
> +                       cluster_id,
> +                       snd_usb_ctrl_intf(state->chip),
> +                       &c_header, sizeof(c_header));
> +       if (err < 0)
> +               goto error;
> +       if (err != sizeof(c_header)) {
> +               err = -EIO;
> +               goto error;
> +       }
> +
> +       return c_header.bNrChannels;
> +
> +error:
> +       usb_audio_err(state->chip, "cannot request logical cluster ID: %d (err: %d)\n", cluster_id, err);
> +       return err;
> +}
> +
> +/*
> + * Get number of channels for a Mixer Unit.
> + */
> +static int uac_mixer_unit_get_channels(struct mixer_build *state,
> +                                      struct uac_mixer_unit_descriptor *desc)
> +{
> +       int mu_channels;
> +
> +       if (desc->bLength < 11)
> +               return -EINVAL;
> +       if (!desc->bNrInPins)
> +               return -EINVAL;
> +
> +       switch (state->mixer->protocol) {
> +       case UAC_VERSION_1:
> +       case UAC_VERSION_2:
> +       default:
> +               mu_channels = uac_mixer_unit_bNrChannels(desc);
> +               break;
> +       case UAC_VERSION_3:
> +               mu_channels = get_cluster_channels_v3(state,
> +                               uac3_mixer_unit_wClusterDescrID(desc));
> +               break;
> +       }
> +
> +       if (!mu_channels)
> +               return -EINVAL;
> +
> +       return mu_channels;
> +}
> +
> +/*
>   * parse the source unit recursively until it reaches to a terminal
>   * or a branched unit.
>   */
> @@ -865,6 +925,18 @@ static int check_input_term(struct mixer_build *state, int id,
>                                 term->name = le16_to_cpu(d->wClockSourceStr);
>                                 return 0;
>                         }
> +                       case UAC3_MIXER_UNIT: {
> +                               struct uac_mixer_unit_descriptor *d = p1;
> +
> +                               err = uac_mixer_unit_get_channels(state, d);
> +                               if (err < 0)
> +                                       return err;
> +
> +                               term->channels = err;
> +                               term->type = d->bDescriptorSubtype << 16; /* virtual type */
> +
> +                               return 0;
> +                       }
>                         default:
>                                 return -ENODEV;
>                         }
> @@ -1798,11 +1870,10 @@ static int parse_audio_feature_unit(struct mixer_build *state, int unitid,
>   */
>  static void build_mixer_unit_ctl(struct mixer_build *state,
>                                  struct uac_mixer_unit_descriptor *desc,
> -                                int in_pin, int in_ch, int unitid,
> -                                struct usb_audio_term *iterm)
> +                                int in_pin, int in_ch, int num_outs,
> +                                int unitid, struct usb_audio_term *iterm)
>  {
>         struct usb_mixer_elem_info *cval;
> -       unsigned int num_outs = uac_mixer_unit_bNrChannels(desc);
>         unsigned int i, len;
>         struct snd_kcontrol *kctl;
>         const struct usbmix_name_map *map;
> @@ -1879,14 +1950,17 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
>         int input_pins, num_ins, num_outs;
>         int pin, ich, err;
>
> -       if (desc->bLength < 11 || !(input_pins = desc->bNrInPins) ||
> -           !(num_outs = uac_mixer_unit_bNrChannels(desc))) {
> +       err = uac_mixer_unit_get_channels(state, desc);
> +       if (err < 0) {
>                 usb_audio_err(state->chip,
>                               "invalid MIXER UNIT descriptor %d\n",
>                               unitid);
> -               return -EINVAL;
> +               return err;
>         }
>
> +       num_outs = err;
> +       input_pins = desc->bNrInPins;
> +
>         num_ins = 0;
>         ich = 0;
>         for (pin = 0; pin < input_pins; pin++) {
> @@ -1913,7 +1987,7 @@ static int parse_audio_mixer_unit(struct mixer_build *state, int unitid,
>                                 }
>                         }
>                         if (ich_has_controls)
> -                               build_mixer_unit_ctl(state, desc, pin, ich,
> +                               build_mixer_unit_ctl(state, desc, pin, ich, num_outs,
>                                                      unitid, &iterm);
>                 }
>         }
> --
> 2.11.0
>



-- 
Best regards,
Ruslan Bilovol
