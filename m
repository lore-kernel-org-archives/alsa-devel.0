From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 10/11] ALSA: hda/ca0132 - Add ZxR 600 ohm
	gain control
Date: Mon, 1 Oct 2018 11:22:57 +0900
Message-ID: <e313237f-1f99-bf87-ebb9-8dffb7a96e46@sakamocchi.jp>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
 <1538276607-30234-11-git-send-email-conmanx360@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 77027267842
 for <alsa-devel@alsa-project.org>; Mon,  1 Oct 2018 04:23:02 +0200 (CEST)
Received: by mail-pg1-f196.google.com with SMTP id b129-v6so8292641pga.13
 for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2018 19:23:01 -0700 (PDT)
In-Reply-To: <1538276607-30234-11-git-send-email-conmanx360@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Connor McAdams <conmanx360@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Alastair Bridgewater <alastair.bridgewater@gmail.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 30 2018 12:03, Connor McAdams wrote:
> This patch adds a control for 600 ohm gain on the Sound Blaster ZxR.
> 
> Signed-off-by: Connor McAdams <conmanx360@gmail.com>
> ---
>   sound/pci/hda/patch_ca0132.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index f0781e4..90e6a96 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> ..
> @@ -6415,6 +6452,9 @@ static int ca0132_build_controls(struct hda_codec *codec)
>   		ae5_add_headphone_gain_enum(codec);
>   		ae5_add_sound_filter_enum(codec);
>   	}
> +
> +	if (spec->quirk == QUIRK_ZXR)
> +		zxr_add_headphone_gain_switch(codec);
>   #ifdef ENABLE_TUNING_CONTROLS
>   	add_tuning_ctls(codec);
>   #endif

Though error code can be returned in a call of snd_hda_ctl_add(), it's 
not handled correctly in 'ca0132_build_controls()'. At least, return
code in calls of below functions is better to be checked.

  - add_voicefx()
  - add_ca0132_alt_eq_presets()
  - ca0132_alt_add_svm_enum()
  - ca0132_alt_add_output_enum
  - ca0132_alt_add_input_enum
  - ca0132_alt_add_mic_boost_enum
  - ae5_add_headphone_gain_enum
  - ae5_add_sound_filter_enum
  - zxr_add_headphone_gain_switch

This is not a strong request and you can work for it after merging this
patchset. We have two weeks more till next merge window.


Regards

Takashi Sakamoto
