From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 0/9 v3] ctl: add APIs for control
	element set
Date: Wed, 15 Jun 2016 23:57:36 +0900
Message-ID: <1466002665-30048-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id B62482668BC
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 16:57:51 +0200 (CEST)
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

This patchset is a revised version of below one:
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-June/109041.html

Changes:
 - Drop a patch for deprecating old APIs.
  - In detail, see our discussion:
    http://mailman.alsa-project.org/pipermail/alsa-devel/2016-June/109117.html
 - Revise comments for TLV feature.
  - I realized it better to use vendor-neutral representation, after reading
    this discussion:
    http://mailman.alsa-project.org/pipermail/alsa-devel/2013-November/069483.html

Again, ALSA developers in PulseAudio side, test program in the last patch
causes an abort to pulseaudio process as a result of kicking assertion of
hcontrol in alsa-lib. In detail, please refer to my previous patchset.


Regards

Takashi Sakamoto (9):
  ctl: add an overview for design of ALSA control interface
  ctl: improve comments for handling element data
  ctl: add functions to add an element set
  ctl: improve comments for API to add an element of IEC958 type
  ctl: change former APIs as wrapper functions of element set APIs
  pcm: use new APIs to add a control element set for softvol plugin
  ctl: add explanation about threshold level feature
  ctl: improve API documentation for threshold level operations
  ctl: add test program for control element set

 include/control.h           |  21 ++
 src/control/control.c       | 813 ++++++++++++++++++++++++++++++++------------
 src/pcm/pcm_softvol.c       |   7 +-
 test/Makefile.am            |   5 +-
 test/user-ctl-element-set.c | 561 ++++++++++++++++++++++++++++++
 5 files changed, 1189 insertions(+), 218 deletions(-)
 create mode 100644 test/user-ctl-element-set.c

-- 
2.7.4
