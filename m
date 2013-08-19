From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/3] HDSPM: Fix LTC ioctl
Date: Mon, 19 Aug 2013 17:20:29 +0200
Message-ID: <1376925632-5831-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

This series fixes the broken LTC ioctl to query the TCO. Apparently,
nobody ever attempted to use the code, otherwise, this rather obvious
problem would have been spotted way earlier. This is maybe because not
too many people happen to have a TV studio around to make use of this
feature. ;)

I'll also send a patch to fix alsa-lib.


Cheers

Adrian Knoth (3):
  ALSA: hdspm - Fix default value in SNDRV_HDSPM_IOCTL_GET_LTC
  ALSA: hdspm - Use enums in hdspm_tco_ltc_frames()
  ALSA: hdspm - Fix SNDRV_HDSPM_IOCTL_GET_LTC

 include/uapi/sound/hdspm.h |  2 +-
 sound/pci/rme9652/hdspm.c  | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
1.8.3.2
