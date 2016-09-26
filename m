From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] ASOC: wm8991/stac9766: fix wrong usage of
	TLV-related macro
Date: Tue, 27 Sep 2016 08:25:26 +0900
Message-ID: <1474932329-10640-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 66603266999
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 01:25:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is for Linux 4.8-rc8.

In current implementation of drivers for wm899a and stac9766,
DECLARE_TLV_DB_LINEAR() is used to represent information about attenuation
and gain of volumes. According to their datasheet, the attenuation and
volumes are first-degree equation with dB coefficiency. It's not linear and
usage of the macro is wrong[1].

This patchset fixes the bug. As of 2016, these CODECs seem to EOL. So this
patchset is just for maintenance purpose to remove misuse of TLV-related
macros from tree.

[1] Re: [RFC] TLV entry for linear volume
http://www.spinics.net/lists/alsa-devel/msg03485.html

Takashi Sakamoto (3):
  ASOC: wm8991: fix wrong usage of DECLARE_TLV_DB_LINEAR()
  ASOC: wm8991: remove unused variable
  ASOC: stac9766: fix wrong usage of DECLARE_TLV_DB_LINEAR()

 sound/soc/codecs/stac9766.c |  8 ++++----
 sound/soc/codecs/wm8991.c   | 28 +++++++++++++++++++---------
 2 files changed, 23 insertions(+), 13 deletions(-)

-- 
2.7.4
