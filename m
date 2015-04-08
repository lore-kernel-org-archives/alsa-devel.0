From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: ctl: fix userspace control element
	operations
Date: Thu,  9 Apr 2015 02:07:14 +0900
Message-ID: <1428512838-2493-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id EABB5265467
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 19:07:21 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patchset is to fix some issues related to operations for userspace
control element. Three patches are related to identical information,
the other is related to several element added by one operation.

Unfortunately, current alsa-lib has no functionality to achieve the
operation to add several element. To demonstrate this and test these
patches, I prepare for a small GObject introspection library, alsa-gir.
https://github.com/takaswie/alsa-gir

This reposiroty includes sample scripts written by python. The file of
sample/ctl.py demonstrates userspace control elements.

If this library helps your review for this patchset, I'm feeling happy.


Takashi Sakamoto (4):
  ALSA: ctl: confirm to return all identical information in 'activate' event
  ALSA: ctl: fix a bug to return no identical information in info operation
    for userspace controls
  ALSA: ctl: fill identical information to return value when adding userspace
    elements
  ALSA: ctl: fix to handle several elements added by one operation for
    userspace element

 sound/core/control.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

-- 
2.1.0
