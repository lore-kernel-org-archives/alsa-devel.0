From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: HDMI hotplug on Skylake when power well is off
Date: Fri, 17 Jul 2015 16:44:29 +0530
Message-ID: <20150717111429.GP5086@localhost>
References: <55A62252.1050506@canonical.com> <s5hmvyxn0uh.wl-tiwai@suse.de>
 <20150716083908.GI5086@localhost> <55A77A8A.2080101@canonical.com>
 <s5hegk8l8lg.wl-tiwai@suse.de> <20150716113514.GL5086@localhost>
 <s5hy4igjns8.wl-tiwai@suse.de> <55A7B383.6020206@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F8EA2606E2
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 13:12:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <55A7B383.6020206@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, libin.yang@intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lin,
 Mengdong" <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 16, 2015 at 03:37:07PM +0200, David Henningsson wrote:
> +static void i915_audio_component_hotplug_notify(struct hdac_bus *bus,
> +	const struct i915_audio_hotplug_info *info)
> +{
> +	struct hda_codec *codec;
this should be hdac_device as core doesnt know hda_codec

> +
> +	codec_dbg("Received HDMI hotplug callback (connector = %s, plugged in = %d)",
> +		  info->connector_name, (int) info->plugged_in);
> +
> +	for (i = 0; i <= MAX_CODEC_ADDRESS; i++)
> +		if (bus->caddr_tbl[i] && bus->caddr_tbl[i]->hotplug_notify)
> +			bus->caddr_tbl[i]->hotplug_notify(bus->caddr_tbl[i], info);
> +}

Rest looks good :)

-- 
~Vinod
