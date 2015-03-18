From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 0/4] More aggressive PM for HD-audio
Date: Wed, 18 Mar 2015 20:34:34 +0100
Message-ID: <5509D34A.9070006@canonical.com>
References: <1426668658-15911-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 20EBA2605F1
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 20:34:37 +0100 (CET)
In-Reply-To: <1426668658-15911-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 2015-03-18 09:50, Takashi Iwai wrote:
> Hi,
>
> here is a patchset for supporting more aggressive PM for HD-audio.
> This allows to change the power state of each widget more dynamically
> with jack and stream states.  It's activated only when the codec
> driver (or via sysfs or f/w patch) sets codec->power_mgmt flag.

Cool. Could you elaborate on how the power_mgmt flag interacts with the 
power_save module parameter (which, on Ubuntu, is set dynamically based 
on AC power or not)? I e, does it make sense to test this both with and 
without power_save enabled?

Also I assume power_save_controller should not matter, right?

>
> In theory, this should work for the recent Realtek codecs, but
> currently I have no machine for test.
>
> David, could you or your team check whether this works for ALC282 or
> such?  Just add like:
>
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -5415,6 +5415,7 @@ static int patch_alc269(struct hda_codec *codec)
>   
>   	spec = codec->spec;
>   	spec->gen.shared_mic_vref_pin = 0x18;
> +	codec->power_mgmt = 1;
>   
>   	snd_hda_pick_fixup(codec, alc269_fixup_models,
>   		       alc269_fixup_tbl, alc269_fixups);
>
>
> The patchset is for for-next branch of sound git tree, but they might
> be applicable to 4.0-rc (or even older), too.  The current patches are
> found in topic/hda-power branch.
>
>
> thanks,
>
> Takashi
>
> ===
>
> Takashi Iwai (4):
>    ALSA: hda - Simplify PCM setup overrides
>    ALSA: hda - Support advanced power state controls
>    ALSA: hda - Use the new power control for VIA codecs
>    ALSA: hda - Adjust power of beep widget and outputs
>
>   sound/pci/hda/hda_beep.c       |  29 +-
>   sound/pci/hda/hda_beep.h       |   1 +
>   sound/pci/hda/hda_codec.c      |   4 +
>   sound/pci/hda/hda_codec.h      |   2 +
>   sound/pci/hda/hda_generic.c    | 480 ++++++++++++++++++++++++------
>   sound/pci/hda/hda_generic.h    |   5 +-
>   sound/pci/hda/patch_realtek.c  |  41 ---
>   sound/pci/hda/patch_sigmatel.c |   5 +
>   sound/pci/hda/patch_via.c      | 662 +----------------------------------------
>   9 files changed, 427 insertions(+), 802 deletions(-)
>
