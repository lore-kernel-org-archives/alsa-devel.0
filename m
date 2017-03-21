From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: Re: [PATCH] ALSA: x86: Remove CONFIG_SND_X86 as
	unnecessary
Date: Tue, 21 Mar 2017 17:24:13 +1100
Message-ID: <CAFXWsS-Cis6L4AkWNrvxrj6x=X96CgaiTcDcwbsHqdD_m=_Skw@mail.gmail.com>
References: <CAFXWsS_uOqZa0p2vn0QiF-Hn945LTp9wtmx6z7--uOcDiLzQOw@mail.gmail.com>
 <s5hlgrzjiqb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DA28267000
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 07:24:13 +0100 (CET)
Received: by mail-wr0-f193.google.com with SMTP id u108so21081256wrb.2
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 23:24:13 -0700 (PDT)
In-Reply-To: <s5hlgrzjiqb.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 21 March 2017 at 16:34, Takashi Iwai <tiwai@suse.de> wrote:

> On Tue, 21 Mar 2017 06:28:07 +0100,
> Ian W MORRISON wrote:
> >
> > Create a specific menu for the CONFIG_HDMI_LPE_AUDIO setting.
> > Add additional narrative to further explain the function of the
> > CONFIG_HDMI_LPE_AUDIO setting.
> > Remove subsequently unnecessary CONFIG_SND_X86 setting.
> >
> > Signed-off-by: Ian W Morrison <linuxium@linuxium.com.au>
> > ---
> >  sound/x86/Kconfig | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> >
> > diff --git a/sound/x86/Kconfig b/sound/x86/Kconfig
> > index 84c8f8fc..a89d769 100644
> > --- a/sound/x86/Kconfig
> > +++ b/sound/x86/Kconfig
> > @@ -1,10 +1,5 @@
> > -menuconfig SND_X86
> > -       tristate "X86 sound devices"
> > -       depends on X86
> > -       ---help---
> > -         X86 sound devices that don't fall under SoC or PCI categories
> > -
> > -if SND_X86
> > +menu "HDMI LPE for SoC audio support"
> > +       comment "Required for HDMI audio support on Intel Baytrail and
> > Cherrytrail"
>
> No...  This is doubly wrong.  First off, the section isn't only about
> LPE audio, but it filters about x86-specific sound devices.  Second,
> by your change, it misses the dependency on X86.
>
>
Unfortunately I was trying to simplify things. I reviewed the original
David Henningsson (Canonical) code (see  https://github.com/01org/
baytrailaudio/blob/4014095b2a8fe60cd081bfcb0b6b0ecdcb36d1d5/hdmi_audio_
20150319.patch) which is why I lost the X86 dependency. There was never a
filter for x86-specific sound devices before so I assumed it could be
removed as I thought it was created specifically for the HDMI LPE audio
driver and was only adding complexity. As the only door I haven't tried so
far is the one marked 'exit' I'm off there now. This patch can die quietly
as what I was trying to do appears fundamentally unacceptable.


> I wonder whether the tristate of CONFIG_SND_X86 makes something bad
> for Canonical's build.  Try to change to bool like below.  Does it
> improve the situation?
>
>
> Takashi
>
> -- 8< --
> diff --git a/sound/x86/Kconfig b/sound/x86/Kconfig
> index 84c8f8fc597c..707a8bd1725d 100644
> --- a/sound/x86/Kconfig
> +++ b/sound/x86/Kconfig
> @@ -1,5 +1,5 @@
>  menuconfig SND_X86
> -       tristate "X86 sound devices"
> +       bool "X86 sound devices"
>         depends on X86
>         ---help---
>           X86 sound devices that don't fall under SoC or PCI categories
>
