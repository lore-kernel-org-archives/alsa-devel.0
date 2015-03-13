From: Adam Goode <agoode@google.com>
Subject: Adding new (old) SNDRV_SEQ_PORT_TYPE_MIDI_* defines
Date: Thu, 12 Mar 2015 20:36:19 -0400
Message-ID: <CAOf41NnyZRX5B9TfGQvTq26-3x7NefsRETJ4SESE5uXFYSxUtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f181.google.com (mail-vc0-f181.google.com
 [209.85.220.181])
 by alsa0.perex.cz (Postfix) with ESMTP id D00252658BA
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 01:36:40 +0100 (CET)
Received: by mail-vc0-f181.google.com with SMTP id hq12so6702436vcb.12
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 17:36:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I found the /* TODO: read port flags from descriptors */ in
sound/usb/midi.c and was thinking about what to do to implement this.

The first thing to do would be to ensure that all the flags from the
element descriptors in the USB MIDI standard are available for returning
from snd_seq_port_info_get_type.

USB MIDI (see page 23):
http://www.usb.org/developers/docs/devclass_docs/midi10.pdf

I propose adding these flags to ALSA:

#define SNDRV_SEQ_PORT_TYPE_MIDI_CLOCK  (1<<7)  /* MIDI CLOCK compatible
device */
#define SNDRV_SEQ_PORT_TYPE_MIDI_TIME_CODE (1<<8) /* MTC compatible device
*/
#define SNDRV_SEQ_PORT_TYPE_MIDI_MACHINE_CONTROL (1<<9) /* MMC compatible
device */
#define SNDRV_SEQ_PORT_TYPE_MIDI_EFX    (1<<21) /* Audio effects processor
device */
#define SNDRV_SEQ_PORT_TYPE_MIDI_PATCH_BAY (1<<22) /* MIDI patcher or
router device */
#define SNDRV_SEQ_PORT_TYPE_MIDI_DLS1   (1<<23) /* DownLoadable Sounds
Standard Level 1 compatible device */
#define SNDRV_SEQ_PORT_TYPE_MIDI_DLS2   (1<<24) /* DownLoadable Sounds
Standard Level 2 compatible device */


Thoughts? I can send a couple patches for the kernel and alsa-lib. I don't
think this is a breaking change.


Thanks,

Adam
