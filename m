From: "Felipe F. Tonello" <eu@felipetonello.com>
Subject: [PATCH v2 0/2] amidi delay option
Date: Fri, 12 Aug 2016 17:04:33 +0100
Message-ID: <20160812160435.27364-1-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 42AF4267350
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 18:04:37 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id i138so3669087wmf.3
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 09:04:37 -0700 (PDT)
Received: from localhost.localdomain ([81.145.202.106])
 by smtp.gmail.com with ESMTPSA id m62sm3110496wmm.24.2016.08.12.09.04.35
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 12 Aug 2016 09:04:35 -0700 (PDT)
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

Small improvement to amidi, adding useful functionality.

changes from v1:
 * remove delay in between any MIDI message, only SysEx
 * added patch to use getopt_long() arguments

Felipe F. Tonello (2):
  amidi: add delay option
  amidi: use GNU getopt_long() proper argument names

 amidi/amidi.1 | 14 +++++++++++++
 amidi/amidi.c | 66 ++++++++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 64 insertions(+), 16 deletions(-)

-- 
2.9.2
