From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] ALSA: control: delegate TLV eventing to
	each driver
Date: Thu, 24 Aug 2017 10:46:13 +0900
Message-ID: <20170824014616.28859-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 86213266D16
 for <alsa-devel@alsa-project.org>; Thu, 24 Aug 2017 03:46:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, fulup.arfoll@iot.bzh
List-Id: alsa-devel@alsa-project.org

Hi,

This patchse is the same one which I posted and for merge to upstream.

[alsa-devel] [RFC][PATCH 0/3] ALSA: control: delegate TLV eventing to each driver
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-August/124382.html

Nothing changed from the original one.


Takashi Sakamoto (3):
  ALSA: control: delegate TLV eventing to each driver
  ALSA: control: queue TLV event for a set of user-defined element
  ALSA: control: TLV data is unavailable at initial state of
    user-defined element set

 sound/core/control.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

-- 
2.11.0
