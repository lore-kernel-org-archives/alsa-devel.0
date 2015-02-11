From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5] ALSA: control: improve core codes with
	intrusion
Date: Wed, 11 Feb 2015 19:40:08 +0900
Message-ID: <1423651213-19829-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id D26B8264FF6
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 11:40:21 +0100 (CET)
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

This patchset is for improving core control codes. Most of them have any
effects for processing, messaging or status codes.

This patchset is based on my previous one:
[alsa-devel] [PATCH 0/8] ALSA: control: refactoring core codes
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-February/087783.html

Takashi Sakamoto (5):
  ALSA: control: drop a sub-effect for caller's data
  ALSA: control: use dev_dbg() for warning to add duplicated controls
  ALSA: control: fix logic error about control count in a device
  ALSA: control: improve returned value because of the rest
  ALSA: control: save stack usage at creating new instance

 sound/core/control.c | 209 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 116 insertions(+), 93 deletions(-)

-- 
2.1.0
