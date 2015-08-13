From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/25] ALSA: support AMDTP variants
Date: Thu, 13 Aug 2015 09:32:17 +0900
Message-ID: <55CBE591.8090906@sakamocchi.jp>
References: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 471F52660B4
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 02:32:23 +0200 (CEST)
In-Reply-To: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Aug 13 2015 09:19, Takashi Sakamoto wrote:
> Takashi Sakamoto (25):
>   ALSA: firewire-lib: rename 'amdtp' to 'amdtp-stream' for functional
>     separation
>   ALSA: firewire-lib: functional separation for packet transmission
>     layer and data processing layer

This patch (0002) is a bit large for this ML...

You can see this patchset as a part of this branch. Please refer to the
branch if the patch is not blasted.
https://github.com/takaswie/sound/tree/amdtp-variants


Regards

Takashi Sakamoto

>   ALSA: firewire-lib: add helper functions for asynchronous MIDI port
>   ALSA: firewire-lib: add a restriction for a transaction at once
>   ALSA: firewire-lib: schedule tasklet again when MIDI substream has
>     rest of MIDI messages
>   ALSA: firewire-lib: add throttle for MIDI data rate
>   ALSA: firewire-lib: avoid endless loop to transfer MIDI messages at
>     fatal error
>   ALSA: firewire-digi00x: add skeleton for Digi 002/003 family
>   ALSA: firewire-digi00x: add data processing layer
>   ALSA: firewire-digi00x: add stream functionality
>   ALSA: firewire-digi00x: add proc node to show clock status
>   ALSA: firewire-digi00x: add PCM functionality
>   ALSA: firewire-digi00x: add MIDI functionality
>   ALSA: firewire-digi00x: add hwdep interface
>   ALSA: firewire-digi00x: add support for asynchronous messaging
>   ALSA: firewire-digi00x: add support for MIDI ports for machine control
>   ALSA: firewire-tascam: add skeleton for TASCAM FireWire series
>   ALSA: firewire-tascam: add a structure for model-dependent parameters.
>   ALSA: firewire-tascam: add proc node to show firmware information
>   ALSA: firewire-tascam: add data processing layer
>   ALSA: firewire-tascam: add streaming functionality
>   ALSA: firewire-tascam: add PCM functionality
>   ALSA: firewire-tascam: add transaction functionality
>   ALSA: firewire-tascam: add MIDI functionality
>   ALSA: firewire-tascam: add hwdep interface
> 
>  include/uapi/sound/asound.h                  |   4 +-
>  include/uapi/sound/firewire.h                |   9 +
>  sound/firewire/Kconfig                       |  27 ++
>  sound/firewire/Makefile                      |   4 +-
>  sound/firewire/amdtp-am824.c                 | 451 ++++++++++++++++++++++++
>  sound/firewire/amdtp-am824.h                 |  47 +++
>  sound/firewire/{amdtp.c => amdtp-stream.c}   | 375 ++++----------------
>  sound/firewire/{amdtp.h => amdtp-stream.h}   | 113 ++----
>  sound/firewire/bebob/bebob.h                 |   2 +-
>  sound/firewire/bebob/bebob_midi.c            |  16 +-
>  sound/firewire/bebob/bebob_pcm.c             |  12 +-
>  sound/firewire/bebob/bebob_stream.c          |  34 +-
>  sound/firewire/dice/dice-midi.c              |  16 +-
>  sound/firewire/dice/dice-pcm.c               |  12 +-
>  sound/firewire/dice/dice-stream.c            |  41 ++-
>  sound/firewire/dice/dice.h                   |   2 +-
>  sound/firewire/digi00x/Makefile              |   4 +
>  sound/firewire/digi00x/amdtp-dot.c           | 436 +++++++++++++++++++++++
>  sound/firewire/digi00x/digi00x-hwdep.c       | 200 +++++++++++
>  sound/firewire/digi00x/digi00x-midi.c        | 198 +++++++++++
>  sound/firewire/digi00x/digi00x-pcm.c         | 353 +++++++++++++++++++
>  sound/firewire/digi00x/digi00x-proc.c        |  99 ++++++
>  sound/firewire/digi00x/digi00x-stream.c      | 422 +++++++++++++++++++++++
>  sound/firewire/digi00x/digi00x-transaction.c | 137 ++++++++
>  sound/firewire/digi00x/digi00x.c             | 174 ++++++++++
>  sound/firewire/digi00x/digi00x.h             | 157 +++++++++
>  sound/firewire/fcp.c                         |   2 +-
>  sound/firewire/fireworks/fireworks.c         |  12 +-
>  sound/firewire/fireworks/fireworks.h         |   2 +-
>  sound/firewire/fireworks/fireworks_midi.c    |  16 +-
>  sound/firewire/fireworks/fireworks_pcm.c     |  10 +-
>  sound/firewire/fireworks/fireworks_stream.c  |   8 +-
>  sound/firewire/lib.c                         | 129 +++++++
>  sound/firewire/lib.h                         |  52 +++
>  sound/firewire/oxfw/oxfw-midi.c              |  16 +-
>  sound/firewire/oxfw/oxfw-pcm.c               |  10 +-
>  sound/firewire/oxfw/oxfw-stream.c            |  11 +-
>  sound/firewire/oxfw/oxfw.h                   |   2 +-
>  sound/firewire/tascam/Makefile               |   4 +
>  sound/firewire/tascam/amdtp-tascam.c         | 248 +++++++++++++
>  sound/firewire/tascam/tascam-hwdep.c         | 202 +++++++++++
>  sound/firewire/tascam/tascam-midi.c          | 162 +++++++++
>  sound/firewire/tascam/tascam-pcm.c           | 298 ++++++++++++++++
>  sound/firewire/tascam/tascam-proc.c          |  88 +++++
>  sound/firewire/tascam/tascam-stream.c        | 497 +++++++++++++++++++++++++++
>  sound/firewire/tascam/tascam-transaction.c   | 291 ++++++++++++++++
>  sound/firewire/tascam/tascam.c               | 230 +++++++++++++
>  sound/firewire/tascam/tascam.h               | 140 ++++++++
>  48 files changed, 5277 insertions(+), 498 deletions(-)
>  create mode 100644 sound/firewire/amdtp-am824.c
>  create mode 100644 sound/firewire/amdtp-am824.h
>  rename sound/firewire/{amdtp.c => amdtp-stream.c} (70%)
>  rename sound/firewire/{amdtp.h => amdtp-stream.h} (77%)
>  create mode 100644 sound/firewire/digi00x/Makefile
>  create mode 100644 sound/firewire/digi00x/amdtp-dot.c
>  create mode 100644 sound/firewire/digi00x/digi00x-hwdep.c
>  create mode 100644 sound/firewire/digi00x/digi00x-midi.c
>  create mode 100644 sound/firewire/digi00x/digi00x-pcm.c
>  create mode 100644 sound/firewire/digi00x/digi00x-proc.c
>  create mode 100644 sound/firewire/digi00x/digi00x-stream.c
>  create mode 100644 sound/firewire/digi00x/digi00x-transaction.c
>  create mode 100644 sound/firewire/digi00x/digi00x.c
>  create mode 100644 sound/firewire/digi00x/digi00x.h
>  create mode 100644 sound/firewire/tascam/Makefile
>  create mode 100644 sound/firewire/tascam/amdtp-tascam.c
>  create mode 100644 sound/firewire/tascam/tascam-hwdep.c
>  create mode 100644 sound/firewire/tascam/tascam-midi.c
>  create mode 100644 sound/firewire/tascam/tascam-pcm.c
>  create mode 100644 sound/firewire/tascam/tascam-proc.c
>  create mode 100644 sound/firewire/tascam/tascam-stream.c
>  create mode 100644 sound/firewire/tascam/tascam-transaction.c
>  create mode 100644 sound/firewire/tascam/tascam.c
>  create mode 100644 sound/firewire/tascam/tascam.h
