From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - using POS_FIX_LPIB on
 Broadwell HDMI Audio
Date: Fri, 9 May 2014 10:08:19 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B40F3CB@SHSMSX101.ccr.corp.intel.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 676692610CF
 for <alsa-devel@alsa-project.org>; Fri,  9 May 2014 12:09:25 +0200 (CEST)
In-Reply-To: <536BAB70.3010905@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>, "Yang, Libin" <libin.yang@intel.com>, Takashi Iwai <tiwai@suse.de>, "anssi.hannula@iki.fi" <anssi.hannula@iki.fi>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

We found the Broadwell HDMI audio regression is introduced by this patch:

commit dcb32ecd9a533f47ab652c5c5680bc50a7a822cd
Author: Anssi Hannula <anssi.hannula@iki.fi>
Date: Tue Apr 8 12:36:42 2014 +0300
ALSA: hda - Do not assign streams in reverse order

We'll further check the root cause.
Since this patch seems only affect the stream ID. Actually Intel GPU tool only find the stream ID is changed by this patch.

In addition, Haswell HDMI audio is not affected and works well. It seems there is HW behavior difference between HSW and BDW.

Thanks
Mengdong

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Friday, May 09, 2014 12:06 AM
> To: Yang, Libin; Takashi Iwai
> Cc: Lin, Mengdong; alsa-devel@alsa-project.org; Pierre-Louis Bossart
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - using POS_FIX_LPIB on Broadwell
> HDMI Audio
> 
> 
> 
> On 2014-05-08 09:58, Yang, Libin wrote:
> > Hi Takashi,
> >
> > I tested the non-snoop mode. It's worse than snoop mode. Only noise can be
> heard if using non-snoop mode.
> >
> > I add the print in the function azx_position_ok(). The below is the dmesg:
> > [  119.509631] <0>posbuf: 26368, lpib: 16320, wallclk: 2330325 [
> > 119.509674] snd_hda_intel 0000:00:03.0: IRQ timing workaround is
> activated for card #0. Suggest a bigger bdl_pos_adj.
> > [  119.509683] <0>posbuf: 26368, lpib: 16332, wallclk: 2331659 [
> > 119.515467] <0>posbuf: 28224, lpib: 17444, wallclk: 2470504 [
> > 119.523460] <0>posbuf: 30592, lpib: 18976, wallclk: 2662403 [
> > 119.531431] <0>posbuf: 32128, lpib: 20508, wallclk: 2853751 [
> > 119.594932] snd_hda_intel 0000:00:03.0: Unstable LPIB (20416 >=
> > 16384); disabling LPIB delay counting
> 
> This looks quite bad - is it not a hardware bug if LPIB > CBL (CBL should be
> 16384 in this case)?
> 
> 
> --
> David Henningsson, Canonical Ltd.
> https://launchpad.net/~diwic
