From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: hda/ca0132: constify local symbols
Date: Tue, 15 May 2018 22:12:56 +0900
Message-ID: <20180515131300.24315-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f180.google.com (mail-pf0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 58210266F69
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 15:13:30 +0200 (CEST)
Received: by mail-pf0-f180.google.com with SMTP id x9-v6so37427pfm.2
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 06:13:30 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, conmanx360@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

This module has some local symbols which are read-only.

This commit adds 'const' qualifier to the symbols and applies
some code optimization.

Takashi Sakamoto (4):
  ALSA: hda/ca0132: constify templates for control element set
  ALSA: hda/ca0132: constify read-only members of string array
  ALSA: hda/ca0132: merge strings just for printk
  ALSA: hda/ca0132: constify parameter table for effects

 sound/pci/hda/patch_ca0132.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

-- 
2.14.1
