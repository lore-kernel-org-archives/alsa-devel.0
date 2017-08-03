From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5] ALSA: control: fix issue of concurrent
	access for TLV operations
Date: Thu,  3 Aug 2017 20:20:39 +0900
Message-ID: <20170803112044.17138-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id C0D62267049
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 13:20:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

In a design of ALSA control core, each set of elements have data of
Type-Length-Value shape. This is called as TLV data. In ALSA control
interface, applications can three types of requests to elements about
TLV data; read, write and command.

In current implementation of ALSA control core, these three requests
are handled with read lock of a counting semaphore. However, this has an
issue of concurrent access because in theory write/command requests have
sub-effects to change state of the set of elements in a point of TLV data.
Read requests and write/command requests are handled exclusively as well
as each write/command requests.

This patchset is for this purpose. Additionally, this applies code
refactoring to TLV ioctl handler and TLV handler for user-defined element
set so that they get better shape for readers.

Takashi Sakamoto (5):
  ALSA: control: queue events within locking of controls_rwsem for TLV
    operation
  ALSA: control: use counting semaphore as write lock for TLV
    write/command operations
  ALSA: control: obsolete user_ctl_lock
  ALSA: control: code refactoring TLV ioctl handler
  ALSA: control: code refactoring for TLV request handler to user
    element set

 include/sound/core.h |   2 -
 sound/core/control.c | 252 +++++++++++++++++++++++++++++++--------------------
 sound/core/init.c    |   1 -
 3 files changed, 155 insertions(+), 100 deletions(-)

-- 
2.11.0
