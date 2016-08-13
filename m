From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 0/2] amidi: fix handling of ignored messages
Date: Sat, 13 Aug 2016 12:27:09 +0200
Message-ID: <ac3f1f9a-5201-7a98-e659-fd9bbcf41ab7@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 1908826600E
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2016 12:28:47 +0200 (CEST)
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

Clemens Ladisch (2):
      amidi: ignore not only Active Sensing but also Clock bytes
      amidi: fix timeout handling

 amidi/amidi.1 |   19 ++++++++---
 amidi/amidi.c |   82 +++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 78 insertions(+), 23 deletions(-)
