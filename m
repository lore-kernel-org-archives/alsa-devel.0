From: Pedro Ferreira <ilzogoiby@gmail.com>
Subject: Re: USB midi support for KAOSS pad
Date: Thu, 24 Jun 2010 19:08:31 +0100
Message-ID: <AANLkTinj6QQyyaRYoRMOf6g6NGMls_yob_7dnXM3RdSx@mail.gmail.com>
References: <AANLkTimUYbWSqsahW9m8AbIjZuT-yVvnkGpnfCrLyi8u@mail.gmail.com>
	<20100524153324.GL30801@buzzloop.caiaq.de>
	<AANLkTil4vczJ2ymOEAUCRQBfZroxxtRpWpC6Wl3TgcUq@mail.gmail.com>
	<20100524205319.GP30801@buzzloop.caiaq.de>
	<AANLkTik4fUbdlrhDZWEVxckWgpiSDPvo2snpU-5cHWBd@mail.gmail.com>
	<20100524225412.GR30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E658F2443D
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 20:08:36 +0200 (CEST)
Received: by qyk36 with SMTP id 36so232119qyk.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 11:08:35 -0700 (PDT)
In-Reply-To: <20100524225412.GR30801@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

Sorry for coming back to this after one month, but my laptop decided
to die and only yesterday I received it back.

So, when I disable usb-audio, mass storage shows the same behavior
(multiple resets), and when I disable mass storage, usb-audio doesn't
even load:

{{{
[ 6893.787825] usbcore: deregistering interface driver usb-storage

* i plug the KAOSS pad in *

[ 6914.954294] usb 2-1.1.1: new full speed USB device using ehci_hcd
and address 13
}}}

And that's it.
Shouldn't usb-audio work independently of mass storage?

Thanks once again.

Cheers,

Pedro



On Mon, May 24, 2010 at 11:54 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On Tue, May 25, 2010 at 12:34:03AM +0200, Pedro Ferreira wrote:
>> > And here, the device is disconnected from USB, but I doubt that is
>> > related to the driver stack. The only thing I can currently think of is
>> > that the device draws too much power at this point, and a voltage
>> > brown-out causes the device to reset. Can you try a powered hub, or is
>> > this device powered by an external supply anyway?
>>
>> It's got its own power supply :)
>>
>> > Did you successfully
>> > use it on the _same_ hardware under Windows?
>>
>> Haven't tried... I don't have windows on this machine :/
>
> Could you try to temporarily disable the snd-usb-audio driver (move the
> module away or build a kernel without support for it) and then see
> whether the mass storage function works stable? And then the other way
> around - disable USB mass storage and try the audio function only.
>
> Maybe that can give some hint.
>
> Daniel
>
