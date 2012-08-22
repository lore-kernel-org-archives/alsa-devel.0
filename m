From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v3 2/2] [ALSA] hda - suspend the
	controller	only if all codecs support stop-clk in D3
Date: Wed, 22 Aug 2012 14:58:19 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F81B8301@SHSMSX101.ccr.corp.intel.com>
References: <1345632404-5629-1-git-send-email-mengdong.lin@intel.com>
 <s5h1uiz15qv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AA68266135
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 16:58:25 +0200 (CEST)
In-Reply-To: <s5h1uiz15qv.wl%tiwai@suse.de>
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
> Sent: Wednesday, August 22, 2012 8:17 PM
> 
> You shouldn't move pm_runtime_get_noresume() / _put_no_idle() to
> hda_codec.c, but these should be called only in hda_intel.c.
> Basically there is no PCI-specific code in hda_codec.c and patch_*.c.
> All PCI controller code should be in hda_intel.c.

Okay. I'll move pm_runtime_get_noresume() / _put_no_idle() back to azx_probe_continue() and azx_remove().

> (snip)
> >  	else if (chip->running && power_save_controller &&
> > -		 !bus->power_keep_link_on) {
> > +		 !bus->power_keep_link_on)
> >  		azx_stop_chip(chip);
> >
> > -		/* TODO: Suspend controller only if all codec support
> > -		stop-clock in D3, for wakeup consideration */
> > +	if (!bus->power_keep_link_on
> > +		&& !codec->power_on && codec->d3_stop_clk_ok)
> >  		pm_runtime_put_sync(&chip->pci->dev);
> 
> Also it should check power_save_controller, too.

I'll add check on power_save_controller.

Thanks
Mengdong
