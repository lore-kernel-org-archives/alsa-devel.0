From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 0/3] hwdep: update included headers
	with UAPI headers in recent kernel
Date: Sat, 22 Apr 2017 00:08:17 +0900
Message-ID: <20170421150820.18199-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 3F4E5267101
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 17:08:25 +0200 (CEST)
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
updated.

The purpose of this patchset is to catch up recent UAPI header for
userspace library. There're missing changes added at v4.7, v4.9 and v4.12
development period.

Takashi Sakamoto (3):
  hwdep: add Line6 USB series support
  hwdep: add support for MOTU FireWire series and RME Fireface series
  timer: obsolete legacy rtctimer instance

 include/hwdep.h        | 5 ++++-
 include/sound/asound.h | 7 +++++--
 include/timer.h        | 2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.9.3
