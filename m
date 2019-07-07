From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/6] ALSA: firewire: fix wrong reference count
	for stream functionality at error path of rawmidi interface
Date: Sun,  7 Jul 2019 14:20:05 +0900
Message-ID: <20190707052011.24687-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B479EF800E6
 for <alsa-devel@alsa-project.org>; Sun,  7 Jul 2019 07:20:25 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

All of drivers in ALSA firewire stack maintain packet streaming by
reference count. However at error path of MIDI interface, some
drivers have a bug that the count remains at error path of rawmidi
interface. This causes the drivers don't stop packet streaming even
if it's not required.

This patchset fixes drivers including the bug.

Takashi Sakamoto (6):
  ALSA: bebob: fix wrong reference count for stream functionality at
    error path of rawmidi interface
  ALSA: fireworks: fix wrong reference count for stream functionality at
    error path of rawmidi interface
  ALSA: oxfw: fix wrong reference count for stream functionality at
    error path of rawmidi interface
  ALSA: dice: fix wrong reference count for stream functionality at
    error path of rawmidi interface
  ALSA: firewire-digi00x: fix wrong reference count for stream
    functionality at error path of rawmidi interface
  firewire-motu: fix wrong reference count for stream functionality at
    error path of rawmidi interface

 sound/firewire/bebob/bebob_midi.c         | 2 ++
 sound/firewire/dice/dice-midi.c           | 2 ++
 sound/firewire/digi00x/digi00x-midi.c     | 2 ++
 sound/firewire/fireworks/fireworks_midi.c | 2 ++
 sound/firewire/motu/motu-midi.c           | 2 ++
 sound/firewire/oxfw/oxfw-midi.c           | 2 ++
 6 files changed, 12 insertions(+)

-- 
2.20.1
