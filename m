From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] ALSA: add dimension information validator
Date: Thu, 30 Jun 2016 23:04:42 +0900
Message-ID: <1467295485-5335-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 1B2092652C2
 for <alsa-devel@alsa-project.org>; Thu, 30 Jun 2016 16:04:53 +0200 (CEST)
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

This patchset is to add a validator of dimension information for drivers
in kernel/userspace.

The dimension information was added to ALSA control interface. With the
information, members in an element compose multi-dimensional matrix. For
example, this matrix can be used for row/column table with values. In this
case, dimension level 1 and 2 are utilized to describe the number of rows
and columns by element member unit.

When dimension information has no contradictions to the number of members
in an element, there's no problem. Once it has, it can cause an issue. In
worst case, it can cause buffer-overrun in userspace.

The aim of this patchset is to prevent this situation.

Takashi Sakamoto (3):
  ALSA: echoaudio: purge contradictions between dimension matrix members
    and total number of members
  ALSA: control: add dimension validator for userspace element
  ALSA: control: add dimension validator for kernel driver

 sound/core/control.c            | 77 ++++++++++++++++++++++++++++++++---------
 sound/pci/echoaudio/echoaudio.c |  6 ++--
 2 files changed, 64 insertions(+), 19 deletions(-)

-- 
2.7.4
