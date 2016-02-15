From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 0/5] alsa-lib: add APIs for control
	element set
Date: Mon, 15 Feb 2016 22:33:08 +0900
Message-ID: <1455543193-28109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id A6C37261692
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 14:33:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset adds some APIs for control element set, according to design of
ALSA Ctl core.


In ALSA Ctl core, each sound card can have control elements. The elements
are managed according to below design.

* element set
  * A set of elements with the same attribute (i.e. name, get/put operations).
* element
  * An element can be identified by userspace applications.
* channel
  * An element has channels which can be changed by userspace applications or
    hardware device itself.
* value
  * Each channel has its own value. The place to kept the value depends on
    design of each device driver (i.e. in hardware register or kernel space).

There're two ways to identify the element; by identification number (numid), or
by a combination of name of the element set and index from the first element in
the element set.

Both of device driver in kernel land and ALSA Ctl application in user land can
add the element set. When userspace applications add them, ALSA Ctl core works
as Inter Process Communication mechanism between event-listening applications
and usual control applications. Such element is refered as 'user-defined
control elements' in alsa-lib.

Typically, device driver in kernel land adds one element set for a single
element. So users and userspace developers are hard to realize that an existence
of the element set.

There're more items to describe the design. But here I focus on what relates to
this patchset.


Well, current alsa-lib implementation includes small bugs, some misleadings,
a lack of feature related to user-defined control elements. This patchset is
my attempt to improves such issues.


Regards

Takashi Sakamoto (5):
  control: initialize element channel values according to identification
    number
  control: rename variables so that it represents the number of channels
    which an element has
  control: improve API documentation
  control: add a function to add an element of bytes type
  control: add functions to add element set

 include/control.h     |  35 +++-
 src/control/control.c | 484 +++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 413 insertions(+), 106 deletions(-)

-- 
2.5.0
