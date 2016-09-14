From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: control: export all of TLV related
	macros to user land
Date: Thu, 15 Sep 2016 07:25:18 +0900
Message-ID: <1473891920-31214-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id D938A2664C3
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2016 00:25:28 +0200 (CEST)
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, ckeepax@opensource.wolfsonmicro.com, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset updates my previous RFCs, and they're now for merging to upstream.

[alsa-devel] [RFC][PATCH 0/2] ALSA: control: export all of TLV related macros to user land
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-September/112645.html

Currently, TLV related protocol is not shared to user land. This is not
good in a point of application interfaces, because application developers
can't realize the protocol just to see UAPI headers, and they're forced to
look for TLV-related codes in kernel land.

This patchset moves all of macros related to TLV into UAPI header. To avoid
confusions such as name conflict in user land, these macros have prefixes of
'SNDRV_CTL_TLVT_' and 'SNDRV_CTL_TLVD_'. When adding new items to the protocol,
developers should use these prefixes and add them to the UAPI header.

Changes from RFC:
 - Drop second patch to replace include statements
 - Rename each macros to prevent applications from name conflict

Takashi Sakamoto (2):
  ALSA: control: export layout of TLV payload to UAPI header
  ALSA: rename TLV-related macros so that they're friendly to user
    applications

 include/sound/tlv.h      | 73 +++++++++++++-----------------------------------
 include/uapi/sound/tlv.h | 72 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 54 deletions(-)

-- 
2.7.4
