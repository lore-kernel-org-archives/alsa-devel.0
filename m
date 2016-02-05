From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: firewire-tascam: add support for
	FW-1804
Date: Fri,  5 Feb 2016 09:56:04 +0900
Message-ID: <1454633768-17729-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A733260577
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 01:56:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset adds support for FW-1804. Additionally it fix some bugs.
Nothing else ;)

This commit also adds no functionality to control internal multiplexer
of supported models, following to basic design of ALSA firewire stack.
It should be implemented in userspace. Currently, there's no udev rules
for fw character devices corresponding to models supported by this
module. Thus, permission of the devices may be 0600. When userspace
applications touches the devices, they needs effective UID or GID as 0.
This is not better environment for users. Further works are required
for related softwares.


Regards

Takashi Sakamoto (4):
  ALSA: firewire-tascam: fix NULL pointer dereference when model
    identification fails
  ALSA: firewire-tascam: add support for FW-1804
  ALSA: firewire-tascam: remove a flag for controller
  ALSA: firewire-tascam: remove needless member for control and status
    message

 sound/firewire/tascam/tascam-transaction.c |  6 ++++++
 sound/firewire/tascam/tascam.c             | 12 +++++++++---
 sound/firewire/tascam/tascam.h             |  4 ----
 3 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.5.0
