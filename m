From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 0/4] add Studio Evolution SE6X support
Date: Fri, 16 Jan 2015 22:13:15 +0100
Message-ID: <54B97EEB.8060108@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 431C0260427
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 22:14:06 +0100 (CET)
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

This is a driver for an unimportant sound card, and related
changes in the support code.  Please apply to -next.


 sound/pci/Kconfig               |    9 +
 sound/pci/oxygen/Makefile       |    2
 sound/pci/oxygen/oxygen.h       |    2
 sound/pci/oxygen/oxygen_lib.c   |   26 ++++-
 sound/pci/oxygen/oxygen_mixer.c |   36 +++++++
 sound/pci/oxygen/oxygen_pcm.c   |   45 ++++++++-
 sound/pci/oxygen/se6x.c         |  160 ++++++++++++++++++++++++++++++++
 7 files changed, 272 insertions(+), 8 deletions(-)
