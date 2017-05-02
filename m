From: Thierry Escande <thierry.escande@collabora.com>
Subject: [PATCH 0/2] Add ACPI table for the ts3a227e driver
Date: Tue,  2 May 2017 12:11:07 +0200
Message-ID: <1493719869-16100-1-git-send-email-thierry.escande@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset = "utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Transfert-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

This series adds ACPI match table for the ts3a227e driver. The ts3a227e
is an Autonomous Audio Accessory Detection and Configuration Switch used
to detect audio accessory features like jack plugging and unplugging,
mic presence, and button pressed events.

This series also fixes a null pointer dereference occurring in the
TI max9890 driver when the ts3a227e hardware is present and its driver
probed. The jack detection was enabled in the ts3a227e driver before the
jack structure was allocated, causing the null pointer access.

Regards,
 Thierry

Fang, Yang A (1):
  ASoC: ts3a227e: add acpi table

Thierry Escande (1):
  ASoc: cht_bsw_max98090_ti: Fix jack initialization

 sound/soc/codecs/ts3a227e.c                  | 10 ++++++
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 52 +++++++++++++++++-----------
 2 files changed, 41 insertions(+), 21 deletions(-)

-- 
2.7.4
