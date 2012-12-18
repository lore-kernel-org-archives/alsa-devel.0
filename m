From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 1/1] ALSA: hda - bug fix for invalid
 connection list of more Haswell HDMI codec pins
Date: Tue, 18 Dec 2012 08:09:12 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82995C2@SHSMSX101.ccr.corp.intel.com>
References: <1355854914-13010-1-git-send-email-mengdong.lin@intel.com>
 <s5hip7zq1lq.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F829955B@SHSMSX101.ccr.corp.intel.com>
 <s5hd2y7pzuc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id DD361261604
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2012 09:09:18 +0100 (CET)
In-Reply-To: <s5hd2y7pzuc.wl%tiwai@suse.de>
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
> Sent: Tuesday, December 18, 2012 3:46 PM


> > Will OEM change the PCI (or codec) SSID so that this fixup will not be
> applied at all?
> >
> > In Haswell, there are two HD-A controllers: one for display codec and the
> other for legacy 3rd-party codec.
> > I'm not sure if OEM will change the PCI SSID of the display HD-A controller.
> 
> Of course, they'll change SSIDs.
> 

Thanks for your info, Takashi!
You're right. PCI spec allow these registers in configuration space to be changed.

So snd_hda_pick_fixup/snd_hda_apply_fixup is designed for fixing board or BIOS-specific issues, right?

I'll update the patch as you suggested.

Thanks
Mengdong
