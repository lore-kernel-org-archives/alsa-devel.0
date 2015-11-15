From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 0/3] various USB MIDI workarounds
Date: Sun, 15 Nov 2015 22:36:45 +0100
Message-ID: <5648FAED.8020300@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 8979E2606FE
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 22:37:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Just a bunch of MIDI quirks, with various degrees of quirkiness.

 sound/usb/midi.c         |   46 +++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks-table.h |   11 +++++++++
 sound/usb/quirks.c       |    1
 sound/usb/usbaudio.h     |    1
 4 files changed, 59 insertions(+)
