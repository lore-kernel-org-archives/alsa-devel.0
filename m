From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 0/4] pcm: minor code cleanup
Date: Thu, 21 Dec 2017 02:16:59 +0900
Message-ID: <20171220171703.10609-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 1946C267826
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 18:17:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

When reviewing Maciej's patches[1], I found that alsa-lib includes some
unused codes in linear interpolation functionality. Furthermore, some code
comments includes 'copy & paste' mistakes.

This patchset improves them.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2017-December/129370.html

Takashi Sakamoto (4):
  pcm: remove unused macros of COPY_LABELS/COPY_END
  pcm: remove unused macros of GETU_LABELS/GETU_END
  pcm: remove unused macros of NORMS_LABELS/NORMS_END
  pcm: fix wrong comments for some cases of linear interpolation of PCM
    samples

 src/pcm/plugin_ops.h | 341 ++-------------------------------------------------
 1 file changed, 8 insertions(+), 333 deletions(-)

-- 
2.14.1
