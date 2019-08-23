From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: sof/hda rework to share more of patch_hdmi.c logic
Date: Fri, 23 Aug 2019 18:55:05 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1908231831310.16459@zeliteleevi>
References: <alpine.DEB.2.21.1908151641110.16459@zeliteleevi>
 <s5hr25ma3xs.wl-tiwai@suse.de>
 <alpine.DEB.2.21.1908231652000.16459@zeliteleevi>
 <s5h5zmoq6cy.wl-tiwai@suse.de> <s5h36hrrk1j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 281F3F8014A
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 17:55:09 +0200 (CEST)
In-Reply-To: <s5h36hrrk1j.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hey,


On Fri, 23 Aug 2019, Takashi Iwai wrote:
> On Fri, 23 Aug 2019, Takashi Iwai wrote:
> > The current patch_hdmi.c implementation is based on the theoretical
> > possibility, and limitation to the reduced PCM streams would work, I
> > suppose.
[...]
> access to the fixed PCM device (e.g. hw:1,1).  But, it's hardly
> possible to get more than three audio-monitors active in the real
> scenario, we've almost never seen this necessity.

ack. This does feel very unlikely to be a problem. And one could implement 
a wait list -> delay PCM attach if all audio converters are taken when the 
new monitor ELD update happens. Upon next disconnect of an already 
attached audio enabled monitor, one could check the wait list and hook up 
monitors to the freed converters. But yeah, at least on i915 I don't see 
the need for this.

This does raise the question whether we should change the behaviour 
for the non-DSP HD driver as well...? Tempting, but the risk for breaking 
apps may be too high.

> The actual behavior can be found in the description of commit
> a76056f2e57e:
> 
>     When monitor is connected, find a proper PCM for the monitor.
>     When monitor is disconnected, unbind the PCM from the pin.
>     
>     The binding policy (use Intel platform as example) is:
>     1. Try to use the legacy pin-pcm mapping for the device entry 0
>        of the pin.
>     2. If step 1 fails, try to bind pin to the backup PCMs. For example,
>        on Intel platform, if DP MST is enabled, 5 PCMs will be created.
>        PCM 3, PCM 7, PCM 8 are supposed to be used by device entry 0 of
>        pin 5, pin 6 and pin 7. PCM 9 and PCM 10 are the backup PCMs.
>     3. If step 2 fails, try to find any PCM to bind to the pin.
>     
> Removing the backup streams means the removal of step 2, but the
> driver will keep working in step 3.

Yes, I didn't have to actually change this code at all. I just limit the 
PCM count to number of converters, and the above code works without 
modifications (and skips (2)). Only problem left is how to change to 
toggle the different rules for calculing pcm count. Unless we change the 
behaviour for non-DSP HD driver as well, there needs to be some dynamic 
configuration of patch_hdmi. Kconfig/module-param won't do, I assume 
distros want to enable both options with same kernel.

Thanks for the quick response!

Br, Kai
