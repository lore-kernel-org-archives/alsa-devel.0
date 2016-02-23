From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 0/6] control: add APIs for control
	element set
Date: Tue, 23 Feb 2016 09:48:24 +0900
Message-ID: <1456188510-7189-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 632C32606A0
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2016 01:48:35 +0100 (CET)
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

This patchset adds some APIs for control element set, according to design
of ALSA control core. Additionally, for the APIs, some API documentation is
improved.


In ALSA control core, each sound card can have control elements. The
elements are managed according to below design.

* element set
  * A set of elements with the same attribute (i.e. name, get/put
    operations). Some element sets can be added to a sound card. [0]
* element
  * An element can be identified by userspace applications.
* channel
  * An element has channels which can be changed by userspace applications
    or hardware device itself.
* value
  * Each channel has its own value. The place to kept the value depends on
    design of each device driver (i.e. in hardware register or kernel
    space).

There're two ways to identify the element; by identification number(numid),
or by a combination of name of the element set and index from the first
element in the element set [1].

Both of device drivers in kernel land and ALSA control applications in user
land can add the element set. When userspace applications add them, ALSA
control core works as Inter Process Communication mechanism between
event-listening applications and usual control applications. Such element
is referred as 'user-defined control elements' in alsa-lib.

Typically, device drivers in kernel land adds one element set for a single
element. So users and userspace developers are hard to realize that an
existence of the element set.

There are more items to describe the design. But here I focus on what
relates to this patchset.


Well, current alsa-lib implementation includes small bugs, some misleadings,
a lack of feature related to user-defined control elements. This patchset is
my attempt to improves them.


[0] In kernel, the element set is represented by 'struct snd_kcontrol'.
Some developers call it as 'kernel control'. The others call it as
'control group'. Here, I suggest 'element set', because from userspace the
'struct snd_kcontrol' is not visible and any elements are just visible.
Furthermore, I'd like to use unique name against Linux control groups.

[1] Actually, when identifying an element according to name/index pair,
the other members of 'struct snd_ctl_elem_id' such as iface, device and
subdevice are required. They're required to seek element set, then index
is used to find an element.

Regards


Takashi Sakamoto (6):
  control: rename variables so that it represents the number of channels
    which an element has
  control: improve API documentation for functions to add elements
  control: improve API documentation for functions to set/get channel
    values for an element
  control: rename variables so that it represents a channel in element
  control: add a function to add an element of bytes type
  control: add functions to add element set

 include/control.h     |  55 +++--
 src/control/control.c | 589 ++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 487 insertions(+), 157 deletions(-)

-- 
2.5.0
