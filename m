From: Daniel Mack <zonque@gmail.com>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Thu, 11 Aug 2011 19:27:15 +0200
Message-ID: <CACTFLAOi5u-YL+FKGotPSBv5BgEhKO5FLwZeJKdgyis3nZLbcw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1108101025250.1917-100000@iolanthe.rowland.org>
	<4E42A4AE.4020008@gmail.com> <20110810231552.GA7194@xanatos>
	<CACTFLAP9eRG6TVtFsNGO+oDu0U0gOUth-_TzLeW2yGb6Jxn2tA@mail.gmail.com>
	<20110811164539.GB5884@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id BF17324344
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 19:27:17 +0200 (CEST)
Received: by yxm34 with SMTP id 34so1535187yxm.38
	for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2011 10:27:15 -0700 (PDT)
In-Reply-To: <20110811164539.GB5884@xanatos>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: William Light <wrl@illest.net>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, Oliver Neukum <oliver@neukum.org>, Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, Florian Mickler <florian@mickler.org>, Alan Stern <stern@rowland.harvard.edu>, pedrib@gmail.com, Robert Hancock <hancockrwd@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 11, 2011 at 6:45 PM, Sarah Sharp
<sarah.a.sharp@linux.intel.com> wrote:
> On Thu, Aug 11, 2011 at 02:57:41AM +0200, Daniel Mack wrote:
>> On Thu, Aug 11, 2011 at 1:15 AM, Sarah Sharp
>> <sarah.a.sharp@linux.intel.com> wrote:
>> > On Wed, Aug 10, 2011 at 05:33:02PM +0200, Daniel Mack wrote:
>> >> On 08/10/2011 04:32 PM, Alan Stern wrote:
>> >> >Looking at the driver's current code, it appears that your patch
>> >> >does not fix the bug properly. =A0Using discontiguous regions in the
>> >> >transfer buffer is perfectly okay. =A0The real problem is later on,
>> >> >where you do:
>> >> >
>> >> >if (send_it) { out->number_of_packets =3D FRAMES_PER_URB;
>> >> >
>> >> >This should be
>> >> >
>> >> >out->number_of_packets =3D outframe;
>> >> >
>> >> >The way it is now, the USB stack will try to use data from all the
>> >> >frame descriptors, and the last few will be stale because the loop
>> >> >doesn't set them.
>> >>
>> >> That's actually true, even though it doesn't seem to cause any troubl=
e.
>> >> I tested everything here of course, and the output URBs return back f=
rom
>> >> the USB stack with their length fields zeroed out, which then
>> >> causes the stack to send packets with zero-length fields at the end.
>> >
>> > Actually, it causes system hangs when the driver is loaded on a device
>> > attached to a USB 3.0 port, as Alan Stern pointed out:
>> >
>> > https://bugzilla.kernel.org/show_bug.cgi?id=3D40702
>>
>> Yes, I've noticed this.
>>
>> > Please don't submit zero-length transfers. =A0The xHCI driver just isn=
't
>> > able to handle it. =A0Arguably, it probably should have just rejected =
your
>> > URB when it found a zero length buffer, so I'll probably be submitting=
 a
>> > patch to fix that.
>>
>> According to the spec, sending zero-length frames should be fine, no?
>> Is there any particular reason why XCHI can't handle this while EHCI
>> can? And does my patch fix the driver for XHCI?
>
> Ok, yes, you're correct that the xHCI spec allows the transfer length to
> be set to zero. =A0In the case where the frame buffer is zero-length, is
> the buffer pointer still valid? =A0It's not clear from the spec whether it
> needs to be.

Well, the buffer pointer is set in the URB, not in its individual iso
subframes which just denotes them via the offset field. So yes, it is
valid in my case. But it doesn't matter anymore, as the code which
does that is now gone :)


Daniel
