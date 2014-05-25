From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 00/49 v4] Enhancement for support of
	Firewire devices
Date: Sun, 25 May 2014 14:55:00 +0900
Message-ID: <538185B4.6010909@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CEBE26084B
 for <alsa-devel@alsa-project.org>; Sun, 25 May 2014 07:55:07 +0200 (CEST)
In-Reply-To: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Any reactions for this patchset?

(Apr 25 2014 22:44), Takashi Sakamoto wrote:
> This 49 patchset is to update previous series:
> [alsa-devel] [PATCH 00/44 v3] Enhancement of support for Firewire devices
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074624.html
> 
> 4 patches are newly added:
> [PATCH 09/48] dice/firewire-lib: Keep dualwire mode but obsolete CIP_HI_DUALWIRE
>  - Make firewire-lib simpler.
> [PATCH 10/48] firewire-lib/dice/speakers: Add common PCM constraints for AMDTP streams
>  - To share codes for drivers. Currently no improvement.
> [PATCH 25/48] fireworks/firewire-lib: Add a quirk to reset data block counter at bus reset
> [PATCH 46/48] bebob: Add a quirk of data blocks for MIDI messages for some M-Audio devices
>  - New quirks are identified.
> 
> For reviewers, you can see previous series in 'request_v3' branch of my remote repository.
> I hope this will help your work.
> 
> ----------------------------------------------------------------
> The following changes since commit 38137a064199a02630f136ce7bb1580d5d3fedeb:
> 
>   ALSA: lx_core: Translate comments from french to english (2014-04-18 09:57:03 +0200)
> 
> are available in the git repository at:
> 
>   https://github.com/takaswie/sound.git request_v4
> 
> for you to fetch changes up to e851b7740f218d5d5a8e957851b383bde3e28654:
> 
>   firewire/bebob: Add a workaround for M-Audio special Firewire series (2014-04-25 22:29:32 +0900)
> 
> ----------------------------------------------------------------
> Takashi Sakamoto (49):
>   firewire-lib: Rename functions, structure, member for AMDTP
>   firewire-lib: Add macros instead of fixed value for AMDTP
>   firewire-lib: Add 'direction' member to 'amdtp_stream' structure
>   firewire-lib: Split some codes into functions to reuse for both
>     streams
>   firewire-lib: Add support for AMDTP in-stream and PCM capture
>   firewire-lib: Add support for MIDI capture/playback
>   firewire-lib: Give syt value as parameter to handle_out_packet()
>   firewire-lib: Add support for duplex streams synchronization in
>     blocking mode
>   firewire-lib: Add support for channel mapping
>   dice/firewire-lib: Keep dualwire mode but obsolete CIP_HI_DUALWIRE
>   firewire-lib/dice/speakers: Add common PCM constraints for AMDTP
>     streams
>   firewire-lib: Restrict calling flush_context_completion() when context
>     exists
>   firewire-lib: Rename macros, variables and functions for CMP
>   firewire-lib: Add 'direction' member to 'cmp_connection' structure
>   firewire-lib: Add handling output connection by CMP
>   firewire-lib: Add a new function to check others' connection
>   firewire-lib: Add support for deferred transaction
>   firewire-lib: Add some AV/C general commands
>   fireworks: Add skelton for Fireworks based devices
>   fireworks: Add transaction and some commands
>   fireworks: Add connection and stream management
>   fireworks/firewire-lib: Add a quirk for empty packet with TAG0
>   fireworks/firewire-lib: Add a quirk for the meaning of dbc
>   fireworks/firewire-lib: Add a quirk for wrong dbs in tx packets
>   fireworks/firewire-lib: Add a quirk for fixed interval of reported dbc
>   fireworks/firewire-lib: Add a quirk to reset data block counter at bus
>     reset
>   fireworks: Add proc interface for debugging purpose
>   fireworks: Add MIDI interface
>   fireworks/firewire-lib: Add a quirk of data blocks for MIDI in
>     out-stream
>   fireworks: Add PCM interface
>   fireworks: Add hwdep interface
>   fireworks: Add command/response functionality into hwdep interface
>   bebob: Add skelton for BeBoB based devices
>   bebob: Add commands and connections/streams management
>   bebob/firewire-lib: Add a quirk for discontinuity at bus reset
>   bebob: Add proc interface for debugging purpose
>   bebob: Add MIDI interface
>   bebob: Add PCM interface
>   bebob: Add hwdep interface
>   bebob: Prepare for device specific operations
>   bebob: Add support for Terratec PHASE, EWS series and Aureon
>   bebob: Add support for Yamaha GO series
>   bebob: Add support for Focusrite Saffire/SaffirePro series
>   bebob: Add support for M-Audio usual Firewire series
>   bebob: Add support for M-Audio special Firewire series
>   bebob/firewire-lib: Add a quirk of wrong dbc in empty packet for
>     M-Audio special Firewire series
>   bebob: Add a quirk of data blocks for MIDI messages for some M-Audio
>     devices
>   bebob: Send a cue to load firmware for M-Audio Firewire series
>   firewire/bebob: Add a workaround for M-Audio special Firewire series
> 
>  drivers/firewire/core.h                          |    1 -
>  include/linux/firewire.h                         |    3 +
>  include/uapi/sound/asound.h                      |    4 +-
>  include/uapi/sound/firewire.h                    |   23 +-
>  sound/firewire/Kconfig                           |   59 ++
>  sound/firewire/Makefile                          |    2 +
>  sound/firewire/amdtp.c                           |  797 +++++++++++------
>  sound/firewire/amdtp.h                           |  200 ++++-
>  sound/firewire/bebob/Makefile                    |    4 +
>  sound/firewire/bebob/bebob.c                     |  472 ++++++++++
>  sound/firewire/bebob/bebob.h                     |  257 ++++++
>  sound/firewire/bebob/bebob_command.c             |  282 ++++++
>  sound/firewire/bebob/bebob_focusrite.c           |  279 ++++++
>  sound/firewire/bebob/bebob_hwdep.c               |  199 +++++
>  sound/firewire/bebob/bebob_maudio.c              |  792 +++++++++++++++++
>  sound/firewire/bebob/bebob_midi.c                |  168 ++++
>  sound/firewire/bebob/bebob_pcm.c                 |  378 ++++++++
>  sound/firewire/bebob/bebob_proc.c                |  196 +++++
>  sound/firewire/bebob/bebob_stream.c              | 1020 ++++++++++++++++++++++
>  sound/firewire/bebob/bebob_terratec.c            |   68 ++
>  sound/firewire/bebob/bebob_yamaha.c              |   50 ++
>  sound/firewire/cmp.c                             |  203 +++--
>  sound/firewire/cmp.h                             |   14 +-
>  sound/firewire/dice.c                            |   88 +-
>  sound/firewire/fcp.c                             |  189 +++-
>  sound/firewire/fcp.h                             |   21 +
>  sound/firewire/fireworks/Makefile                |    4 +
>  sound/firewire/fireworks/fireworks.c             |  357 ++++++++
>  sound/firewire/fireworks/fireworks.h             |  232 +++++
>  sound/firewire/fireworks/fireworks_command.c     |  372 ++++++++
>  sound/firewire/fireworks/fireworks_hwdep.c       |  298 +++++++
>  sound/firewire/fireworks/fireworks_midi.c        |  168 ++++
>  sound/firewire/fireworks/fireworks_pcm.c         |  403 +++++++++
>  sound/firewire/fireworks/fireworks_proc.c        |  232 +++++
>  sound/firewire/fireworks/fireworks_stream.c      |  372 ++++++++
>  sound/firewire/fireworks/fireworks_transaction.c |  326 +++++++
>  sound/firewire/speakers.c                        |  100 +--
>  37 files changed, 8173 insertions(+), 460 deletions(-)
>  create mode 100644 sound/firewire/bebob/Makefile
>  create mode 100644 sound/firewire/bebob/bebob.c
>  create mode 100644 sound/firewire/bebob/bebob.h
>  create mode 100644 sound/firewire/bebob/bebob_command.c
>  create mode 100644 sound/firewire/bebob/bebob_focusrite.c
>  create mode 100644 sound/firewire/bebob/bebob_hwdep.c
>  create mode 100644 sound/firewire/bebob/bebob_maudio.c
>  create mode 100644 sound/firewire/bebob/bebob_midi.c
>  create mode 100644 sound/firewire/bebob/bebob_pcm.c
>  create mode 100644 sound/firewire/bebob/bebob_proc.c
>  create mode 100644 sound/firewire/bebob/bebob_stream.c
>  create mode 100644 sound/firewire/bebob/bebob_terratec.c
>  create mode 100644 sound/firewire/bebob/bebob_yamaha.c
>  create mode 100644 sound/firewire/fireworks/Makefile
>  create mode 100644 sound/firewire/fireworks/fireworks.c
>  create mode 100644 sound/firewire/fireworks/fireworks.h
>  create mode 100644 sound/firewire/fireworks/fireworks_command.c
>  create mode 100644 sound/firewire/fireworks/fireworks_hwdep.c
>  create mode 100644 sound/firewire/fireworks/fireworks_midi.c
>  create mode 100644 sound/firewire/fireworks/fireworks_pcm.c
>  create mode 100644 sound/firewire/fireworks/fireworks_proc.c
>  create mode 100644 sound/firewire/fireworks/fireworks_stream.c
>  create mode 100644 sound/firewire/fireworks/fireworks_transaction.c
