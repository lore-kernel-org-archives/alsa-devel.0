From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH v2] ALSA: hda - Fix Skylake codec timeout
Date: Fri, 17 Jul 2015 02:28:10 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1968766C@SHSMSX103.ccr.corp.intel.com>
References: <1437035964-5658-1-git-send-email-david.henningsson@canonical.com>
 <96A12704CE18D347B625EE2D4A099D19687270@SHSMSX103.ccr.corp.intel.com>
 <55A7CE55.5010700@canonical.com>	<s5hvbdki0aa.wl-tiwai@suse.de>
 <55A7CFC5.8040707@canonical.com> <s5hr3o8hzeg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 20FBE260635
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2015 04:29:27 +0200 (CEST)
In-Reply-To: <s5hr3o8hzeg.wl-tiwai@suse.de>
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
Cc: "hui.wang@canonical.com" <hui.wang@canonical.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lu,
 Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, July 16, 2015 11:54 PM
> To: David Henningsson
> Cc: Yang, Libin; hui.wang@canonical.com; alsa-devel@alsa-project.org;
> Lin, Mengdong; Lu, Han
> Subject: Re: [PATCH v2] ALSA: hda - Fix Skylake codec timeout
> 
> On Thu, 16 Jul 2015 17:37:41 +0200,
> David Henningsson wrote:
> >
> >
> >
> > On 2015-07-16 17:34, Takashi Iwai wrote:
> > > On Thu, 16 Jul 2015 17:31:33 +0200,
> > > David Henningsson wrote:
> > >>
> > >>
> > >>
> > >> On 2015-07-16 17:14, Yang, Libin wrote:
> > >>>> -----Original Message-----
> > >>>> From: David Henningsson
> [mailto:david.henningsson@canonical.com]
> > >>>> Sent: Thursday, July 16, 2015 4:39 PM
> > >>>> To: tiwai@suse.de; hui.wang@canonical.com; alsa-devel@alsa-
> > >>>> project.org; Yang, Libin; Lin, Mengdong
> > >>>> Cc: David Henningsson
> > >>>> Subject: [PATCH v2] ALSA: hda - Fix Skylake codec timeout
> > >>>>
> > >>>> When the controller is powered up but the HDMI codec is
> powered
> > >>>> down
> > >>>> on Skylake, the power well is turned off. When the codec is
> then
> > >>>> powered up again, we need to poke the codec a little extra to
> make
> > >>>> sure it wakes up. Otherwise we'll get sad "no response from
> codec"
> > >>>> messages and broken audio.
> > >>>
> > >>> Thanks for finding this issue.
> > >>>
> > >>> Could you please give us you test case? We didn't meet such
> issue
> > >>> before. I would like do a full test on it.
> > >>
> > >> The test case is:
> > >>
> > >>    - Install Ubuntu 15.04.
> > >>    - Upgrade to kernel 4.1.
> > >>    - Boot the new kernel.
> > >>
> > >> Note: I believe Hui tested with 4.1 and got this error. In my case I
> > >> have been running a hybrid kernel: Ubuntu 15.04, kernel 3.19.0-
> 23.24
> > >> (which has a backported i915 driver), and then the alsa-daily
> DKMS on
> > >> top of that.
> > >>
> > >> I can email you off-list with details about the machine I tested it
> on,
> > >> if you like.
> > >
> > > Did you hotplug the device or is it booted while plugged?
> > > I had an unstable communication at hotplug / unplug on SKL at the
> last
> > > time, too.  But the boot with the DP plugged worked well even on
> an
> > > old SKL box.
> >
> > For this bug, there was no HDMI monitor connected at all, but I
> believe
> > it does not matter. On power up, the power well is enabled and then
> > disabled. When the power well is enabled again without this extra
> wakeup
> > poke (probably due to PulseAudio probing), this error happens.
> 
> Ah, that's interesting.  So this happens when no monitor is
> connected.  I haven't seen this, though; maybe depends on the board
> or
> BIOS.

On SKL, each time turning on power well 2, display codec need
extra wakeup poke.

If there is monitor connected, power well will not be turned
off even audio driver asks to.

If there is monitor connected, power well will be really
turned off. In this case, when hdmi audio is used, we 
must do the wakeup poke.

> 
> 
> Takashi
