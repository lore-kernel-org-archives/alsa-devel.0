From: Ard van Breemen <ard@kwaak.net>
Subject: [PATCH 0/2] ALSA snd-usb-audio: Add Pioneer DDJ-SX3
	PCM support
Date: Fri,  2 Aug 2019 13:52:13 +0200
Message-ID: <20190802115215.311-1-ard@kwaak.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kwaak.net (gw-fsck-sorbs.kwaak.net [82.197.218.155])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D537CF80114
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2019 13:52:39 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Ard van Breemen <ard@kwaak.net>
List-Id: alsa-devel@alsa-project.org

The Pioneer lacks the UAC descriptors (added to quircks). It also needs
a fix in synchronisation handling for those cases that
bSynchAddress == 0

Ard van Breemen (2):
  Skip bSynchAddress endpoint check if it is invalid.
  Add Pioneer DDJ-SX3 PCM quirck.

 sound/usb/pcm.c          |  1 +
 sound/usb/quirks-table.h | 57 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

-- 
2.17.1
