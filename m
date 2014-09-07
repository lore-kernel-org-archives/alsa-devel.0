From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 0/5] miscellaneous patches for 3.18
Date: Sun, 07 Sep 2014 21:42:24 +0200
Message-ID: <540CB520.50909@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id DFAF62608C7
 for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2014 21:41:34 +0200 (CEST)
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

 sound/core/pcm_lib.c             |   10 ++++++----
 sound/pci/oxygen/xonar_pcm179x.c |   33 +++++++++++++++++++++++----------
 sound/usb/midi.c                 |   11 +++++++++++
 3 files changed, 40 insertions(+), 14 deletions(-)
