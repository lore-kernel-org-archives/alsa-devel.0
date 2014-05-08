From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - using POS_FIX_LPIB on
 Broadwell HDMI Audio
Date: Thu, 08 May 2014 18:06:08 +0200
Message-ID: <536BAB70.3010905@canonical.com>
References: <1399485804-75028-1-git-send-email-libin.yang@intel.com>
 <s5hzjisq2kj.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D195232A6@SHSMSX103.ccr.corp.intel.com>
 <s5htx90q0mi.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19523313@SHSMSX103.ccr.corp.intel.com>
 <s5hr444pzap.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D1952333A@SHSMSX103.ccr.corp.intel.com>
 <s5hoaz8pydg.wl%tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D195233B1@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EF5526549A
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 18:06:13 +0200 (CEST)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D195233B1@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Yang, Libin" <libin.yang@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org



On 2014-05-08 09:58, Yang, Libin wrote:
> Hi Takashi,
>
> I tested the non-snoop mode. It's worse than snoop mode. Only noise can be heard if using non-snoop mode.
>
> I add the print in the function azx_position_ok(). The below is the dmesg:
> [  119.509631] <0>posbuf: 26368, lpib: 16320, wallclk: 2330325
> [  119.509674] snd_hda_intel 0000:00:03.0: IRQ timing workaround is activated for card #0. Suggest a bigger bdl_pos_adj.
> [  119.509683] <0>posbuf: 26368, lpib: 16332, wallclk: 2331659
> [  119.515467] <0>posbuf: 28224, lpib: 17444, wallclk: 2470504
> [  119.523460] <0>posbuf: 30592, lpib: 18976, wallclk: 2662403
> [  119.531431] <0>posbuf: 32128, lpib: 20508, wallclk: 2853751
> [  119.594932] snd_hda_intel 0000:00:03.0: Unstable LPIB (20416 >= 16384); disabling LPIB delay counting

This looks quite bad - is it not a hardware bug if LPIB > CBL (CBL 
should be 16384 in this case)?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
