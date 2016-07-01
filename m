From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3 v2] ALSA: ctl: add dimension information
	validator
Date: Fri,  1 Jul 2016 13:15:08 +0900
Message-ID: <1467346511-28051-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 0E2F4265338
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 06:15:16 +0200 (CEST)
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

This patchset is revised version of my previous one.

[alsa-devel] [PATCH 0/3] ALSA: add dimension information validator
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-June/109811.html

The main purpose of this patchset is the same, just including some changes
below.
 * Add arithmetic overflow check
 * Add negative value check of first dimension level
 * Change function name of the validator and name of local variable so that
   the aim is clear.

Takashi Sakamoto (3):
  ALSA: echoaudio: purge contradictions between dimension matrix members
    and total number of members
  ALSA: control: add dimension validator for userspace element
  ALSA: control: add dimension validator for kernel driver

 sound/core/control.c            | 87 +++++++++++++++++++++++++++++++++--------
 sound/pci/echoaudio/echoaudio.c |  6 +--
 2 files changed, 74 insertions(+), 19 deletions(-)

-- 
2.7.4
