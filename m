From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: Small Regression in midi for M-Audio Fast Track
	Ultra.
Date: Tue, 26 Apr 2011 19:17:41 +1000
Message-ID: <BANLkTi=SCB8-HAvwdK-4MiZ6eTA7Pu3v+w@mail.gmail.com>
References: <BANLkTim0nHo5h8FBebrt_e77igtj4tGOgQ@mail.gmail.com>
	<4DAC0158.6090400@ladisch.de> <4DAC0468.4000705@showlabor.de>
	<4DAF4148.5050600@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B23A10385B
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 11:17:41 +0200 (CEST)
Received: by ewy6 with SMTP id 6so130368ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2011 02:17:41 -0700 (PDT)
In-Reply-To: <4DAF4148.5050600@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

So I finally got around to building a new kernel today.

and after rebooting I get:

[  131.832084] usb 2-1: new high speed USB device using ehci_hcd and address
3
[  131.969795] usb 2-1: config 1 interface 3 altsetting 0 bulk endpoint 0x7
has invalid maxpacket 8
[  131.969800] usb 2-1: config 1 interface 3 altsetting 0 bulk endpoint 0x87
has invalid maxpacket 8
[  131.970886] usb 2-1: New USB device found, idVendor=0763, idProduct=2080
[  131.970890] usb 2-1: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[  131.970892] usb 2-1: Product: Fast Track Ultra
[  131.970894] usb 2-1: Manufacturer: M-Audio
[  132.060121] usbcore: registered new interface driver snd-usb-audio
nevyn@cetacea:~$ amidi -l
Dir Device    Name
IO  hw:1,0,0  Fast Track Ultra MIDI 1

Which is excellent and solves my problem.

now to find and apply that mixer patch.

Grant.


On Thu, Apr 21, 2011 at 6:25 AM, Felix Homann <linuxaudio@showlabor.de>wrote:

> Sorry, Clemens,
>
> I must have messed around with too many Alsa versions on my machine, again.
> Your suggested fix _does_ fix the issue!
>
> Would you mind adding this to the git tree? Or shall I prepare a patch?
>
>
> Am 18.04.2011 11:16, schrieb Clemens Ladisch:
>
>> Try replacing the comment with:
>>>                        {
>>>                                .iface = 3,
>>>                                .type = QUIRK_MIDI_STANDARD_INTERFACE
>>>                        },
>>>
>>>
> In the meantime I started a bisect session on the mainline kernel. The
> cause of this issue lies in the refactoring done last year. I couldn't
> identify the exact patch introducing the regression, though, since starting
> at step 10 the kernels would not boot. See the corresponding git bisect log
> (the last revision is the first one that would not boot).
>
> Regards,
>
> Felix
>
