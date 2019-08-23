From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: sof/hda rework to share more of patch_hdmi.c logic
Date: Fri, 23 Aug 2019 17:29:40 +0300 (EEST)
Message-ID: <alpine.DEB.2.21.1908231652000.16459@zeliteleevi>
References: <alpine.DEB.2.21.1908151641110.16459@zeliteleevi>
 <s5hr25ma3xs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF606F80147
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 16:29:45 +0200 (CEST)
In-Reply-To: <s5hr25ma3xs.wl-tiwai@suse.de>
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

Hi,

On Thu, 15 Aug 2019, Takashi Iwai wrote:
> Kai Vehmanen wrote:
>> into modifying the SOF Intel backend to use 
>> snd-hda-codec-hdmi/patch_hdmi.c for HDMI/DP audio support, i.e. to be able 
>> to share this code between snd-hda-intel and SOF Intel (and not using 
>> hdac-hdmi).
[..]
>> This will change how HDMI is exposed to user-space with SOF Intel 
>> drivers, so we need to be extra careful how this is introduced. But 

> Agreed.  I guess the biggest difference is the handling of the 
> DP-MST.  The legacy HD-audio HDMI driver takes a different approach
> for DP-MST, namely, it chooses dynamically the pin that is connected
> with a monitor.  It's for keeping the compatibility (more or less)
> with old behavior; the program just needs to open the device that
> corresponds to the notification via jack ctl without fiddling with
> other extra routing.

indeed. I've now got to a point where I have the key functionality
in place. And after some reworks, the changes to patch_hdmi.c 
are pretty minimal, which is very nice (I started with a much more 
evasive patch).

But, but. The DP-MST handling is indeed iffy. I tried a few approaches, 
but it is hard to reconcile concept of "backup PCMs" of patch_hdmi.c with 
concepts of ASoC and ALSA topology, where the PCM and DAIs are supposed to 
be defined in the topology file. This gets worse with SOF (and any similar 
usage) which allow you to have arbitrary DSP processing between a PCM and 
the HDMI/DP DAIs. So this seems like a dead-end.

What I ended up doing was to make a new mode to patch_hdmi.c that limits 
PCM count to actual converter count (and this is aligned with topology), 
and still supporting DP-MST by always mapping monitors to a free PCM. I've 
tested some complex DP-MST scenarios and this seems to work pretty well. 
The jack detection will still be able to tell which of the PCMs have a 
monitor detected.

I wonder if this would be an acceptable approach, given 
the reuse benefits we get. Downsides:
- assignment of monitors to PCMs will depend on ELD update ordering
- in SOF we need to align PCM numbering scheme in all topologies 
  we convert over to patch_hdmi.c

I did not yet figure out how to toggle the new DP-MST mode in patch_hdmi.c 
in a nice way, so didn't sent patches to list yet. I'll do that early next 
week. If you want a sneak preview, I uploaded the series at:

https://github.com/thesofproject/linux/pull/1155

Br, Kai
