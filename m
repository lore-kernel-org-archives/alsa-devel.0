From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - add AZX_DCAPS_I915_POWERWELL
 to Baytrail
Date: Thu, 23 Apr 2015 03:01:34 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B83D2E8@SHSMSX101.ccr.corp.intel.com>
References: <e8074c2236ff5b224dbc8a92cca40f348ca5032c.1429592999.git.mengdong.lin@intel.com>
 <5536188B.0@canonical.com> <s5hr3rdzu9n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 95475265A30
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 05:01:44 +0200 (CEST)
In-Reply-To: <s5hr3rdzu9n.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> At Tue, 21 Apr 2015 11:29:47 +0200,
> David Henningsson wrote:
> >
> > Hi,
> >
> > Baytrail is very much released and out there already - should this
> > patch also go to stable?
> 
> I thought of that, but this patch also has a drawback, thus I hesitated to make
> it blindly.

Hi Takashi and David,

Without this patch, we observed communication dead on Baytrail between the HD-A controller and HDMI codec, with mainline kernel 4.0.
It's because the i915 driver can disable this power well without sync with audio driver. 
Please see bug https://bugzilla.kernel.org/show_bug.cgi?id=93881

This fix up is not so power saving and so we're trying improve it.

> > Are there current problems (like HDMI codec not being detected) that
> > are fixed by this patch?
> 
> If there is a known bug (report) and this fixes indeed, it deserves the stable
> kernel, indeed.

The issue that HDMI codec is not always being detected is only reported on Skylake (although theoretically it can happen on Baytrail/Braswell without power sync but we never observed this).
SKL HW implementation has some change from its predecessors and need extra fixing up in i915 driver, Libin is working on this and we're close to solve this.

Thanks
Mengdong
