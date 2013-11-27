From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: HD-audio runtime PM
Date: Wed, 27 Nov 2013 09:37:17 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F80141CF98@SHSMSX101.ccr.corp.intel.com>
References: <s5hli0gmyxt.wl%tiwai@suse.de>
 <CA+v+29hKbtTBLh=qNRBVqd-NUfXRVBBokoypDh_0RMRQ_VjYvw@mail.gmail.com>
 <s5hiovfy9ji.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F80141992D@SHSMSX101.ccr.corp.intel.com>
 <s5ha9gry640.wl%tiwai@suse.de> <s5hzjorwouu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C6312625D3
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 10:37:28 +0100 (CET)
In-Reply-To: <s5hzjorwouu.wl%tiwai@suse.de>
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
Cc: "Alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wang Xingchao <wangxingchao2011@gmail.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, November 26, 2013 4:26 PM

> > > > -----Original Message-----
> > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > Sent: Tuesday, November 26, 2013 2:14 PM
> > > > To: Wang Xingchao
> > >
> > > > > I test WAKEEN feature on Haswell machines before, it could
> > > > > really wakeup system from D3.
> > > >
> > > > But the runtime suspend doesn't power down to D3 by itself.
> > > > Did you test really with D3?
> > >
> > > I will double check this on Haswell with sound git tree for-linus branch.
> > > We've tried Android on Haswell-ULT last week, the display HD-A
> controller can enter D3 and HDMI cable plug-in can wake up the controller
> and codec. The code base is v3.9 with various driver patches.
> >
> > Hrm, but as I mentioned, we have no D3 call in runtime suspend
> > callback.  How does it reach to D3 then?  Maybe that part is patched
> > in your side?

Hi,

I've checked two Haswell-ULT platforms with sound git tree for-linus branch, under Ubuntu:
- ELD cannot refresh properly.
- HDMI hot-plug cannot wake up the audio controller.

The controller is suspended when idle timeout and put in D3 by PCI driver. Here is the status shown by lspci -vvvv as root:
00:03.0 Audio device: Intel Corporation Device 0a0c (rev 09)
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D3 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
... Status: D3 mean the device is in D3.

I guess maybe the latest display driver does not handle hot-plug properly which affect both ELD and device wakeup.

For Android on Haswell, the kernel code base and BIOS are different.

I'll further check this issue. Is it very urgent?
I cannot work full time on this now due to some timing optimization task for Baytrail at the same time.

Regards
Mengdong
