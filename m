From: Naveen M <naveen.m@intel.com>
Subject: Re: [PATCH] ASoC: Intel: kbl_da7219_max98357a: Map
 BTN_0 to KEY_PLAYPAUSE
Date: Fri, 29 Jun 2018 11:29:12 +0530
Message-ID: <20180629055832.GA583@intel.com>
References: <1530166267-13731-1-git-send-email-mac.chiang@intel.com>
 <6b434f52-4992-7f09-3f41-4d9e05dfb02d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id DD0AB266E76
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 08:01:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <6b434f52-4992-7f09-3f41-4d9e05dfb02d@linux.intel.com>
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
Cc: mac.chiang@intel.com, broonie@kernel.org, bleung@chromium.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 28, 2018 at 10:46:58PM -0700, Pierre-Louis Bossart wrote:
> On 6/27/18 11:11 PM, mac.chiang@intel.com wrote:
> >From: Mac Chiang <mac.chiang@intel.com>
> >
> >On kbl_rt5663_max98927, commit 38a5882e4292
> >     ("ASoC: Intel: kbl_rt5663_max98927: Map BTN_0 to KEY_PLAYPAUSE")
> >     This key pair mapping to play/pause when playing Youtube
> >
> >The Android 3.5mm Headset jack specification mentions that BTN_0 should
> >be mapped to KEY_MEDIA, but this is less logical than KEY_PLAYPAUSE,
> >which has much broader userspace support.
> >
> >For example, the Chrome OS userspace now supports KEY_PLAYPAUSE to toggle
> >play/pause of videos and audio, but does not handle KEY_MEDIA.
> >
> >Furthermore, Android itself now supports KEY_PLAYPAUSE equivalently, as the
> >new USB headset spec requires KEY_PLAYPAUSE for BTN_0.
> >https://source.android.com/devices/accessories/headset/usb-headset-spec
> >
> >The same fix is required on Chrome kbl_da7219_max98357a.
> >
> >Signed-off-by: Mac Chiang <mac.chiang@intel.com>
> 
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> this is aligned with a recent patch for the same headset for an AMD
> platform. We'd need the same fix for the bxt_da7219 machine driver btw.
> Naveen, is this something you can look into? Thanks!
> 
> 
Agreed Pierre, earlier I have submitted a patch on this for bxt_da7219 - 
https://patchwork.kernel.org/patch/10335295/
Also I have updated the same for recently ack'd glk_rt5682_max machine.
> >---
> >  sound/soc/intel/boards/kbl_da7219_max98357a.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
> >index 7961f1f..edafe23 100644
> >--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
> >+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
> >@@ -188,7 +188,7 @@ static int kabylake_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
> >  	jack = &ctx->kabylake_headset;
> >-	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
> >+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> >  	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
> >  	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
> >  	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
> >
> 

-- 
