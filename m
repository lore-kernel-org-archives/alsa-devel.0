From: grygorii tertychnyi <gtertych@cisco.com>
Subject: [PATCH] ALSA: msnd: Optimize / harden DSP and MIDI loops
Date: Fri,  8 Sep 2017 09:06:25 -0700
Message-ID: <20170908160626.24771-1-gtertych@cisco.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: tiwai@suse.de, xe-linux-external@cisco.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, grygorii tertychnyi <gtertych@cisco.com>
List-Id: alsa-devel@alsa-project.org

Hi Greg,

Could you please apply it for 4.4-stable.
This fixes https://nvd.nist.gov/vuln/detail/CVE-2017-9985

Takashi Iwai (1):
  ALSA: msnd: Optimize / harden DSP and MIDI loops

 sound/isa/msnd/msnd_midi.c     | 30 +++++++++++++++---------------
 sound/isa/msnd/msnd_pinnacle.c | 23 ++++++++++++-----------
 2 files changed, 27 insertions(+), 26 deletions(-)

-- 
2.10.3.dirty
