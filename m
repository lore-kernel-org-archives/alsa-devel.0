From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: control: optimization for position
	offset macro of TLV data
Date: Mon, 14 May 2018 07:09:49 +0900
Message-ID: <20180513220953.15118-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 5792E267673
 for <alsa-devel@alsa-project.org>; Mon, 14 May 2018 00:10:26 +0200 (CEST)
Received: by mail-pg0-f65.google.com with SMTP id v7-v6so1833484pgs.0
 for <alsa-devel@alsa-project.org>; Sun, 13 May 2018 15:10:26 -0700 (PDT)
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

Hi,

This patchset is a supplement for a commit 08f9f4485f21 ('ALSA: core
api: define offsets for TLV items') for items below:
 - add position offset macro for db-minmax and db-linear types of TLV data
 - optimization with these macros

Takashi Sakamoto (4):
  ALSA: control: complement TLV macro for db-minmax and db-linear types
  ALSA: vmaster: use position offset macro of TLV data
  ALSA: hda: use position offset macro of TLV data
  ALSA: isight: use position offset macro of TLV data

 include/uapi/sound/tlv.h    |  8 ++++++++
 sound/core/vmaster.c        | 16 +++++++++-------
 sound/firewire/isight.c     | 10 ++++++----
 sound/pci/hda/hda_codec.c   | 22 +++++++++++-----------
 sound/pci/hda/hda_generic.c |  2 +-
 5 files changed, 35 insertions(+), 23 deletions(-)

-- 
2.14.1
