From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 0/4] More COMPILE_TEST patches to build all
	media drivers on x86_64
Date: Fri, 20 Apr 2018 08:32:12 -0400
Message-ID: <cover.1524227382.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from osg.samsung.com (osg.samsung.com [64.30.133.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 37FA62673D8
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 14:32:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

While now all media drivers build with COMPILE_TEST on i386, there are still
a few of them that don't build on x86_64.

Making them compiling there is just a matter of touching Kconfig files.

While here, fix smatch warnings when building the siano driver on big endian
architectures.

Mauro Carvalho Chehab (4):
  media: radio: allow building ISA drivers with COMPILE_TEST
  media: sta2x11_vip: allow build with COMPILE_TEST
  sound, media: allow building ISA drivers it with COMPILE_TEST
  media: siano: get rid of __le32/__le16 cast warnings

 drivers/media/common/siano/smsendian.c | 14 ++++++------
 drivers/media/pci/sta2x11/Kconfig      |  2 +-
 drivers/media/radio/Kconfig            | 41 +++++++++++++++++++++-------------
 sound/isa/Kconfig                      |  9 ++++----
 4 files changed, 39 insertions(+), 27 deletions(-)

-- 
2.14.3
