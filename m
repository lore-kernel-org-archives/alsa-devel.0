From: Lukas Wunner <lukas@wunner.de>
Subject: linux-next: merge conflict between drm-misc and sound
	trees
Date: Wed, 14 Mar 2018 07:38:01 +0100
Message-ID: <20180314063801.GA26553@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net
 [83.223.95.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 152322672C0
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 07:38:02 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Sean Paul <seanpaul@chromium.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Gustavo Padovan <gustavo@padovan.org>, Dave Airlie <airlied@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Dear Stephen,

when rebuilding linux-next you're going to see a merge conflict in:

  sound/pci/hda/hda_intel.c

betwen commit:

  1ba8f9d30817 ("ALSA: hda: Add a power_save blacklist")

from the sound tree and commit:

  07f4f97d7b4b ("vga_switcheroo: Use device link for HDA controller")

from the drm-misc tree.

I recommend fixing it up like below.


-- >8 --
@@@ -2284,16 -2298,22 +2303,30 @@@
  	chip->running = 1;
  	azx_add_card_list(chip);
  
 +	/*
 +	 * The discrete GPU cannot power down unless the HDA controller runtime
 +	 * suspends, so activate runtime PM on codecs even if power_save == 0.
 +	 */
 +	if (use_vga_switcheroo(hda))
 +		list_for_each_codec(codec, &chip->bus)
 +			codec->auto_runtime_pm = 1;
 +
- 	snd_hda_set_power_save(&chip->bus, power_save * 1000);
+ 	val = power_save;
+ #ifdef CONFIG_PM
+ 	if (val == -1) {
+ 		const struct snd_pci_quirk *q;
+ 
+ 		val = CONFIG_SND_HDA_POWER_SAVE_DEFAULT;
+ 		q = snd_pci_quirk_lookup(chip->pci, power_save_blacklist);
+ 		if (q && val) {
+ 			dev_info(chip->card->dev, "device %04x:%04x is on the power_save blacklist, forcing power_save to 0\n",
+ 				 q->subvendor, q->subdevice);
+ 			val = 0;
+ 		}
+ 	}
+ #endif /* CONFIG_PM */
+ 	snd_hda_set_power_save(&chip->bus, val * 1000);
 -	if (azx_has_pm_runtime(chip) || hda->use_vga_switcheroo)
 +	if (azx_has_pm_runtime(chip))
  		pm_runtime_put_autosuspend(&pci->dev);
  
  out_free:
