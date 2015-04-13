From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - not use regmap for vendor verb
 0x781 of Intel HDMI codec
Date: Mon, 13 Apr 2015 13:29:47 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B826848@SHSMSX101.ccr.corp.intel.com>
References: <2f716e6b90b7416eb34d35ed1954c7761bfd2050.1428918546.git.mengdong.lin@intel.com>
 <s5hpp78p94w.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8763C26508C
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 15:29:53 +0200 (CEST)
In-Reply-To: <s5hpp78p94w.wl-tiwai@suse.de>
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
> Sent: Monday, April 13, 2015 7:21 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [PATCH] ALSA: hda - not use regmap for vendor verb 0x781 of Intel
> HDMI codec
> 
> At Mon, 13 Apr 2015 17:50:43 +0800,
> mengdong.lin@intel.com wrote:
> >
> > From: Mengdong Lin <mengdong.lin@intel.com>
> >
> > For HDMI codec on Haswell/Broadwell/Skylake platforms, the vendor verb
> > 0x781 is used enable DP 1.2 mode as a fixup if BIOS has not done this,
> > in function intel_haswell_fixup_enable_dp12(). Otherwise, the display
> > audio playback will be silent.
> >
> > Although the verb 0x781 is added to vendor verbs array, but
> > snd_hdac_regmap_
> > encode_verb() will translate it to verb 0xf81 and cause regmap_write
> > IO failure because 0xf81 is not in the vendor verb array and so will
> > not be taken as a writable register.
> >
> > So this patch no longer uses regmap for verb 0x781 but directly send
> > this command to enable DP1.2 mode.
> 
> What if just add INTEL_GET_VENDOR_VERB as a vendor verb?

Yes, it should work. hda_reg_write will drop the GET bit. 
I'll have a test tomorrow.

Thanks
Mengdong
