From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 00/10 v2] ctl: add APIs for control
	element set
Date: Sun, 12 Jun 2016 17:16:01 +0900
Message-ID: <1465719371-27721-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 8B9F626051F
 for <alsa-devel@alsa-project.org>; Sun, 12 Jun 2016 10:16:17 +0200 (CEST)
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

This patchset is revised version of below one:

[alsa-devel] [alsa-lib][PATCH 0/6] control: add APIs for control element set
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-February/104795.html

In this time, I add a program to test the feature.

Changes:
 - Use a model which consists of element set/element/member/value.
 - Add an description about the design of ALSA ctl feature.
 - Obsolete old APIs due to the lack of const semantics.
 - Add an description about threshold level feature and topology framework.
 - Improve comments to threshold level APIs.
 - Add a test program.

Before starting any discussions, please read description of the model, to stand
on the same basis of understanding.


I note that execution of the test program causes an abort to PulseAudio. I can
see this line below.

pulseaudio: hcontrol.c:745: snd_hctl_handle_event: Assertion `res >= 0 && dir == 0' failed.
 
I guess that quick addition/removal of control element set causes this
assertion, but I have little time to investigate the cause. I wish to get helps
of ALSA developers in PulseAudio side.


If you need an practical example of the feature, please test one of Python 3    
samples in my 'alsa-gi'.
https://github.com/takaswie/alsa-gi/

This works without alsa-lib, by using kernel/userspace interface directly.
Therefore, this patchet doesn't affect the implementation.


Takashi Sakamoto (10):
  ctl: add an overview for design of ALSA control interface
  ctl: improve comments for handling element data
  ctl: add functions to add an element set
  ctl: improve comments for API to add an element of IEC958 type
  ctl: change former APIs as wrapper functions of element set APIs
  ctl: deprecate APIs to add an element set with a single element
  pcm: use new APIs to add a control element set for softvol plugin
  ctl: add explaination about threshold level feature
  ctl: improve API documentation for threshold level operations
  ctl: add test program for control element set

 include/control.h           |  36 +-
 src/control/control.c       | 829 ++++++++++++++++++++++++++++++++------------
 src/pcm/pcm_softvol.c       |   7 +-
 test/Makefile.am            |   5 +-
 test/user-ctl-element-set.c | 561 ++++++++++++++++++++++++++++++
 5 files changed, 1216 insertions(+), 222 deletions(-)
 create mode 100644 test/user-ctl-element-set.c

-- 
2.7.4
