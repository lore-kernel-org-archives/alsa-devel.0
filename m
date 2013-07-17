From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 2/2] ALSA: hda - get realtime ELD info when
 codec suspended
Date: Wed, 17 Jul 2013 10:15:15 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC48901184DC07@SHSMSX104.ccr.corp.intel.com>
References: <1372074324-13563-1-git-send-email-xingchao.wang@linux.intel.com>
 <1372074324-13563-2-git-send-email-xingchao.wang@linux.intel.com>
 <s5hmwqfvizc.wl%tiwai@suse.de>
 <46B810F6945F7C4788E11DCE57EC489011833B68@SHSMSX104.ccr.corp.intel.com>
 <s5hk3ljvhu2.wl%tiwai@suse.de> <51C83FC5.3090005@canonical.com>
 <s5h38s7vf2v.wl%tiwai@suse.de> <51C94A80.70709@canonical.com>
 <s5hobauzkse.wl%tiwai@suse.de> <51C95CA3.7000001@canonical.com>
 <46B810F6945F7C4788E11DCE57EC4890118344E1@SHSMSX104.ccr.corp.intel.com>
 <51C96640.2020103@canonical.com>
 <CA+v+29g2RvJfC-rkp-Qbwo1je-s86t+uACUY4k6vgerJHUPKrg@mail.gmail.com>
 <51E37A84.6030909@canonical.com>
 <46B810F6945F7C4788E11DCE57EC48901184C456@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6156426547C
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 12:15:18 +0200 (CEST)
In-Reply-To: <46B810F6945F7C4788E11DCE57EC48901184C456@SHSMSX104.ccr.corp.intel.com>
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
To: "Wang, Xingchao" <xingchao.wang@intel.com>, David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Wang, Xingchao
> Sent: Monday, July 15, 2013 4:54 PM
> To: David Henningsson; Wang Xingchao
> Cc: Takashi Iwai; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH 2/2] ALSA: hda - get realtime ELD info when
> codec suspended
> 
> 
> 
> > -----Original Message-----
> > From: David Henningsson [mailto:david.henningsson@canonical.com]
> > Sent: Monday, July 15, 2013 12:29 PM
> > To: Wang Xingchao
> > Cc: Takashi Iwai; Wang, Xingchao; alsa-devel@alsa-project.org
> > Subject: Re: [alsa-devel] [PATCH 2/2] ALSA: hda - get realtime ELD
> > info when codec suspended
> >
> > On 07/12/2013 08:13 AM, Wang Xingchao wrote:
> > > Hi David/Takashi,
> > >
> > > Here's some update on this topic.
> > > I used evtest to monitor hotplug input event for Headphone, it
> > > doesnot report the hotplug event when audio controller/codec in
> > > runtime suspend mode.
> > > if it's during audio playback(both controller and codec are active),
> > > the events could be monitored correctly.
> > > However even the controller/codec in runtime suspend mode, the
> > > hotplug event was not missed when waken up from suspend mode. After
> > > exit from suspend mode, the hotplug event would be reported asap.
> > > So userspace will not receive the event notification from driver
> > > when controller/codec in suspend mode, but it will get them once
> > > audio controller/codec become active.
> > > I think it's acceptable for audio playback functinality, it will not
> > > harm audio routing in fact. i'm not sure there's other potential
> > > risk, i.e. user space will show/hide the devices in UI according to
> > > the event, in that case , user will never see the Headphone device
> > > for playback before audio controller/codec was waken up in another way.
> > >
> > > Meanwhile i tested attached patch to monitor WAKEEN events, it
> > > doesnot work well as Spec said. it would not wake up audio
> > > controller/codec when plug in/out headphone in runtime suspend mode,
> > > and the status register always be 0.
> >
> > Hi Xingchao,
> >
> > Maybe you're giving up too easily on the WAKEEN stuff? I can spot a
> > few places where your patch is incomplete:
> >
> >   - First, WAKEEN and STATETS are word registers, you should probably
> > use azx_writew when you access them

If the controller is active while codec suspended, "evtest" can catch headphone hotplug event.
I made some changes in azx_runtime_suspend(), which in brief leave interrupt enabled, then "evtest" cannot catch input event.
Also I added some debug log shows, when controller enter suspend mode, the WAKEEN bits were set(value 0x3), after headphone hotplug,
Audio controller was not waken up. When audio controller exit, in azx_runtime_resume(), the debug shows WAKEEN bits value no change, STATETS
has value 0. The controller did not detect changes from codec side, so it donot set the bits in STATETS.

I read the spec, and found something different:
- Controller should be in reset state while In D3?(Chapter 4.5.9.2 in  HD-A spec.)
Azx_runtime-suspend() did not reset the controller.
- codec will use power state change request on the link to let controller know.
Not sure it's hardware operation or software layer.
- codec discovery ( chapter 4.3)
"When the link is enabled by the assertion of CRST, the codecs will detect the de-assertion of the RESET# signal and request a status change and enumeration by the controller. 
 As the controller hardware detects these requests, it will provide the codecs with their unique addresses and set the controller STATESTS bits
 to indicate that a Status Change event was detected on the appropriate SDATA_INx signals.  "
I'm afraid something was not configured correctly, i.e. should let controller in reset state when enter runtime suspend mode?

Thanks
--xingchao
> 
> Thanks for clarify this. We support 8 codec at most, so I think it's safe to use
> writeb/readb here.
> 
> >
> >   - Second, and this is definitely a problem, azx_runtime_suspend
> > calls azx_stop_chip -> azx_int_disable. So we disable interrupts,
> > that's why we don't get them from the wake events.
> [Wang, Xingchao]  yes, moreover I think it's not enough only enabling
> "controller interrupt" bits in this case, PCI interrupt bits must be anbled too.
> I'm still checking the setting in runtime_suspend.
> 
> >
> >   - Third, first in azx_interrupt, we check for
> > chip->pci->dev.power.runtime_status - maybe this is no longer true if
> > the device is in D3?
> [Wang, Xingchao] yes, it's a risk here. Just move the lines before the "if"
> condition check.
> >
> > Do you know how and if Windows has solved this?
> >
> [Wang, Xingchao] I have wrote emails for windows team guys, has no response
> yet. I will update here when I have update.
> 
> thanks
> --xingchao
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
