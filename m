From: "Keith A. Milner" <maillist@superlative.org>
Subject: Re: [git pull] [PATCH 0/7] add support for many Roland
	and Yamaha devices
Date: Fri, 09 Aug 2013 16:02:02 +0100
Message-ID: <4161390.DqJ0fEoIrV@kamdesktop>
References: <51CC9D8B.7060601@ladisch.de> <1670669.usJAXLJcqQ@kamdesktop>
 <5204EBD4.2040504@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f50.google.com (mail-ee0-f50.google.com [74.125.83.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 35D1B2657B8
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 17:02:04 +0200 (CEST)
Received: by mail-ee0-f50.google.com with SMTP id d51so2140309eek.23
 for <alsa-devel@alsa-project.org>; Fri, 09 Aug 2013 08:02:04 -0700 (PDT)
In-Reply-To: <5204EBD4.2040504@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Friday 09 Aug 2013 15:17:08 Clemens Ladisch wrote:
> Keith A. Milner wrote:
> > I will mention, if it is of any importance, that I get the following when
> > the driver is loaded:
> > 
> > [ 3340.089613] snd-usb-audio: probe of 1-6.2:1.2 failed with error -5
> 
> That looks like the MIDI interface.
> Do you have the MIDI ports (see "amidi -l")?

No MIDI ports show up. Nor are there any on the device or any that I'm aware 
of that are "internal" to the device.

I will note that on the Boss BR-80 there is an "internal" MIDI port which can 
be used as a drum synth. There appears to be nothing similar on the JS-8.

My original quirk actually had an bug as it included a MIDI endpoint 
definition. This originally worked without error, but in later versions it 
started to error in a similar way, I believe because of later changes to snd-
usb.

>From what I can tell, the JS-8 announces a MIDI-like interface, but doesn't 
actually have one.

> Is there any error message in the system log?

Not really. It's pretty uch the same as in dmesg:

Aug  9 15:52:18 KAMDesktop kernel: [ 6374.238016] usb 1-6.2: new high-speed 
USB device number 7 using ehci-pci
Aug  9 15:52:18 KAMDesktop kernel: [ 6374.332853] snd-usb-audio: probe of 
1-6.2:1.2 failed with error -5
Aug  9 15:52:18 KAMDesktop mtp-probe: checking bus 1, device 7: 
"/sys/devices/pci0000:00/0000:00:1a.7/usb1/1-6/1-6.2"
Aug  9 15:52:18 KAMDesktop mtp-probe: bus: 1, device: 7 was not an MTP device
Aug  9 15:52:18 KAMDesktop kernel: [ 6374.365928] Unable to change format on 
ep #84: already in use
Aug  9 15:52:18 KAMDesktop kernel: [ 6374.365944] Unable to change format on 
ep #84: already in use
Aug  9 15:52:18 KAMDesktop kernel: [ 6374.365965] Unable to change format on 
ep #84: already in use
Aug  9 15:52:18 KAMDesktop kernel: [ 6374.366109] Unable to change format on 
ep #84: already in use

Cheers,

Keith
