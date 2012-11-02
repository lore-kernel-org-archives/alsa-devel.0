From: "Lars R. Damerow" <lars@pixar.com>
Subject: [PATCH] ALSA: hda - support Teradici 2200 host card
	audio
Date: Fri,  2 Nov 2012 13:10:38 -0700
Message-ID: <1351887039-31760-1-git-send-email-lars@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smx.pixar.com (smx.pixar.com [12.25.180.94])
 by alsa0.perex.cz (Postfix) with ESMTP id 1307E2650ED
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 21:10:44 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org

Hello,

This patch adds support for Teradici's new Tera2 host card audio. The new card has the same audio chipset as the previous version, so all it's doing is recognizing the new PCI ID and treating it just like the previous one.

thanks,
-lars

Lars R. Damerow (1):
      ALSA: hda - support Teradici 2200 host card audio

 sound/pci/hda/hda_intel.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)
