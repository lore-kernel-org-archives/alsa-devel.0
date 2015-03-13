From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Adding new (old) SNDRV_SEQ_PORT_TYPE_MIDI_* defines
Date: Fri, 13 Mar 2015 09:07:57 +0100
Message-ID: <55029ADD.7020403@ladisch.de>
References: <CAOf41NnyZRX5B9TfGQvTq26-3x7NefsRETJ4SESE5uXFYSxUtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B6425260682
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 09:07:58 +0100 (CET)
In-Reply-To: <CAOf41NnyZRX5B9TfGQvTq26-3x7NefsRETJ4SESE5uXFYSxUtw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Goode <agoode@google.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adam Goode wrote:
> I found the /* TODO: read port flags from descriptors */ in
> sound/usb/midi.c and was thinking about what to do to implement this.
>
> The first thing to do would be to ensure that all the flags from the
> element descriptors in the USB MIDI standard are available for returning
> from snd_seq_port_info_get_type.

I don't know of any class-compliant USB MIDI device that actually has
elements and declares them in its descriptors.

Do you have anything that would allow us to test this?

> I propose adding these flags to ALSA:
>
> #define SNDRV_SEQ_PORT_TYPE_MIDI_CLOCK  (1<<7)  /* MIDI CLOCK compatible device */
> #define SNDRV_SEQ_PORT_TYPE_MIDI_TIME_CODE (1<<8) /* MTC compatible device */
> #define SNDRV_SEQ_PORT_TYPE_MIDI_MACHINE_CONTROL (1<<9) /* MMC compatible device */
> #define SNDRV_SEQ_PORT_TYPE_MIDI_EFX    (1<<21) /* Audio effects processor device */
> #define SNDRV_SEQ_PORT_TYPE_MIDI_PATCH_BAY (1<<22) /* MIDI patcher or router device */
> #define SNDRV_SEQ_PORT_TYPE_MIDI_DLS1   (1<<23) /* DownLoadable Sounds Standard Level 1 compatible device */
> #define SNDRV_SEQ_PORT_TYPE_MIDI_DLS2   (1<<24) /* DownLoadable Sounds Standard Level 2 compatible device */
>
> Thoughts? I can send a couple patches for the kernel and alsa-lib. I don't
> think this is a breaking change.

The first three flags might be useful.  Their problem is that software
cannot rely on them being set for all ports connected to devices that
support these features, but the other PORT_TYPE_MIDI flags have the same
problem.

I don't see any useful application for the other four flags.  I think
the driver should just ignore them.


Regards,
Clemens
