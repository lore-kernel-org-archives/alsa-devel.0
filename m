From: Daniel Mack <zonque@gmail.com>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Thu, 11 Aug 2011 23:39:03 +0200
Message-ID: <CACTFLAMcOMv4D8k-P24TAkPwLRgYps4hoO-vC1NH+cibcsrUFQ@mail.gmail.com>
References: <Pine.LNX.4.44L0.1108101025250.1917-100000@iolanthe.rowland.org>
	<4E42A4AE.4020008@gmail.com>
	<20110810231552.GA7194@xanatos>
	<CACTFLAP9eRG6TVtFsNGO+oDu0U0gOUth-_TzLeW2yGb6Jxn2tA@mail.gmail.com>
	<20110811164539.GB5884@xanatos>
	<CACTFLAOi5u-YL+FKGotPSBv5BgEhKO5FLwZeJKdgyis3nZLbcw@mail.gmail.com>
	<20110811180507.GC5884@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110811180507.GC5884@xanatos>
Sender: linux-kernel-owner@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Florian Mickler <florian@mickler.org>, Oliver Neukum <oliver@neukum.org>, linux-usb@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, pedrib@gmail.com, William Light <wrl@illest.net>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, =?UTF-8?B?TWF0xJtqIExhaXRs?= <matej@laitl.cz>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 11, 2011 at 8:05 PM, Sarah Sharp
<sarah.a.sharp@linux.intel.com> wrote:
> On Thu, Aug 11, 2011 at 07:27:15PM +0200, Daniel Mack wrote:
>> On Thu, Aug 11, 2011 at 6:45 PM, Sarah Sharp
>> <sarah.a.sharp@linux.intel.com> wrote:
>> > On Thu, Aug 11, 2011 at 02:57:41AM +0200, Daniel Mack wrote:
>> >> On Thu, Aug 11, 2011 at 1:15 AM, Sarah Sharp
>> >> <sarah.a.sharp@linux.intel.com> wrote:
>> >> > On Wed, Aug 10, 2011 at 05:33:02PM +0200, Daniel Mack wrote:
>> >> >> On 08/10/2011 04:32 PM, Alan Stern wrote:
>> >> >> >Looking at the driver's current code, it appears that your pa=
tch
>> >> >> >does not fix the bug properly. =A0Using discontiguous regions=
 in the
>> >> >> >transfer buffer is perfectly okay. =A0The real problem is lat=
er on,
>> >> >> >where you do:
>> >> >> >
>> >> >> >if (send_it) { out->number_of_packets =3D FRAMES_PER_URB;
>> >> >> >
>> >> >> >This should be
>> >> >> >
>> >> >> >out->number_of_packets =3D outframe;
>> >> >> >
>> >> >> >The way it is now, the USB stack will try to use data from al=
l the
>> >> >> >frame descriptors, and the last few will be stale because the=
 loop
>> >> >> >doesn't set them.
>> >> >>
>> >> >> That's actually true, even though it doesn't seem to cause any=
 trouble.
>> >> >> I tested everything here of course, and the output URBs return=
 back from
>> >> >> the USB stack with their length fields zeroed out, which then
>> >> >> causes the stack to send packets with zero-length fields at th=
e end.
>> >> >
>> >> > Actually, it causes system hangs when the driver is loaded on a=
 device
>> >> > attached to a USB 3.0 port, as Alan Stern pointed out:
>> >> >
>> >> > https://bugzilla.kernel.org/show_bug.cgi?id=3D40702
>> >>
>> >> Yes, I've noticed this.
>> >>
>> >> > Please don't submit zero-length transfers. =A0The xHCI driver j=
ust isn't
>> >> > able to handle it. =A0Arguably, it probably should have just re=
jected your
>> >> > URB when it found a zero length buffer, so I'll probably be sub=
mitting a
>> >> > patch to fix that.
>> >>
>> >> According to the spec, sending zero-length frames should be fine,=
 no?
>> >> Is there any particular reason why XCHI can't handle this while E=
HCI
>> >> can? And does my patch fix the driver for XHCI?
>> >
>> > Ok, yes, you're correct that the xHCI spec allows the transfer len=
gth to
>> > be set to zero. =A0In the case where the frame buffer is zero-leng=
th, is
>> > the buffer pointer still valid? =A0It's not clear from the spec wh=
ether it
>> > needs to be.
>>
>> Well, the buffer pointer is set in the URB, not in its individual is=
o
>> subframes which just denotes them via the offset field. So yes, it i=
s
>> valid in my case. But it doesn't matter anymore, as the code which
>> does that is now gone :)
>
> Do you mean it was removed with this patch:
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/tiwai/sound-2.6.git;a=3Dc=
ommitdiff;h=3D15439b
>
> Because according to Matej, he applied that patch, plus my patch to
> reject zero-length buffers[1], and he saw debugging that indicated he
> *did* see zero-length buffers. =A0Is there any chance your driver mig=
ht
> submit a zero-length buffer in the middle of the isochronous URB
> transfer array?

Hmm, judging from the code, this can only ever happen if we receive an
inbound iso frame which has a valid status and an actual_length of
zero. Also, it was not neccessary to catch this case for EHCI.

Maetj, does this patch make any difference?


Daniel



diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index aa52b3e..b48adb9 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -633,6 +634,10 @@ static void read_completed(struct urb *urb)
                        continue;

                len =3D urb->iso_frame_desc[outframe].actual_length;
+
+               if (len =3D=3D 0)
+                       continue;
+
                out->iso_frame_desc[outframe].length =3D len;
                out->iso_frame_desc[outframe].actual_length =3D 0;
                out->iso_frame_desc[outframe].offset =3D offset;
