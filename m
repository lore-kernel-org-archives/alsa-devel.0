From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - using POS_FIX_LPIB on
 Broadwell HDMI Audio
Date: Tue, 13 May 2014 09:00:56 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B415DFC@SHSMSX101.ccr.corp.intel.com>
References: <1399485804-75028-1-git-send-email-libin.yang@intel.com>
 <s5hzjisq2kj.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D195232A6@SHSMSX103.ccr.corp.intel.com>
 <s5htx90q0mi.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19523313@SHSMSX103.ccr.corp.intel.com>
 <s5hr444pzap.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D1952333A@SHSMSX103.ccr.corp.intel.com>
 <s5hoaz8pydg.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D195233B1@SHSMSX103.ccr.corp.intel.com>
 <536BAB70.3010905@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B40F3CB@SHSMSX101.ccr.corp.intel.com>
 <s5h1tw3qmmt.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F82B4142B7@SHSMSX101.ccr.corp.intel.com>
 <s5htx8vo0tf.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F82B41454C@SHSMSX101.ccr.corp.intel.com>
 <s5hd2fjnx3v.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F82B41573D@SHSMSX101.ccr.corp.intel.com>
 <s5hwqdqqh6h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F1262265452
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 11:01:14 +0200 (CEST)
In-Reply-To: <s5hwqdqqh6h.wl%tiwai@suse.de>
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
Cc: "Yang, Libin" <libin.yang@intel.com>, "anssi.hannula@iki.fi" <anssi.hannula@iki.fi>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, May 13, 2014 3:20 PM

> It can be just simple like the patch below.  This is rather a tentative
> workaround.  If the hardware (or the corresponding part in the graphics driver)
> is fixed, we can get rid of it easily.  So, just keep the change as small and
> simple as possible.
> 
> 
> Takashi
> 
> ---
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c index
> b540ad71eb0d..2c54629d62d1 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1367,6 +1367,12 @@ static int azx_first_init(struct azx *chip)
>  	/* initialize streams */
>  	azx_init_stream(chip);
> 
> +	/* workaround for Broadwell HDMI: the first stream is broken,
> +	 * so mask it by keeping it as if opened
> +	 */
> +	if (pci->vendor == 0x8086 && pci->device == 0x160c)
> +		chip->azx_dev[0].opened = 1;
> +
>  	/* initialize chip */
>  	azx_init_pci(chip);
>  	azx_init_chip(chip, (probe_only[dev] & 2) == 0);


Hi Takashi,

I revised the patch as you suggested. Hope we'll have a better solution for Broadwell soon.

Thanks
Mengdong
