From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Subject: Re: [PATCH 1/1] ALSA: usb: initial USB Audio Device
	Class 3.0 support
Date: Sat, 11 Nov 2017 04:56:17 +0200
Message-ID: <CAB=otbTKoz5E_Pzssn7fqVRz7MVDD3xzFZ_kYjGEHxCfJns3NA@mail.gmail.com>
References: <1510020080-15849-1-git-send-email-ruslan.bilovol@gmail.com>
 <1510020080-15849-2-git-send-email-ruslan.bilovol@gmail.com>
 <s5h1sl8hm38.wl-tiwai@suse.de> <20171109080458.GC17098@kroah.com>
 <s5hmv3vvpcb.wl-tiwai@suse.de> <20171109083344.GA11420@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f195.google.com (mail-ot0-f195.google.com
 [74.125.82.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 38F1E266B67
 for <alsa-devel@alsa-project.org>; Sat, 11 Nov 2017 03:56:18 +0100 (CET)
Received: by mail-ot0-f195.google.com with SMTP id q99so9730777ota.2
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 18:56:18 -0800 (PST)
In-Reply-To: <20171109083344.GA11420@kroah.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 9, 2017 at 10:33 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Nov 09, 2017 at 09:16:52AM +0100, Takashi Iwai wrote:
>> On Thu, 09 Nov 2017 09:04:58 +0100,
>> Greg Kroah-Hartman wrote:
>> >
>> > On Wed, Nov 08, 2017 at 03:38:35PM +0100, Takashi Iwai wrote:
>> > > On Tue, 07 Nov 2017 03:01:20 +0100,
>> > > Ruslan Bilovol wrote:
>> > > >
>> > > > Recently released USB Audio Class 3.0 specification
>> > > > introduces many significant changes comparing to
>> > > > previous versions, like
>> > > >  - new Power Domains, support for LPM/L1
>> > > >  - new Cluster descriptor
>> > > >  - changed layout of all class-specific descriptors
>> > > >  - new High Capability descriptors
>> > > >  - New class-specific String descriptors
>> > > >  - new and removed units
>> > > >  - additional sources for interrupts
>> > > >  - removed Type II Audio Data Formats
>> > > >  - ... and many other things (check spec)
>> > > >
>> > > > It also provides backward compatibility through
>> > > > multiple configurations, as well as requires
>> > > > mandatory support for BADD (Basic Audio Device
>> > > > Definition) on each ADC3.0 compliant device
>> > > >
>> > > > This patch adds initial support of UAC3 specification
>> > > > that is enough for Generic I/O Profile (BAOF, BAIF)
>> > > > device support from BADD document.
>> > > >
>> > > > Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>> > >
>> > > The patch looks good, but the timing is fairly late for merging to
>> > > 4.15.
>> >
>> > Isn't kbuild barfing all over these?  Is that because of the cross-tree
>> > changes needed?
>>
>> No, it's just local to the audio driver, plus a few
>> include/linux/usb/*.h modification / addition.
>> So there shouldn't be a big breakage in that regard.

The UAC3 gadget driver (which I sent to linux-usb mailing list) depends on
a new audio-v3.h header which is a part of this patch.

So Felipe's tree will have dependency on Takashi's tree; and that's why
kbuild notifies about build failure of UAC3 gadget driver.

>>
>>
>> > > So from my side, the primary question is whether the changes in USB
>> > > (audio) header files are OK for USB guys.
>> > >
>> > > Greg, could you check these changes and give an ack if it's OK to
>> > > merge?  Or if you prefer postpone, just let me know.
>> >
>> > I don't object to the USB header changes, as long as the fixes you point
>> > out are made :)
>>
>> Good to hear.
>> Could you give your acked-by once after reviewing the patch?
>
> I'm guessing there will be a new patch?  I'll be glad to review that
> one.

Sure, there will be a new patch set soon.

Thanks,
Ruslan
