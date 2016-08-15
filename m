From: "Felipe F. Tonello" <eu@felipetonello.com>
Subject: [PATCH v4 0/2] amidi delay option
Date: Mon, 15 Aug 2016 17:33:03 +0100
Message-ID: <20160815163305.13301-1-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D9B1266620
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 18:33:08 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id i138so11921177wmf.3
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 09:33:08 -0700 (PDT)
Received: from localhost.localdomain ([81.145.202.106])
 by smtp.gmail.com with ESMTPSA id yz6sm22299547wjb.35.2016.08.15.09.33.06
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Aug 2016 09:33:06 -0700 (PDT)
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

changes from v3:
 * fixed a bug if memchr() returns NULL

changes from v2:
 * only check of end of sysex (0xf7)
 * use memchr() instead of direct loop approach
 * fixed commit message

changes from v1:
 * remove delay in between any MIDI message, only SysEx
 * added patch to use getopt_long() arguments

Felipe F. Tonello (2):
  amidi: add delay option
  amidi: use GNU getopt_long() proper argument names

 amidi/amidi.1 | 14 +++++++++++++
 amidi/amidi.c | 63 ++++++++++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 61 insertions(+), 16 deletions(-)

-- 
2.9.3
