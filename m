From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH v2 0/2] amidi: fix handling of ignored messages
Date: Sat, 13 Aug 2016 16:40:43 +0200
Message-ID: <7105f8ec-be96-04af-45b0-e86326e1cf62@ladisch.de>
References: <ac3f1f9a-5201-7a98-e659-fd9bbcf41ab7@ladisch.de>
 <bde1ef45-8255-5ca7-01fc-5dbf0b8f3684@ladisch.de>
 <b630d5ab-da0d-d92f-010b-b8c8e4698be7@sakamocchi.jp>
 <7982b196-edae-3330-86a8-83338e182f3e@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 92A49265D88
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2016 16:42:20 +0200 (CEST)
In-Reply-To: <7982b196-edae-3330-86a8-83338e182f3e@sakamocchi.jp>
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

v2: fix short_options

 amidi/amidi.1 |   19 ++++++++---
 amidi/amidi.c |   84 ++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 79 insertions(+), 24 deletions(-)
