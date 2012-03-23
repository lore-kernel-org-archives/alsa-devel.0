From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: trying to get an eleven rack to work
Date: Fri, 23 Mar 2012 16:57:11 +1100
Message-ID: <CACckToUeX7oJmQ9NeRLGecxOxWaLpxbZDnNWA0+t5+XxFvf+FQ@mail.gmail.com>
References: <CAOyn=DH_BCQh-DksiLGQnQw1kq0eNNH+Zi7KdRdX5=uot9x2Eg@mail.gmail.com>
	<4F6883F9.4010405@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 00559243D0
	for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2012 06:57:11 +0100 (CET)
Received: by wibhn6 with SMTP id hn6so1321330wib.2
	for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2012 22:57:11 -0700 (PDT)
In-Reply-To: <4F6883F9.4010405@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, David Alexander <lidxv0n@gmail.com>
List-Id: alsa-devel@alsa-project.org

[snip]

Clemens/Daniel,

Does this seem more complete given that DFU and Midi are Class compliant

my guess at the interface purposes from David's post are:

Interface 0 is a DFU firmware upgrade // looks usb class compliant.
Interface 1 is really custom (perhaps some sort of custom
control/management thing tho I would of thought they'd use midi sysex for
that)
Interface 2 is the midi  //looks 100% standards compliant (works?)
Interface 3 looks like maybe a usb mixer without a descriptor? but that's a
guess.
Interface 4 is potentially usb2 audio output // looks similar to the
maudioi fast track isosyncronous outputs
Interface 5 is potentially usb2 audio input. // ""

So that all said.

can USB_DEVICE_VENDOR_SPEC deal with out of order compliant/quirked
interfaces or only sequencial??

Would this look more like it using USB_DEVICE_VENDOR_SPEC?

USB_DEVICE_VENDOR_SPEC(0x0dba, 0xb011),
       .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
               .vendor_name = "Digidesign",
               .product_name = "Eleven Rack",
               .ifnum = QUIRK_ANY_INTERFACE,
               .type = QUIRK_COMPOSITE,
               .data = & (const struct snd_usb_audio_quirk[]) {
                       {
                               .ifnum = 1,
                               .type = QUIRK_IGNORE_INTERFACE
                       },

                       {
                               .ifnum = 3,
                               .type = QUIRK_AUDIO_STANDARD_MIXER
                       },
                       {
                               .ifnum = 4,
                               .type = QUIRK_AUDIO_STANDARD_INTERFACE
                       },
                       {
                               .ifnum = 5,
                               .type = QUIRK_AUDIO_STANDARD_INTERFACE
                       },
                       {
                               .ifnum = -1
                       }
               }
       }
}

Will a quirk with no usbid work (assuming david didn't edit what clemens
posted) ?

My gut feeling is that the mixer is missing all the endpoint and route
stuff so we'll need to build a model of the mixer by sniffing the usb.

Grant.
