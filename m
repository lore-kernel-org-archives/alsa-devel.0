From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: Re: [PATCH] ALSA: x86: Select CONFIG_HDMI_LPE_AUDIO as
	default
Date: Thu, 16 Mar 2017 02:28:10 +1100
Message-ID: <CAFXWsS8xSgQ_vMayspTNH8LhVPFDjR8crqmc7kt=XGeXnWmQ5g@mail.gmail.com>
References: <CAFXWsS8PkZ7pRLMqC7zABYS_CKxJ4=6TUGeGsvCYepMMjo+0qg@mail.gmail.com>
 <0c4dea52-f119-4fd5-7428-71250f6c0104@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 068BE266861
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 16:28:10 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id n11so5272684wma.0
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 08:28:10 -0700 (PDT)
In-Reply-To: <0c4dea52-f119-4fd5-7428-71250f6c0104@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 16 March 2017 at 00:54, Pierre-Louis Bossart <
pierre-louis.bossart@linux.intel.com> wrote:

> On 3/15/17 1:34 AM, Ian W MORRISON wrote:
>
>> The upstream kernel builds for distributions such as Ubuntu which now
>> includes binary packages for v4.11 mainline kernel release candidates
>> are promoted as a way of testing upstream kernels to to confirm that
>> upstream has fixed a specific issue (see
>> https://wiki.ubuntu.com/Kernel/MainlineBuilds).
>>
>> Unfortunately the long awaited patch for providing HDMI audio support
>> for Bay Trail and Cherry Trail devices does not include this support
>> through a module built by default.
>>
>> By defining the default of the two associated CONFIG settings (SND_X86
>> and HDMI_LPE_AUDIO) as a module, upstream kernel builds would
>> automatically provide the much desired HDMI audio support by default.
>>
>
> I have mixed feelings about this. This would make the life of some distros
> easier but at the same time it's not needed by everyone, e.g. Chrome does
> not need this, the skews they use have the HDaudio output.
>
> Likewise none of the SST-based machine drivers are selected by default, so
> distros already have to select what they want to support, and it's no big
> deal for them to select this option while they are at it.
> I am not going to fight this patch but I feel it's a bit inconsistent with
> how other options are enabled. If it was really helpful to select modules
> by default then we should also select all the SST options. If it's not then
> nothing is selected by default.
>
>
I did consider arguing that as 'HDMI', 'SND_SOC_HDMI_CODEC', 'DRM' and
'DRM_I915' are set presumably as video and audio are seen as a function of
the OS rather than only being enabled by a distro. So adding
'HDMI_LPE_AUDIO' was in keeping with concept of the OS providing core
functionality that a distro could disable it if required. But I thought
that might distract from the purpose of the patch and needlessly provoke
discussion!

I too looked at the current state which I found to be inconsistent. For
example a default config built currently sets
'SND_SOC_INTEL_BYT_RT5640_MACH=m' which in turn then sets
'SND_SOC_INTEL_BAYTRAIL=m' and 'SND_SOC_INTEL_SST=m' among others. Likewise
'PINCTRL_BAYTRAIL=y' is set whereas 'PINCTRL_CHERRYVIEW' isn't. Again I
didn't want to open a can of worms as I've not fully identified the extent
of the inconsistencies and again it might detract from the purpose of the
patch.

I concluded that it was better to provide audio over HDMI by default for
the simple reason that distros may not add it because they didn't see the
need or might even overlooked it and that they could always exclude it if
they had a reason. The primary goal being to make the provision of audio
for BYT and CHT devices as simple and as quick possible.


>
>> This patch uses a Kconfig 'default' statement to include the driver as
>> default.
>>
>> Signed-off-by: Ian W Morrison <linuxium@linuxium.com.au
>> <mailto:linuxium@linuxium.com.au>>
>> ---
>>  sound/x86/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/sound/x86/Kconfig b/sound/x86/Kconfig
>> index 84c8f8fc..439850c 100644
>> --- a/sound/x86/Kconfig
>> +++ b/sound/x86/Kconfig
>> @@ -1,6 +1,7 @@
>>  menuconfig SND_X86
>>         tristate "X86 sound devices"
>>         depends on X86
>> +       default m
>>         ---help---
>>           X86 sound devices that don't fall under SoC or PCI categories
>>
>> @@ -9,6 +10,7 @@ if SND_X86
>>  config HDMI_LPE_AUDIO
>>         tristate "HDMI audio without HDaudio on Intel Atom platforms"
>>         depends on DRM_I915
>> +       default m
>>         select SND_PCM
>>         help
>>          Choose this option to support HDMI LPE Audio mode
>> --
>> 1.9.1
>>
>
>
