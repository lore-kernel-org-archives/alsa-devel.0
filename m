From: Phil Frost <indigo@bitglue.com>
Subject: need help getting echo indigo io to work
Date: Tue, 19 Jul 2005 10:58:49 -0400
Message-ID: <20050719145849.GA29758@unununium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

It looks like no one can help on the user list, so I'm reposting this
here. In addition to the information I have below, I've traced the
problem a bit more.

By what I can tell by peppering the code with log messages, the failure
occurs in the kernel in drivers/base/firmware_class.c around line 431:

if (!fw_priv->fw->size || test_bit(FW_STATUS_ABORT, &fw_priv->status)) {
        retval = -ENOENT;
        ...

I've never done any kernel development, so I have no clue how to debug
this. Any help would be appreciated.

Phil

----- Forwarded message from Phil Frost <indigo@bitglue.com> -----

Delivery-date: Mon, 18 Jul 2005 11:43:12 -0400
From: Phil Frost <indigo@bitglue.com>
To: alsa-user@lists.sourceforge.net
Subject: [Alsa-user] need help getting echo indigo io to work

I recently purchaced an echo indigo io, a pcmcia sound device. I'm
trying to get it to work.

I started with the stock ubuntu kernel 2.6.10-5, but this has an old
alsa version and aparently the indigoio driver is not included with the
kernel sources anyway.

I downloaded, built and installed alsa-driver 1.0.9b, then alsa-firmware
1.0.9 without problems. /proc/asound/version shows:

Advanced Linux Sound Architecture Driver Version 1.0.9b.
Compiled on Jul 18 2005 for kernel 2.6.10-5-386.

Now when I insert the card, something seems to notice and the
snd_indigoio module is loaded successfully, but I do not see my card in
/proc/asound/cards.

Looking at dmesg, I see this:

ALSA /.../echoaudio.c:1870: Echoaudio driver starting...
PCI: Enabling device 0000:03:00.0 (0000 -> 0002)
ACPI: PCI interrupt 0000:03:00.0[A] -> GSI 9 (level, low) -> IRQ 9
ALSA /.../echoaudio.c:1793: chip=ce0bc014
ALSA /.../echoaudio.c:1819: pci=cf926400 irq=9 subdev=00a0 Init hardware...
ALSA /.../indigoio_dsp.c:39: init_hw() - Indigo IO
ALSA /.../echoaudio.c:38: firmware requested: indigo_io_dsp.fw
ALSA /.../echoaudio.c:41: get_firmware(): Firmware not available (-2)
ALSA /.../echoaudio.c:1834: init_hw err=-2
ALSA /.../echoaudio.c:1730: Stop DSP...
ALSA /.../echoaudio_dsp.c:953: rest_in_peace() open=0
ALSA /.../echoaudio_dsp.c:913: stop_transport 0
ALSA /.../echoaudio_dsp.c:936: stop_transport: No pipes to stop!
ALSA /.../echoaudio.c:1735: Stopped.
ALSA /.../echoaudio.c:1747: MMIO freed.
ALSA /.../echoaudio.c:1753: Chip freed.
Echoaudio Indigo IO: probe of 0000:03:00.0 failed with error -2

I don't know much about how firmware loading should work, but I did
manage to find that /etc/hotplug/firmware.agent seems to be responsible
for finding the firmware. By putting some echos in there I traced what
it was doing, and it generates this output:

looking for ea/indigo_io_dsp.fw-2.6.10-5-386
looking in /lib/hotplug/firmware
looking in /usr/local/lib/hotplug/firmware
looking in /usr/lib/hotplug/firmware
loading /usr/lib/hotplug/firmware/ea/indigo_io_dsp.fw
loaded /usr/lib/hotplug/firmware/ea/indigo_io_dsp.fw > /sys//class/firmware/0000:03:00.0/data

So aparently, it does find the firmware and sends it off somewhere to be
loaded. I don't know what should happen next, or where or why it could
be failing. Ideas, anyone?

Many thanks,
Phil


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
