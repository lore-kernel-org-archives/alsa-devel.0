From: Clemens Ladisch <clemens@ladisch.de>
Subject: [RFC PATCH 1/11] expose sound device topology
	information
Date: Tue, 28 Aug 2012 00:28:30 +0200
Message-ID: <503BF48E.1090100@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E584C265230
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2012 00:29:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

these are some tentative patches to allow sound drivers to provide
routing information to userspace.  (So far, snd-usb-audio has a partial
implementation; I haven't yet had time for snd-hda-intel.  I haven't
even looked at ASoC.)

The media controller API <linux/media.h> allows prividing routing
information, but its implementation does not quite fit the sound
drivers:
* it allows reconfiguration of links, but not in a way that would be
  useful for ALSA selector controls;
* it allows drivers to access the entity graph and pipelines, which is
  not needed;
* it is rather heavyweight.

Therefore, these patches create their own implementation of the media
controller API.  In this implementation, all entity and link information
is completely static, and more space-efficient.

For simplicity, the ioctls hook into the ALSA control device instead
of creating a new /dev/media* device.

The separate implementation does not allow sharing of one media
controller device in the case of combined audio/video devices.  However,
separate drivers would already be a problem for HDMI outputs (GPU and
sound); it appears we might need some mechanism to connect the
topologies of multiple media devices.

TLVs (for jack entities, and for associating controls with entities)
are not yet defined.


Example output for my simple UA-1A device (not all information is
decoded correctly):

$ media-ctl -p -d /dev/snd/controlC5
Opening media device /dev/snd/controlC5
Enumerating entities
Found 4 entities
Enumerating pads and links
Media controller API version 0.0.0

Media device information
------------------------
driver          snd-usb-audio
model           EDIROL UA-1A
serial
bus info        usb-0000:00:12.2-4.3
hw revision     0x101
driver version  0.0.0

Device topology
- entity 1: USB Audio (1 pad, 1 link)
            type Node subtype ALSA
            device node name /dev/tty             (should be hw:5,0,0)
        pad0: Source
                -> "OT3":0 [ENABLED,IMMUTABLE]

- entity 3: OT3 (1 pad, 1 link)
            type Unknown subtype Unknown          (should be Jack)
        pad0: Sink
                <- "USB Audio":0 [ENABLED,IMMUTABLE]

- entity 4: IT4 (1 pad, 1 link)
            type Unknown subtype Unknown
        pad0: Source
                -> "USB Audio":0 [ENABLED,IMMUTABLE]

- entity 7: USB Audio (1 pad, 1 link)
            type Node subtype ALSA
            device node name /dev/tty
        pad0: Sink
                <- "IT4":0 [ENABLED,IMMUTABLE]


 include/linux/media.h     |    9
 include/sound/core.h      |   13 +
 include/sound/media.h     |  116 ++++++++++
 include/sound/pcm.h       |    6
 sound/core/Kconfig        |    7
 sound/core/Makefile       |    1
 sound/core/init.c         |    4
 sound/core/media.c        |  425 ++++++++++++++++++++++++++++++++++++++
 sound/core/pcm.c          |   46 ++++
 sound/core/sound.c        |    3
 sound/pci/hda/hda_intel.c |    2
 sound/usb/card.c          |    2
 sound/usb/mixer.c         |  278 ++++++++++++++++++++++++
 sound/usb/quirks.c        |    4
 sound/usb/stream.c        |   16 -
 sound/usb/stream.h        |    1
 16 files changed, 925 insertions(+), 8 deletions(-)


Regards,
Clemens
