From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: HD-audio runtime PM
Date: Mon, 9 Dec 2013 07:02:44 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F80142FA38@SHSMSX101.ccr.corp.intel.com>
References: <s5hli0gmyxt.wl%tiwai@suse.de>
 <CA+v+29hKbtTBLh=qNRBVqd-NUfXRVBBokoypDh_0RMRQ_VjYvw@mail.gmail.com>
 <s5hiovfy9ji.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F80141992D@SHSMSX101.ccr.corp.intel.com>
 <s5ha9gry640.wl%tiwai@suse.de>	<s5hzjorwouu.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F80141CF98@SHSMSX101.ccr.corp.intel.com>
 <s5heh626rnh.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F80141D1C7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 03266264EF5
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 08:03:06 +0100 (CET)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F80141D1C7@SHSMSX101.ccr.corp.intel.com>
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
To: "Lin, Mengdong" <mengdong.lin@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: "Alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wang Xingchao <wangxingchao2011@gmail.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> > > I've checked two Haswell-ULT platforms with sound git tree for-linus
> > branch, under Ubuntu:
> > > - ELD cannot refresh properly.
> > > - HDMI hot-plug cannot wake up the audio controller.

I've tested the latest 3.13-rc2 based sound git tree, master branch:
- ELD can refresh properly on hot-plug event.
 I need to bisect to see where the ELD regression happened and how it was fixed. 

- Headset insertion can wake up the legacy audio controller (PCI device 00:1b)

- HDMI insertion still cannot wake up the display audio controller (PCI device 00:03)
 We'll double check with HW owner whether the display audio controller really supports wake up on HDMI/DP insertion.
 I remember when Xingchao enabled runtime PM on Haswell display audio controller for display power well release, 
 there was an issue that this controller does not support "wake up", but we finally enable runtime PM on it and remove the request for "wake up".

Thanks
Mengdong

> > > I guess maybe the latest display driver does not handle hot-plug
> > properly which affect both ELD and device wakeup.
> > >
> > > For Android on Haswell, the kernel code base and BIOS are different.
> > >
> > > I'll further check this issue. Is it very urgent?
> >
> > Not that urgent, but if it's a regression, we must fix it.
> > If it's no regression, the urgency decreases, of course.
> >
> > > I cannot work full time on this now due to some timing optimization
> > task for Baytrail at the same time.
> >
> > At least, it'd be helpful if you can confirm whether it still works
> > with vanilla 3.9.x kernel (or whatever version) you tested in the past
> > -- i.e. to know whether it's a regression or not.
> 
> Okay, I'll try kernels close to when Xingchao enable this wake-up feature.
