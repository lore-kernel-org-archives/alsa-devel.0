From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/7] Constify snd_rawmidi_ops
Date: Thu, 12 Jan 2017 20:47:07 +0900
Message-ID: <3e8196d7-c236-43cc-eec6-84e613469a6d@sakamocchi.jp>
References: <20170111190242.12585-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 1D6A9266860
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2017 12:47:10 +0100 (CET)
In-Reply-To: <20170111190242.12585-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Jan 12 2017 04:02, Takashi Iwai wrote:
> this is a small patchset to constify snd_rawmidi_ops references, as
> already done for many other ops.
>
>
> Takashi
>
> ==
>
> Takashi Iwai (7):
>   ALSA: rawmidi: Add const to snd_rawmidi_ops
>   ALSA: seq: Constify snd_rawmidi_ops
>   ALSA: drivers: Constify snd_rawmidi_ops
>   ALSA: isa: Constify snd_rawmidi_ops
>   ALSA: pci: Constify snd_rawmidi_ops
>   ALSA: firewire: Constify snd_rawmidi_ops
>   ALSA: usb: Constify snd_rawmidi_ops

I prefer this patchset. I reviewed all of them and did build check.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

>  include/sound/rawmidi.h                   | 4 ++--
>  include/sound/snd_wavefront.h             | 4 ++--
>  sound/core/rawmidi.c                      | 2 +-
>  sound/core/seq/seq_virmidi.c              | 4 ++--
>  sound/drivers/mpu401/mpu401_uart.c        | 4 ++--
>  sound/drivers/mtpav.c                     | 4 ++--
>  sound/drivers/mts64.c                     | 4 ++--
>  sound/drivers/portman2x4.c                | 4 ++--
>  sound/drivers/serial-u16550.c             | 4 ++--
>  sound/firewire/bebob/bebob_midi.c         | 4 ++--
>  sound/firewire/dice/dice-midi.c           | 4 ++--
>  sound/firewire/digi00x/digi00x-midi.c     | 8 ++++----
>  sound/firewire/fireworks/fireworks_midi.c | 4 ++--
>  sound/firewire/oxfw/oxfw-midi.c           | 4 ++--
>  sound/firewire/oxfw/oxfw-scs1x.c          | 4 ++--
>  sound/firewire/tascam/tascam-midi.c       | 4 ++--
>  sound/isa/gus/gus_uart.c                  | 4 ++--
>  sound/isa/msnd/msnd_midi.c                | 2 +-
>  sound/isa/sb/sb8_midi.c                   | 4 ++--
>  sound/isa/wavefront/wavefront_midi.c      | 4 ++--
>  sound/pci/ca0106/ca_midi.c                | 4 ++--
>  sound/pci/cs4281.c                        | 4 ++--
>  sound/pci/cs46xx/cs46xx_lib.c             | 4 ++--
>  sound/pci/echoaudio/midi.c                | 4 ++--
>  sound/pci/emu10k1/emu10k1x.c              | 4 ++--
>  sound/pci/emu10k1/emumpu401.c             | 4 ++--
>  sound/pci/ens1370.c                       | 4 ++--
>  sound/pci/ice1712/ice1724.c               | 4 ++--
>  sound/pci/rme9652/hdsp.c                  | 4 ++--
>  sound/pci/rme9652/hdspm.c                 | 4 ++--
>  sound/usb/6fire/midi.c                    | 4 ++--
>  sound/usb/bcd2000/bcd2000.c               | 4 ++--
>  sound/usb/caiaq/midi.c                    | 4 ++--
>  sound/usb/line6/midi.c                    | 4 ++--
>  sound/usb/midi.c                          | 4 ++--
>  35 files changed, 70 insertions(+), 70 deletions(-)

Thanks

Takashi Sakamoto
