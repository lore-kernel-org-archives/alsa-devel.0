From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2] ALSA: hda - re-apply fixup when
 resuming haswell hdmi codec
Date: Tue, 7 May 2013 15:33:34 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8823E9C@SHSMSX102.ccr.corp.intel.com>
References: <1367944461-24456-1-git-send-email-mengdong.lin@intel.com>
 <s5hr4hj11em.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F8823C52@SHSMSX102.ccr.corp.intel.com>
 <s5h38ty27w4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C63DD265098
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2013 17:33:43 +0200 (CEST)
In-Reply-To: <s5h38ty27w4.wl%tiwai@suse.de>
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
> Sent: Tuesday, May 07, 2013 10:16 PM

> > These widgets need to be enabled before hda_set_power_state(codec,
> AC_PWRST_D0) programs these widgets to D0.
> > Otherwise, audio driver would program these disabled widgets to D0. The
> codec will not respond when audio driver tries to sync power state. And later
> verb execution will fail.
> 
> Hm, but this is needed only for the machines with PCI SSID 8086:2010,
> right?   If so, this will be never in market, and I wonder the
> importance of this fix.

> So, the question is -- in which situation do we need this fix at all?
> Isn't it needed for all Haswell, or only certain Haswell variants, or only certain
> setups?

This fixup is needed for all Intel Haswell test machines on our hand, including desktop, mobile and ultrabook machines. 
All of these machines has both HDMI and DP connectors and so we need to enable these widgets to use HDMI on the 2nd pin.
Without this fixup, we observed communication failure between controller and codec after a system suspend/resume.

The BIOS team told us they will no longer change BIOS for Haswell, and they expect the Linux audio driver to enable the widgets, just like Windows driver does.
Now we hope to have a BIOS specific fixup. 

Other OEM BIOS may enable the these widgets according to their machine design, or may not if they follow Intel BIOS. This need to be check case by case.

Thanks
Mengdong

> > In hda_call_codec_resume(), generic_hdmi_init() is called from
> codec->patch_ops.init, after setting power state to D0. It would be too late.
> > Is it okay to add a new ops like "pre_resume" to apply the fixup?
> 
> No.  Using the standard fixup doesn't look correct in this case.
> 
> 
> Takashi
