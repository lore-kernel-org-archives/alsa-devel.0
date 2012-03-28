From: David Alexander <lidxv0n@gmail.com>
Subject: Re: trying to get an eleven rack to work
Date: Wed, 28 Mar 2012 12:53:36 -0400
Message-ID: <CAOyn=DEumKD5yUPrBbqmqTB-6DuQgb0WEA5qYiRYK1peEM-nnA@mail.gmail.com>
References: <CAOyn=DH_BCQh-DksiLGQnQw1kq0eNNH+Zi7KdRdX5=uot9x2Eg@mail.gmail.com>
	<4F6883F9.4010405@ladisch.de>
	<CACckToUeX7oJmQ9NeRLGecxOxWaLpxbZDnNWA0+t5+XxFvf+FQ@mail.gmail.com>
	<4F718114.5020602@ladisch.de>
	<CAOyn=DFig0m1zFRWyTE6Neimrcy12PPAoNL8BdFVaAUrYEYbGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C9C2D243A7
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 18:53:39 +0200 (CEST)
Received: by yenl1 with SMTP id l1so919114yen.38
	for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2012 09:53:37 -0700 (PDT)
In-Reply-To: <CAOyn=DFig0m1zFRWyTE6Neimrcy12PPAoNL8BdFVaAUrYEYbGw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

---------- Forwarded message ----------
From: "David Alexander" <lidxv0n@gmail.com>
Date: Mar 27, 2012 10:45 PM
Subject: Re: [alsa-devel] trying to get an eleven rack to work
To: "Clemens Ladisch" <clemens@ladisch.de>

Grant & Clemens,

Sorry for the delay in getting the dev box set up.   Here are the
errors listed from the
syslog with the suggested additions to quirks-table.h implemented:


kernel: [   74.128035] usb 2-4: new high speed USB device number 2
using ehci_hcd
mtp-probe: checking bus 2, device 2:
"/sys/devices/pci0000:00/0000:00:1d.7/usb2/2-4"
mtp-probe: bus: 2, device: 2 was not an MTP device

kernel: [   74.634592] ALSA mixer.c:1938 usbaudio: unit 32: unexpected type
0x09
kernel: [   74.634606] snd-usb-audio: probe of 2-4:1.0 failed with error -5
kernel: [   74.635228] ALSA mixer.c:1938 usbaudio: unit 32: unexpected type
0x09
kernel: [   74.635246] snd-usb-audio: probe of 2-4:1.1 failed with error -5
kernel: [   74.635717] ALSA mixer.c:1938 usbaudio: unit 32: unexpected type
0x09
kernel: [   74.635732] snd-usb-audio: probe of 2-4:1.2 failed with error -5
kernel: [   74.636515] ALSA mixer.c:1938 usbaudio: unit 32: unexpected type
0x09
kernel: [   74.636529] snd-usb-audio: probe of 2-4:1.3 failed with error -5
kernel: [   74.636973] ALSA mixer.c:1938 usbaudio: unit 32: unexpected type
0x09
kernel: [   74.636986] snd-usb-audio: probe of 2-4:1.4 failed with error -5
kernel: [   74.637027] usbcore: registered new interface driver
snd-usb-audio


Thank you,
David



On Tue, Mar 27, 2012 at 4:57 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Grant Diffey wrote:
>> my guess at the interface purposes from David's post are:
>>
>> Interface 1 is really custom (perhaps some sort of custom
control/management thing tho I would of thought they'd use midi sysex for
that)
>
> It's an audio control interface, just marked as vendor-specific.
>
>> Interface 3 looks like maybe a usb mixer without a descriptor? but
that's a guess.
>
> Interface 3 is audio output.
>
>> Interface 4 is potentially usb2 audio output // looks similar to the
maudioi fast track isosyncronous outputs
>
> Interface 4 is audio input, it has only an input endpoint.
>
>> Interface 5 is potentially usb2 audio input. // ""
>
> There is no interface 5.
>
>> can USB_DEVICE_VENDOR_SPEC deal with out of order compliant/quirked
interfaces or only sequencial??
>
> The one has nothing to do with the other.
>
>
> Regards,
> Clemens
