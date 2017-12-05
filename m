From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ALSA: pcm: prevent UAF in snd_pcm_info
Date: Tue, 5 Dec 2017 18:26:56 +0100
Message-ID: <20171205172656.GA5307@kroah.com>
References: <20171205171657.74392-1-ndesaulniers@google.com>
 <CAKwvOdmoDtJSsv-t-O4KuJoKCvGcmecBQX4bjh4G1mXP0iDTiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKwvOdmoDtJSsv-t-O4KuJoKCvGcmecBQX4bjh4G1mXP0iDTiA@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Kees Cook <keescook@chromium.org>, Robb Glasser <rglasser@google.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Markus Elfring <elfring@users.sourceforge.net>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Arvind Yadav <arvind.yadav.cs@gmail.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 05, 2017 at 09:19:32AM -0800, Nick Desaulniers wrote:
> + stable
> 
> On Tue, Dec 5, 2017 at 9:16 AM, Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > From: Robb Glasser <rglasser@google.com>
> >
> > When the device descriptor is closed, the `substream->runtime` pointer
> > is freed. But another thread may be in the ioctl handler, case
> > SNDRV_CTL_IOCTL_PCM_INFO. This case calls snd_pcm_info_user() which
> > calls snd_pcm_info() which accesses the now freed `substream->runtime`.
> >
> > Signed-off-by: Robb Glasser <rglasser@google.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  sound/core/pcm.c | 2 ++
> >  1 file changed, 2 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
