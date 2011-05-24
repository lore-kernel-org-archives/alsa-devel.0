From: Ben Gardiner <bengardiner-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
Subject: [PATCH 0/6] ASoC: davinci-pcm: some fixes and convert to BATCH
Date: Tue, 24 May 2011 14:50:14 -0400
Message-ID: <cover.1306258759.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, davinci-linux-open-source
Cc: Steven Faludi <stevenfaludi-ScDXFp4xN3PN+rMO2ozGnw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patchset is a collection of changes for the davinci-pcm driver that were
accumulated during previous forays into the davinci-mcasp and davinci-pcm
drivers [1].

The first three patches are minor changes that cleanup the ping-pong DMA params
setup, expand the davinci-pcm reported format and also its maximum channels.

The fourth patch in the series corrects an audible glitch that can be heard on
da850evm's McASP when ping-pong buffers are enabled. The glitch occurs only
on the second and susequent playbacks, not the first. Reversing the order in
which the dma channels are started and moving the start to the trigger function
from the prepare function fixes the glitch.

The fifth and sixth patches in the series convert the davinci-pcm driver to
BATCH mode. 

I noticed that the davinci-pcm pointer function is returning a value that is 
retrieved from within the running EDMA channel's state -- which is contrary to
the warning in the comments of arch/arm/mach-davinci/dma.c:edma_get_position():

"
 * Returns current source and destination addresses for a particular
 * parameter RAM slot.  Its channel should not be active when this is called.
"

To that end, we begin with some refactoring to centralize the modification of
the davinci_runtime_data.period member.

Followed by wholesale replacement of davinci_pcm_pointer() function so that it
returns the position as reported by the last update of the period member --
along with corresponding changes to davinci_pcm_enqueue_dma()
davinci_pcm_dma_irq() davinci_pcm_trigger() and reporting SNDRV_PCM_INFO_BATCH
on playback and capture.

The series has been tested with and without ping-pong buffers enabled [1];
furthermore, the pointer behaviour was inspected using both
XRUN_DEBUG_PERIODUPDATE and XRUN_DEBUG_HWPTRUPDATE as well as the audio checked
with headphones.

Playback was tested with:

echo 24 > /proc/asound/EVM/pcm0p/xrun_debug
aplay -d 1 -t wav -D "default:CARD=EVM" test.wav
echo 0 > /proc/asound/EVM/pcm0p/xrun_debug

and capture was tested with (while playing test.wav on my PC into the capture
input on the da850evm): 

#!/bin/bash
echo 24 > /proc/asound/EVM/pcm0c/xrun_debug
arecord -d 2 -t wav -D "default:CARD=EVM" -f dat - |aplay -t wav
echo 0 > /proc/asound/EVM/pcm0c/xrun_debug

Playback behaviour before (similar both with and without ping-pong buffers)
=========================
hwptr_update: pcmC0D0p:0: pos=42/2048/32768, hwptr=42/0/42/0
hwptr_update: pcmC0D0p:0: pos=369/2048/32768, hwptr=327/42/369/0
hwptr_update: pcmC0D0p:0: pos=709/2048/32768, hwptr=340/369/709/0
hwptr_update: pcmC0D0p:0: pos=994/2048/32768, hwptr=285/709/994/0
hwptr_update: pcmC0D0p:0: pos=1367/2048/32768, hwptr=373/994/1367/0
hwptr_update: pcmC0D0p:0: pos=1729/2048/32768, hwptr=362/1367/1729/0
hwptr_update: pcmC0D0p:0: pos=2037/2048/32768, hwptr=308/1729/2037/0
period_update: pcmC0D0p:0: pos=2335/2048/32768, hwptr=298/2037/2335/0
hwptr_update: pcmC0D0p:0: pos=2762/2048/32768, hwptr=427/2335/2762/0
hwptr_update: pcmC0D0p:0: pos=3147/2048/32768, hwptr=385/2762/3147/0
hwptr_update: pcmC0D0p:0: pos=3456/2048/32768, hwptr=309/3147/3456/0
hwptr_update: pcmC0D0p:0: pos=3851/2048/32768, hwptr=395/3456/3851/0
period_update: pcmC0D0p:0: pos=4150/2048/32768, hwptr=299/3851/4150/0
[...]

Playback behaviour after (identical both with and without ping-pong buffers)
========================
hwptr_update: pcmC0D0p:0: pos=0/2048/32768, hwptr=0/0/0/0
period_update: pcmC0D0p:0: pos=2048/2048/32768, hwptr=2048/0/2048/0
hwptr_update: pcmC0D0p:0: pos=2048/2048/32768, hwptr=0/2048/2048/0
period_update: pcmC0D0p:0: pos=4096/2048/32768, hwptr=2048/2048/4096/0
[...]

[Capture behaviour was very similarly modified by this patchset]

The playback behaviour before shows inconsistent increments of the pointers
in syscall and interrupt context -- this is due to the pointer function
peeking into the parameters of the dma channel.

The playback behaviour afterwards shows regular increments from interrupt
context. Which is to be expected since the driver now reports an incremented
pointer after each dma completion. 

It seems that the conversion to BATCH mode is beneficial -- other than
obeying the warning comment in dma.c -- since there appear to be fewer
syscalls per execution of aplay.

[1] http://article.gmane.org/gmane.linux.alsa.devel/85122

Ben Gardiner (6):
  ASoC: davinci-pcm: trivial: make ping-pong params setup symmetrical
  ASoC: davinci-pcm: expand the .formats
  ASoC: davinci-pcm: increase the maximum channels
  ASoC: davinci-pcm: fix audible glitch on 2nd ping-pong playback
  ASoC: davinci-pcm: extract period elapsed functions
  ASoC: davinci-pcm: convert to BATCH mode

 sound/soc/davinci/davinci-pcm.c |  127 ++++++++++++++++++++-------------------
 1 files changed, 65 insertions(+), 62 deletions(-)

-- 
1.7.4.1
