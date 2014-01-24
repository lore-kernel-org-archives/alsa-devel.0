From: Daniel Mack <daniel@zonque.org>
Subject: Re: Audio usb switch to alternate setting 0
Date: Sat, 25 Jan 2014 00:21:39 +0100
Message-ID: <52E2F583.9000609@zonque.org>
References: <52DBD817.8050304@samsung.com> <52DCF98A.4080509@zonque.org>
 <52E16DF8.8000909@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id C4D752654B4
 for <alsa-devel@alsa-project.org>; Sat, 25 Jan 2014 00:21:40 +0100 (CET)
In-Reply-To: <52E16DF8.8000909@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Konstantinos Georgantas <k.georgantas@samsung.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/23/2014 08:31 PM, Konstantinos Georgantas wrote:
> On 01/20/2014 11:25 AM, Daniel Mack wrote:
>> On 01/19/2014 02:50 PM, Konstantinos Georgantas wrote:
>>> I am trying to control from the client side which Alternate Setting to
>>> use. Basically I would like to be able to switch from Alternate Setting
>>> 0 to 1 and vice versa so that I am not receiving any set interface
>>> requests in the meantime. From the audio class 2.0 documentation I
>>> understand that I should be able to do something like this by using the
>>> active alternate setting control, and here comes my main problem.
>>
>> I'm not quite following from which side you're looking at the system,
>> IOW, who should be "receiving" requests. Are you talking about the
>> device or the host side?
>
> As I see it generating an interrupt from the device to the host should 
> "force" the host to "take appropriate action to reactivate the interface 
> by switching to a valid Alternate Setting".

Yes, that's the intended use of such an interrupt.

>> As the spec says (5.2.6.1.1), such a control is read-only, and it "does
>> not allow an interface to change from one active Alternate Setting to
>> another without Host intervention". "The main purpose of this Control is
>> to notify the Host (through an interrupt) that the last
>> selected Alternate Setting is no longer valid.".
>>
>> Active alt setting switching is done implictly by (de)activating the PCM
>> streams that are associated with them.
>
> That is right! But what if someone tries to play music for example? The 
> host will try to set Alternate Setting 1 again thinking that it is still 
> active but in this case my device happens to be in sleep mode so it 
> cannot reply to the usb_set_interface requests.

That's a different problem then. As far as the error case is concerned,
I would expect the device to stop ACKing the isochronous URBs
immediately, which would result the PCM stream to get torn down. When a
PCM interface is closed, the alternate setting 0 is selected
automatically, and things should be in sync again.

> I thought that if I 
> indicated that only Alternate Setting 0 is active I would avoid this 
> request.

Yes, but such a request should be NACKed by the device anyway if the alt
setting changed during runtime, so it shouldn't do any harm.

> Am I right? Of course when waking up I could issue another 
> interrupt indicating that my device activates again the Alternate 
> Setting 1. Please correct me if I misunderstand something.

I believe you're seeing two different effects mixed up here. The device
is not supposed to go to sleep mode in such sitations, and without being
asked to do so by the host. What exactly makes you believe it is in this
mode?

>> As always: patches are welcome :)
>
> Absolutely! I can come up with a patch but I just want to be sure I have 
> understood the spec in the right way :)

I think you did, but I have my doubts that your interpretations of what
happens is right, but you might recognize that yourself once you
implemented the code.

When cooking the patch, consider a generic interrupt handler outside of
mixer.c, and redirect to a mixer interrupt function for mixer requests.
I'd like to avoid fiddling with PCM stream details from mixer.c.


Thanks,
Daniel
