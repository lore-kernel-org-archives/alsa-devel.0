From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - Fix runtime PM accounting
Date: Thu, 30 Aug 2012 14:17:19 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F81DB7AA@SHSMSX101.ccr.corp.intel.com>
References: <s5hwr0l7msk.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F81DA4D0@SHSMSX101.ccr.corp.intel.com>
 <s5h7gsj6i6x.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F81DAFDF@SHSMSX101.ccr.corp.intel.com>
 <s5hr4qp6cus.wl%tiwai@suse.de> <s5hligx68xn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 67EEF265D7F
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2012 16:17:24 +0200 (CEST)
In-Reply-To: <s5hligx68xn.wl%tiwai@suse.de>
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
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, August 29, 2012 10:59 PM
> 
> The patch below is the revised version.  I think it's a good cleanup at the
> same time.  Basically it makes pm_notify callback simply turning up/down
> the controller power without checking extra flags there.  The conditions are
> checked in the caller side instead.
> 
> The pm_notify is called at codec creation and deletion times (but without
> checking extra flags), thus the refcounts can be managed more easily.
> 

Hi Takashi,

Usage of the new pm_notify() looks nice. The v3 patch works well on my platform. 

However, maybe we can add some check before notifying the codec power-down in snd_hda_codec_free().

static void snd_hda_codec_free(struct hda_codec *codec)
{
	...
	restore_init_pincfgs(codec); 
#ifdef CONFIG_SND_HDA_POWER_SAVE
	cancel_delayed_work(&codec->power_work);
	flush_workqueue(codec->bus->workq);
#endif
	...
	if (codec->patch_ops.free)
		codec->patch_ops.free(codec);
	module_put(codec->owner);
	hda_call_pm_notify(codec->bus, false);
	...
}

restore_init_pincfgs() will resume the codec to D0, and since the power_save timeout is at least 1second, so it's almost always safe to call hda_call_pm_notify(codec->bus, false) here.
But an extremely low possibility is: the codec will be suspended again and call hda_call_pm_notify(,false) in hda_power_work() before the work is cancelled and queue is flushed.
And the flag 'codec->d3_stop_clk_ok' also cannot tell us whether a pm_notify(, false) has already been called or not, because codec->patch_ops.free() may call hda_set_power_state (D3) unexpectedly.

So, I think that each codec still needs a flag 'power_count' and let the pm_notify modify the count:

static void azx_power_notify(struct hda_bus *bus, struct hda_codec *codec,  bool power_up)
{
	struct azx *chip = bus->private_data;

	if (power_up) {
		pm_runtime_get_sync(&chip->pci->dev);
		codec->power_count ++;
	}
	else {
		pm_runtime_put_sync(&chip->pci->dev);
		codec->power_count --;
	}
}

And 
static void snd_hda_codec_free(struct hda_codec *codec)
{
	...
+#ifdef CONFIG_SND_HDA_POWER_SAVE
+	If(codec-> power_count)
		hda_call_pm_notify(codec->bus, false);
+#endif
	...
}

Thanks
Mengdong
