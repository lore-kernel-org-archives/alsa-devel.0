From: Daniel Mack <daniel@caiaq.de>
Subject: Re: UAC2 sound-unstable kernel and SDR-widget
Date: Thu, 3 Jun 2010 02:28:15 +0200
Message-ID: <20100603002815.GA2707@buzzloop.caiaq.de>
References: <AANLkTilUZKxmqarfo_AZa5GxRJpr-rQ6S6C6Jxzv3mWX@mail.gmail.com>
	<1275499047.2437.57.camel@kenm-i7>
	<9C1C945C-24C2-410E-B098-0AC5C006B9E2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BA3A1039FD
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 02:28:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9C1C945C-24C2-410E-B098-0AC5C006B9E2@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex Lee <alexlee188@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA_DEVEL <alsa-devel@alsa-project.org>, Ken McGuire <kenm@paonia.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Jun 03, 2010 at 06:41:24AM +0800, Alex Lee wrote:
> On 03-Jun-2010, at 1:17 AM, Ken McGuire <kenm@paonia.com> wrote:
> 
> >Hi Alex,
> >Well said. You might also send a copy to:
> >Daniel Mack <daniel@caiaq.de>
> >since I think he is the source of the current patches.

Just out of interest - where did you send that email to? I can't see any
such message on the ALSA or LKML mailing lists.

> >>We are a group of amateur radio enthusiasts who are developing
> >>an open
> >>source "sound card" for Software Defined Radio (SDR) applications.
> >>
> >>The project is called SDR-widget, and you can find more details in:
> >>
> >>http://code.google.com/p/sdr-widget/
> >>
> >>We also have a google group for the sdr-widget developers, and I have
> >>just sent you an invitation to join the group.
> >>
> >>The sdr-widget is a USB sound card based on the AK5394A ADC and a
> >>companion AK DAC, controlled by an AT32UC3A3 uProcessor.  We already
> >>have a prototype working.
> >>
> >>We have a version of the firmware running with UAC1, at 96khz 24bit
> >>mono, and 48khz 24 bit stereo capture.  The widget works under Linux
> >>and Windows with this firmware.  It enumerates as a composite high
> >>speed USB device with 4 interfaces: CDC, HID, custom DG8SAQ, and
> >>Audio.

Wow, interesting project. Thanks for letting us know.

> >>We are now working on a version of the firmware with UAC2.

Cool. Luckily, as the specs for this standard are freely available,
you shouldn't have much problems doing that. From my experience, it's
alsmost completely straight forward.

> >>We have recently managed to demonstrate 96khz 24bit stereo capture
> >>using Ubuntu 10.04 LTS, with kernel 2.6.34-4 and alsa 1.0.23.  We are
> >>shooting for 192khz 24 bit stereo full duplex eventually.
> >>
> >>We are now trying to get the sdr-widget running under kernel
> >>2.6.35-rc1 with your latest usb-audio updates.

That's very good to hear. My current problem is that I can only test the
driver with prototypes we made ourselves, and from reading the specs.
So more tester's feedback is certainly appreciated.

> >>We feel that this is an opportunity for us to work closely, as both
> >>the sound-unstable kernel development and the sdr-widget development
> >>are actively being pursued, and both are open source projects.  This
> >>will allow us to make sure both our projects become fully compliant
> >>with the UAC2 specs.

Agreed.

> >>For example, one area we are looking at currently is the different
> >>interpretations of the UAC2 specs for the CLOCK SELECT descriptor:
> >>
> >>
> >>
> >>This is the audio-v2.h version:
> >>
> >>
> >>/* 4.7.2.2 Clock Source Descriptor */
> >>
> >>
> >>struct uac_clock_selector_descriptor {
> >>       __u8 bLength;
> >>       __u8 bDescriptorType;
> >>       __u8 bDescriptorSubtype;
> >>       __u8 bClockID;
> >>       __u8 bNrInPins;
> >>       __u8 baCSourceID[];
> >>       /* bmControls, bAssocTerminal and iClockSource omitted */
> >>
> >>
> >>} __attribute__((packed));
> >>
> >>
> >>baCSourceID is a array of U8.
> >>
> >>
> >>Whereas widget firmware uses this:
> >>
> >>
> >>//! Clock Selector descriptor pp 4.7.2.2 WARNING this descriptor
> >>complies with
> >>//! the alsa 1.0.23 usb_audio_v2_compat.h which is different from pp.
> >>4.7.2.2
> >>typedef
> >>#if (defined __ICCAVR32__)
> >>#pragma pack(1)
> >>#endif
> >>struct
> >>#if (defined __GNUC__)
> >>__attribute__((__packed__))
> >>#endif
> >>{
> >> U8  bLength;               /* Size of this descriptor in bytes */
> >> U8  bDescriptorType;       /* CS_INTERFACE descriptor type */
> >> U8    bDescritorSubtype;     /* CLOCK_SELECTOR subtype */
> >> U8  bClockID;           /* Clock Selector ID */
> >> U8  bNrInPins;                     /* Number of Input Pins */
> >> U8  baCSourceID1;                     /* variable length */
> >> U8  baCSourceID2;
> >> U8  bmControls;                       /* Clock selector control
> >>bitmap !!! comes after
> >>baCSource in the spec!! */

Yeah, I know. I fixed this up already, and Takashi queued the patch in
his tree. Sorry about that, but ironically, you quoted the corrected
version above already. Our two structs are actually in sync now. And
more than that, the wrong version of the struct was in fact never used.
The code which started to parse clock selectors was added along with the
fix for the struct.

> >>So we are now discussing whether we should modify the sdr-widget
> >>firmware, or to patch the kernel :-)

Oh, we of course need to keep to the specs and implement it properly
on both sides. I can't promise this whole UAC2 stack to be bug-free or
complete at this point. As I said, it is only tested by prototypes that
work well under Mac OS X, too. So that's at least some kind of evidence :)

Just let me know whether you encounter any kind of bug in the driver
stack. Patches are very welcome :)

Thanks,
Daniel
