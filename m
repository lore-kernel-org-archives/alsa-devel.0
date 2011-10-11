From: suresh gupta <sureshgupta189@gmail.com>
Subject: Re: LSI HDA Modem is not working on HP new Laptop
 which has IDT 7605 HDA codec and REDHAT installed on it with ALSA ver
 1.0.24.
Date: Tue, 11 Oct 2011 14:49:00 +0530
Message-ID: <CAJTbaX1MiYmFMkORCnbYyDfXC6aEsU8eivsy62Npk_-sLjxonw@mail.gmail.com>
References: <B2FD678A64EAAD45B089B123FDFC3ED70166618A4C@inbmail01.lsi.com>
	<s5hipobc1it.wl%tiwai@suse.de>
	<B2FD678A64EAAD45B089B123FDFC3ED70166618A6E@inbmail01.lsi.com>
	<s5h8vp7by4m.wl%tiwai@suse.de> <s5h62kbbx1g.wl%tiwai@suse.de>
	<CAJTbaX3OiLNcL2hwJOROK4jLeLhAJKJE-zO5t=VYcP4sP03oUA@mail.gmail.com>
	<s5hy5x7ag8l.wl%tiwai@suse.de> <s5hpqiabk8w.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id EFD2624332
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 11:19:21 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so8808652bkb.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2011 02:19:20 -0700 (PDT)
In-Reply-To: <s5hpqiabk8w.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Gupta, Suresh" <Suresh.Gupta@lsi.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Our modem works with this fix, so I try to understand it and found that, the
only difference is now "azx_assign_device" function assign stream from last
position and assign last one.  This is the reason why our modem works with
this fix as our modem try to get stream from first position and get first
one.

Do you really want this to do and what the significance of acquiring stream
from last position?

However from your previous explanation about new logic, I fixed the issue by
making change in our modem code.
Thanks for your support and help.
SuresH

On Thu, Oct 6, 2011 at 1:54 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 29 Sep 2011 10:46:02 +0200,
> Takashi Iwai wrote:
> >
> > At Thu, 29 Sep 2011 14:01:40 +0530,
> > suresh gupta wrote:
> > >
> > > Sorry for delay, I was out for Lunch.
> > >
> > > I believe we are in sink now, I seen the purity_inactive_streams part
> of
> > > code and found this is totally new logic in 1.0.24 ver. Can you please
> > > answer some question for my proper understanding?
> > >
> > > 1. Why this marking stream dirty come into picture and why ALSA code do
> not
> > > directly clear the AC_VERB_SET_CHANNEL_STREAMID while closing?
> >
> > For keeping the same stream tag for the same device.
> > A device is often shortly closed and reopened.  It'd be better to keep
> > the same stream tag for such a case.
>
> While reading the code again, it seems that the code in hda_intel.c
> doesn't do perfectly for some stream setups.  For example, it blindly
> relies on pcm->device number, so playback and capture streams won't be
> distinguished, and the first taker will win always.
>
> I fixed it now with the patch below.
>
>
> Takashi
>
> ===
> From: Takashi Iwai <tiwai@suse.de>
> Subject: ALSA: hda - Distinguish each substream for better sticky
> assignment
>
> The commit ef18beded8ddbaafdf4914bab209f77e60ae3a18 introduced a
> mechanism to assign the previously used slot for the next reopen of a
> PCM stream.  But the PCM device number isn't always unique (it may
> have multiple substreams), and also the code doesn't check the stream
> direction, thus both playback and capture streams share the same
> device number.
>
> For avoiding this conflict, make a unique key for each substream and
> store/check this value at reopening.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_intel.c |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 8a5dc57..90713f0 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -381,7 +381,7 @@ struct azx_dev {
>                                         */
>        unsigned char stream_tag;       /* assigned stream */
>        unsigned char index;            /* stream index */
> -       int device;                     /* last device number assigned to
> */
> +       int assigned_key;               /* last device# key assigned to */
>
>        unsigned int opened :1;
>        unsigned int running :1;
> @@ -1613,6 +1613,9 @@ azx_assign_device(struct azx *chip, struct
> snd_pcm_substream *substream)
>  {
>        int dev, i, nums;
>        struct azx_dev *res = NULL;
> +       /* make a non-zero unique key for the substream */
> +       int key = (substream->pcm->device << 16) | (substream->number << 2)
> |
> +               (substream->stream + 1);
>
>        if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>                dev = chip->playback_index_offset;
> @@ -1624,12 +1627,12 @@ azx_assign_device(struct azx *chip, struct
> snd_pcm_substream *substream)
>        for (i = 0; i < nums; i++, dev++)
>                if (!chip->azx_dev[dev].opened) {
>                        res = &chip->azx_dev[dev];
> -                       if (res->device == substream->pcm->device)
> +                       if (res->assigned_key == key)
>                                break;
>                }
>        if (res) {
>                res->opened = 1;
> -               res->device = substream->pcm->device;
> +               res->assigned_key = key;
>        }
>        return res;
>  }
> --
> 1.7.7
>
>
