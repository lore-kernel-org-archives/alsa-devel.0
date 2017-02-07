From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: x86: mark hdmi suspend/resume functions as
 __maybe_unused
Date: Tue, 7 Feb 2017 23:19:47 +0900
Message-ID: <14768fe7-9b3a-ed4d-0c15-6ddae07f6cba@sakamocchi.jp>
References: <20170207133918.1085873-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170207133918.1085873-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Feb 7 2016 22:38, Arnd Bergmann wrote:
> The two functions are unused when CONFIG_PM_SLEEP is disabled:
>
> sound/x86/intel_hdmi_audio.c:1633:12: error: 'hdmi_lpe_audio_resume' defined but not used [-Werror=unused-function]
> sound/x86/intel_hdmi_audio.c:1622:12: error: 'hdmi_lpe_audio_suspend' defined but not used [-Werror=unused-function]
>
> Marking them as __maybe_unused avoids the warning without introducing an
> ugly #ifdef.
>
> Fixes: 182cdf23dbf6 ("ALSA: x86: Implement runtime PM")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  sound/x86/intel_hdmi_audio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
> index 8978dc9bf579..0d19a4994bac 100644
> --- a/sound/x86/intel_hdmi_audio.c
> +++ b/sound/x86/intel_hdmi_audio.c
> @@ -1619,7 +1619,7 @@ static int hdmi_lpe_audio_runtime_suspend(struct device *dev)
>  	return 0;
>  }
>
> -static int hdmi_lpe_audio_suspend(struct device *dev)
> +static int __maybe_unused hdmi_lpe_audio_suspend(struct device *dev)
>  {
>  	struct snd_intelhad *ctx = dev_get_drvdata(dev);
>  	int err;
> @@ -1630,7 +1630,7 @@ static int hdmi_lpe_audio_suspend(struct device *dev)
>  	return err;
>  }
>
> -static int hdmi_lpe_audio_resume(struct device *dev)
> +static int __maybe_unused hdmi_lpe_audio_resume(struct device *dev)
>  {
>  	struct snd_intelhad *ctx = dev_get_drvdata(dev);

In this case, in this subsystem, we can see codes to pre-process the 
function calls to NULL and the function definition is omitted. This is a 
sample:
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/pci/hda/patch_sigmatel.c#n4427

Let us apply the same idea to this module?


Thanks

Takashi Sakamoto
