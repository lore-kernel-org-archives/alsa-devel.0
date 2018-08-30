From: Jonathan Fether <jonf@mds.com>
Subject: [PATCH] Patch for sun4i-i2s driver to allow 24-bit
	audio
Date: Wed, 29 Aug 2018 17:32:49 -0700
Message-ID: <20180830003250.14076-1-jonf@mds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by alsa0.perex.cz (Postfix) with ESMTP id CDE762676BD
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2018 02:33:04 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id g23-v6so3023914plq.9
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 17:33:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Jonathan Fether <jonf@mds.com>
List-Id: alsa-devel@alsa-project.org

This patch adds 24-bit sample width support for the sun4i-i2s driver.

Jonathan Fether (1):
  ASoC: sun4i-i2s: Add 24-bit sample width support

 sound/soc/sunxi/sun4i-i2s.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

-- 
1.9.1
