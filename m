From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ALSA: x86: Select CONFIG_HDMI_LPE_AUDIO as
 default
Date: Wed, 15 Mar 2017 08:54:40 -0500
Message-ID: <0c4dea52-f119-4fd5-7428-71250f6c0104@linux.intel.com>
References: <CAFXWsS8PkZ7pRLMqC7zABYS_CKxJ4=6TUGeGsvCYepMMjo+0qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 72FFE266861
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 14:54:43 +0100 (CET)
In-Reply-To: <CAFXWsS8PkZ7pRLMqC7zABYS_CKxJ4=6TUGeGsvCYepMMjo+0qg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ian W MORRISON <ianwmorrison@gmail.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 3/15/17 1:34 AM, Ian W MORRISON wrote:
> The upstream kernel builds for distributions such as Ubuntu which now
> includes binary packages for v4.11 mainline kernel release candidates
> are promoted as a way of testing upstream kernels to to confirm that
> upstream has fixed a specific issue (see
> https://wiki.ubuntu.com/Kernel/MainlineBuilds).
>
> Unfortunately the long awaited patch for providing HDMI audio support
> for Bay Trail and Cherry Trail devices does not include this support
> through a module built by default.
>
> By defining the default of the two associated CONFIG settings (SND_X86
> and HDMI_LPE_AUDIO) as a module, upstream kernel builds would
> automatically provide the much desired HDMI audio support by default.

I have mixed feelings about this. This would make the life of some 
distros easier but at the same time it's not needed by everyone, e.g. 
Chrome does not need this, the skews they use have the HDaudio output.

Likewise none of the SST-based machine drivers are selected by default, 
so distros already have to select what they want to support, and it's no 
big deal for them to select this option while they are at it.
I am not going to fight this patch but I feel it's a bit inconsistent 
with how other options are enabled. If it was really helpful to select 
modules by default then we should also select all the SST options. If 
it's not then nothing is selected by default.

>
> This patch uses a Kconfig 'default' statement to include the driver as
> default.
>
> Signed-off-by: Ian W Morrison <linuxium@linuxium.com.au
> <mailto:linuxium@linuxium.com.au>>
> ---
>  sound/x86/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/x86/Kconfig b/sound/x86/Kconfig
> index 84c8f8fc..439850c 100644
> --- a/sound/x86/Kconfig
> +++ b/sound/x86/Kconfig
> @@ -1,6 +1,7 @@
>  menuconfig SND_X86
>         tristate "X86 sound devices"
>         depends on X86
> +       default m
>         ---help---
>           X86 sound devices that don't fall under SoC or PCI categories
>
> @@ -9,6 +10,7 @@ if SND_X86
>  config HDMI_LPE_AUDIO
>         tristate "HDMI audio without HDaudio on Intel Atom platforms"
>         depends on DRM_I915
> +       default m
>         select SND_PCM
>         help
>          Choose this option to support HDMI LPE Audio mode
> --
> 1.9.1
