From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 0/2] ALSA: control: limit life time of
	user-defined element set
Date: Sun,  4 Sep 2016 19:06:54 +0900
Message-ID: <1472983616-16254-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id E59CA265D21
 for <alsa-devel@alsa-project.org>; Sun,  4 Sep 2016 12:07:04 +0200 (CEST)
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
Cc: jimmy@spalge.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is an example to implement an idea mentioned in this thread:

[alsa-devel] [PATCH] Softvol: Allow per process volume control.
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-July/095026.html

ALSA control core allows applications to add arbitrary element sets to an
instance of control device, while removal of the element sets is voluntarily
done by some applications. This is not convenient to certain situations.
For example, an application adds some element sets, then aborted due to
programming mistakes, and restart. Needless elements can be added one after
another.

This patchset limits life time of user-defined element set. Basically, the life
time is corresponding to a file descriptor opened by a process to add element
sets. However, elements can be locked by the other processes. For this case,
this patchset counts locked elements, then judge to remove an element set
including these elements.

My large concern is whether there's any applications to open a file descriptor
just to add any element sets. In this case, added element sets are removed
immediately at closing the file descriptor unexpectedly to the application, and
unavailable to the other processes anymore. In this point, this patchset is
intrusive.

(But I'm a bit optimistic because use-defined element set is long abandoned not
to work well in several items, and there may be probably few consumers in user
space. Perhaps, this change is acceptable, I hope.)

To reviewers, my aim for this patchset is to show attempts to synchronize life
time of user-defined element set to file descriptors. Any objections are
welcome. Then, I'd like to receive alternative ideas, especially for definition
of the life time.

Takashi Sakamoto (2):
  ALSA: control: limit life time of user-defined element set
  ALSA: control: bump up protocol version to 2.0.8

 include/uapi/sound/asound.h |   2 +-
 sound/core/control.c        | 101 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 87 insertions(+), 16 deletions(-)

-- 
2.7.4
