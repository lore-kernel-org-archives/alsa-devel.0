From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] Re: Small Regression in midi for M-Audio
 Fast Track Ultra.
Date: Thu, 12 May 2011 17:48:16 +0200
Message-ID: <BANLkTimWiYpJbWFLt5iCKHmvGAdnCmTiFw@mail.gmail.com>
References: <BANLkTim0nHo5h8FBebrt_e77igtj4tGOgQ@mail.gmail.com>
	<4DAC0158.6090400@ladisch.de> <4DAC0468.4000705@showlabor.de>
	<4DAF4148.5050600@showlabor.de>
	<BANLkTi=SCB8-HAvwdK-4MiZ6eTA7Pu3v+w@mail.gmail.com>
	<BANLkTim8J09R2MQ-6GoPno_x6cBzXyOYxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id B486B243E3
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 17:48:18 +0200 (CEST)
Received: by pwi9 with SMTP id 9so910920pwi.38
	for <alsa-devel@alsa-project.org>; Thu, 12 May 2011 08:48:17 -0700 (PDT)
In-Reply-To: <BANLkTim8J09R2MQ-6GoPno_x6cBzXyOYxQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 26, 2011 at 11:42 AM, Grant Diffey <gdiffey@gmail.com> wrote:
> oh here's a git patch if that helps
>
> On Tue, Apr 26, 2011 at 7:17 PM, Grant Diffey <gdiffey@gmail.com> wrote:
>>
>> So I finally got around to building a new kernel today.
>>
>> and after rebooting I get:
>>
>> [=A0 131.832084] usb 2-1: new high speed USB device using ehci_hcd and
>> address 3
>> [=A0 131.969795] usb 2-1: config 1 interface 3 altsetting 0 bulk endpoint
>> 0x7 has invalid maxpacket 8
>> [=A0 131.969800] usb 2-1: config 1 interface 3 altsetting 0 bulk endpoint
>> 0x87 has invalid maxpacket 8
>> [=A0 131.970886] usb 2-1: New USB device found, idVendor=3D0763,
>> idProduct=3D2080
>> [=A0 131.970890] usb 2-1: New USB device strings: Mfr=3D1, Product=3D2,
>> SerialNumber=3D0
>> [=A0 131.970892] usb 2-1: Product: Fast Track Ultra
>> [=A0 131.970894] usb 2-1: Manufacturer: M-Audio
>> [=A0 132.060121] usbcore: registered new interface driver snd-usb-audio
>> nevyn@cetacea:~$ amidi -l
>> Dir Device=A0=A0=A0 Name
>> IO=A0 hw:1,0,0=A0 Fast Track Ultra MIDI 1
>>
>> Which is excellent and solves my problem.

Sorry everyone for the long absence - I've been travelling and it took
me some weeks to get all my setup up and ready again.

Is there anything on this topic that is yet to be solved, anything I
can help with?

Thanks,
Daniel
