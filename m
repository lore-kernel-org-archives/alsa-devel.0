From: "Felipe F. Tonello" <eu@felipetonello.com>
Subject: [PATCH v6 0/2] amidi delay option
Date: Tue, 23 Aug 2016 15:09:36 +0100
Message-ID: <20160823140938.21423-1-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E2E22267E58
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 16:09:40 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id i5so18327665wmg.2
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 07:09:40 -0700 (PDT)
Received: from localhost.localdomain ([81.145.202.106])
 by smtp.gmail.com with ESMTPSA id us9sm4005204wjb.43.2016.08.23.07.09.39
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Aug 2016 07:09:39 -0700 (PDT)
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

changes from v5:
 * wait until MIDI message is competely sent to sleep

changes from v4:
 * simplified code

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

 amidi/amidi.1 | 14 ++++++++++
 amidi/amidi.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 79 insertions(+), 17 deletions(-)

-- 
2.9.3
