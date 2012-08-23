From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v3 2/2] [ALSA] hda - suspend
	the	controller	only if all codecs support stop-clk in D3
Date: Thu, 23 Aug 2012 06:25:49 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F81BC58B@SHSMSX101.ccr.corp.intel.com>
References: <1345632404-5629-1-git-send-email-mengdong.lin@intel.com>
 <s5h1uiz15qv.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F81B8301@SHSMSX101.ccr.corp.intel.com>
 <s5hd32jymxc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 720A5264F0B
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 08:25:54 +0200 (CEST)
In-Reply-To: <s5hd32jymxc.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi Iwai
> 
> Thinking on it again, maybe a cleaner option would be something like:
> 
> 
> static void azx_power_notify(struct hda_bus *bus) {
> 	struct azx *chip = bus->private_data;
> 
> 	if (bus->power_keep_link_on || !codec->d3_stop_clk_ok)
> 		return;
> 
> 	if (codec->power_on)
> 		pm_runtime_get_sync(&chip->pci->dev);
> 	else
>  		pm_runtime_put_sync(&chip->pci->dev);
> }
> 
> Then in call azx_init_chip() and azx_stop_chip() in the runtime PM.
> (In the power-down case, it should check power_save_controller there.
>  Eventually we can deprecate this option later.)

This would be much cleaner and can avoid race among multiple codecs. I'll update code as you suggested and merge the two patches into one.
And I support deprecate power_save_controller, because it seems a duplicate of runtime PM on/off control.


> The azx_init_chip() and azx_stop_chip() calls were needed in
> azx_power_notify() because the PM resume didn't kick off the initialization
> immediately in the earlier version, but left uninitialized until the power-ON
> via power-save is triggered.
> 
> This was changed because of some ugly bugs (e.g. inconsistent mute LED).
> Now the hardware is always initialized after PM resume.
> Thus, for powersave case, chip init/stop can be simply put in the runtime PM
> side, as far as I see.

Thanks for sharing the code history.
Mengdong
