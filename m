From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v2 0/2] *** wm8962 regmap related fix ***
Date: Tue, 20 Oct 2015 11:47:10 +0900
Message-ID: <1445309232-24094-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EA55265E14
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 04:47:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: jiada_wang@mentor.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch set aims to fix issues in wm8962 codec driver related to regmap,
currently any attempt to read from ALC Coefficient register will fail
when wm8962 is in suspend mode. As ALC2 register is volatile register,
it can't be read when cache_only flag is set.

Another issue is, if wm8962's regulator is set to 'regulator-always-on'
mode, then after wm8962 is resumed from suspend, wm8962 codec is reset,
but cache_dirty flag isn't set, this cause difference between actual wm8962
HW and regmap cache.


Changeset:
--------------
v1 -> v2
* removed comment before regcache_mark_dirty 

Jiada Wang (2):
  ASoC: WM8962: mark cache_dirty flag after software reset in pm_resume
  ASoC: Codec: wm8962: declare ALC Coefficients as 4 separate registers

 sound/soc/codecs/wm8962.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.4.5
