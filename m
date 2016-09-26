From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH 0/3] support DP MST audio
Date: Mon, 26 Sep 2016 16:07:51 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D194FA2EDC7@SHSMSX103.ccr.corp.intel.com>
References: <1474878938-10260-1-git-send-email-libin.yang@linux.intel.com>
 <s5hlgyebssi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (unknown [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CF8426673A
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 18:08:17 +0200 (CEST)
In-Reply-To: <s5hlgyebssi.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, September 26, 2016 11:11 PM
> To: libin.yang@linux.intel.com
> Cc: alsa-devel@alsa-project.org; Lin, Mengdong <mengdong.lin@intel.com>;
> Yang, Libin <libin.yang@intel.com>
> Subject: Re: [alsa-devel] [RFC PATCH 0/3] support DP MST audio
> 
> On Mon, 26 Sep 2016 10:35:35 +0200,
> libin.yang@linux.intel.com wrote:
> >
> > From: Libin Yang <libin.yang@linux.intel.com>
> >
> > This patchset starts to support DP MST audio.
> >
> > This patchset is based on drm-intel-nightly on
> > git://anongit.freedesktop.org/drm-intel
> >
> > Libin Yang (3):
> >   ALSA: hda - codec add DP MST support for connection list
> >   ALSA: hda - add DP mst verb support
> >   ALSA: hda - add DP mst audio support
> 
> I read the patchset again, and I'm still not convinced enough by this change.

Yes and I'm sorry that this patchset is delayed for a long time. 
Our gfx driver has been redesigned and some APIs have been changed.
The change is done in Pandiyan, Dhinakaran's patches:
Patchset: Prep. for DP audio MST support
  drm/i915: Standardize port type for DVO encoders
  drm/i915: Store port enum in intel_encoder
  drm/i915: Switch to using port stored in intel_encoder
  drm/i915: Move audio_connector to intel_encoder
  drm/i915: start adding dp mst audio
Patch: drm/i915/dp: DP audio API changes for MST

> 
> The connection list is coded in the current way under the assumption that
> connections are more or less static.  The connections are cached in snd_array,
> which is only for growing up, and not suitable for the entries that might be
> frequently removed.  The removal is done only at overriding, and it happens
> only once at boot.
> 
> OTOH, with DP-MST case, the connection list is basically dynamic.  It may
> increase or decrease depending on the connected monitors...  Is my
> understanding correct?  Or is the DP-MST connection list is static, too?  Then I
> do wonder how it covers the whole connections with arbitrary device indices.

For the connection list, the driver will setup all the connection list at the beginning
for each device entry, even it is non-MST. We statically allocate the connection
list and will never remove them.

> 
> So, the connection cache management is one thing.  Another thing is that the
> patchset doesn't consider about the pin ELD notification.
> Basically we switched to ELD notification instead of the pin unsol event for
> Intel chips.  How does it fit?

For the ELD notification, in the patch 0003, if there is monitor hotplug,
gfx driver will notify audio driver with acomp. Gfx driver will tell which
port (pin), pipe (device entry) occurs the hotplug event. And then audio
driver will call snd_hdac_acomp_get_eld() to get the eld information.

Regards,
Libin

> 
> 
> thanks,
> 
> Takashi
