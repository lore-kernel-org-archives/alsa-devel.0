From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 0/2] USB audio fixes
Date: Fri, 14 Aug 2015 17:19:41 -0500
Message-ID: <1439590783-3635-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 939D3266189
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 00:19:51 +0200 (CEST)
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

While trying to understand how asynchronous endpoints are supported, I
identified two major issues. On my M-Audio transit, the following
script tries to play using the 3 different endpoints supported and
fails (error and no audio) after the first playback without the
patches. With the patches on top of 4.1.5 or Takashi's for-next
(4.2.0-rc5), I stopped the audio after an hour.

while true
do
    aplay -d5 -Dhw:2,0 ~/16_48.wav # play 48kHz, 16 bit on async ep
    aplay -d5 -Dhw:2,0 ~/24_48.wav # play 48kHz, 24 bit on 'none'/async ep
    aplay -d5 -Dhw:2,0 ~/24_96.wav # play 96 kHz, 24 bit on adaptive ep
    aplay -d5 -Dhw:2,0 ~/24_48.wav 
    aplay -d5 -Dhw:2,0 ~/16_48.wav
    aplay -d5 -Dhw:2,0 ~/24_96.wav
done

The first issue is pretty bad with corrupted pointers. When
transitioning from a alternate setting with a sync_endpoint to another
which doesn't have one by construction (synchronous, adaptive, async
on capture), the pointers are not reset and the code tries to set the
parameters of a non-existent endpoint.

The second issue is that the M-audio Transit descriptors are illegal
but the logic can be changed without harm.

I sometimes hear noise on playback start, probably the code needs to
be changed to add enough silent samples to let the PLL lock. I haven't
had time to work on this and this is more of an enhancement.

v2: applied Takashi's comments
    unconditional clean-up of sync_endpoint pointers
    better logical tests and removal of goto

Pierre-Louis Bossart (2):
  ALSA: usb: fix corrupted pointers due to interface setting change
  ALSA: usb: handle descriptor with SYNC_NONE illegal value

 sound/usb/pcm.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

-- 
1.9.1
