From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] ALSA: control: fix issue of concurrent
	access of ELEM_READ/ELEM_WRITE
Date: Sun, 20 Aug 2017 13:49:05 +0900
Message-ID: <20170820044908.17972-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 44693266BCF
 for <alsa-devel@alsa-project.org>; Sun, 20 Aug 2017 06:49:16 +0200 (CEST)
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

This patchset is to fix an issue of concurrent access to operate
ELEM_READ/ELEM_WRITE, which I found in my previous patch:

[PATCH 0/5] ALSA: control: fix issue of concurrent access for TLV operations
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-August/123561.html

In current implementation of ALSA control core, concurrent accesses with 
ELEM_READ/ELEM_WRITE are managed with counting semaphore, however lock
acquisition for both of these operations is a type of 'read'. In this case,
ELEM_READ can be going to be handled for a target element when ELEM_WRITE
is handled for the element. A purpose of the ELEM_WRITE operation is to
change state of the target element. It's better to guarantee that
concurrent accesses to the same element with these two operations are
properly managed.

For the above aim, this patchset uses the counting semaphore as 'write'
lock for ELEM_WRITE operation. But I can imagine an discussion to add
'per-element' lock for this issue. In a comment of patch 03, I investigate
it. Please refer to it.

Takashi Sakamoto (3):
  ALSA: control: queue events within locking of controls_rwsem for
    ELEM_WRITE operation
  ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE operations
  ALSA: control: use counting semaphore as write lock for ELEM_WRITE
    operation

 sound/core/control.c | 78 +++++++++++++++++++++++++---------------------------
 1 file changed, 38 insertions(+), 40 deletions(-)

-- 
2.11.0
