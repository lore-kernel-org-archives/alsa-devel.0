From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH v2 0/3] timer/hwdep: update included
	headers with UAPI headers in recent kernel
Date: Sat, 22 Apr 2017 00:27:58 +0900
Message-ID: <20170421152801.19649-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id DAAE826719D
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 17:28:07 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

In this subsystem, interfaces between kernel/userspace are described in
UAPI headers of kernel source. User space library (alsa-lib) includes
this header as its code base. When developers update UAPI headers in
development cycle of kernel, corresponding headers in alsa-lib should be
updated synchronously.

The purpose of this patchset is to catch up recent UAPI header for
userspace library. There're missing changes added at v4.7, v4.9 and v4.12
development period.

v2 changes:
 - Update commit description.
 - Reorder commits so that aligned according to date of corresponding code
   change.

Takashi Sakamoto (3):
  timer: obsolete legacy rtctimer instance
  hwdep: add Line6 USB series support
  hwdep: add support for MOTU FireWire series and RME Fireface series

 include/hwdep.h        | 5 ++++-
 include/sound/asound.h | 7 +++++--
 include/timer.h        | 2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.9.3
