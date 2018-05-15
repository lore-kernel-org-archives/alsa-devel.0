From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 0/6] control: optimization for
	position offset macro of TLV data
Date: Tue, 15 May 2018 21:36:33 +0900
Message-ID: <20180515123639.18255-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id BBB61266F4E
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 14:37:14 +0200 (CEST)
Received: by mail-pg0-f66.google.com with SMTP id a13-v6so6974972pgu.4
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 05:37:14 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

In development period for Linux v4.18, a series of SNDRV_CTL_TLVO_XXX
macro was introduced to kernel stuffs for position offset of TLV data.

This patchset backports the macros to this library as well as adds code
optimization with them.

Takashi Sakamoto (6):
  control: add a series of macro for offset of several types of TLV
  control: use position offset macro of TLV data
  hcontrol: use position offset macro of TLV data
  pcm: hw: use position offset macro of TLV data
  pcm: softvol: use position offset macro of TLV data
  test: use position offset macro of TLV data

 include/sound/tlv.h         | 16 ++++++++++
 src/control/control.c       | 12 ++++----
 src/control/control_hw.c    |  6 ++--
 src/control/control_local.h |  1 +
 src/control/hcontrol.c      |  4 +--
 src/control/tlv.c           | 72 ++++++++++++++++++++++++---------------------
 src/pcm/pcm_hw.c            | 10 ++++---
 src/pcm/pcm_softvol.c       | 11 ++++---
 test/user-ctl-element-set.c |  2 +-
 9 files changed, 83 insertions(+), 51 deletions(-)

-- 
2.14.1
