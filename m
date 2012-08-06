From: Hideki EIRAKU <hdk@igel.co.jp>
Subject: [PATCH v3 2/4] ALSA: pcm - Don't define ARCH_HAS_DMA_MMAP_COHERENT
 privately for ARM
Date: Mon,  6 Aug 2012 18:55:22 +0900
Message-ID: <1344246924-32620-3-git-send-email-hdk@igel.co.jp>
References: <1344246924-32620-1-git-send-email-hdk@igel.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1344246924-32620-1-git-send-email-hdk@igel.co.jp>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>, Pawel Osciak <pawel@osciak.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Katsuya MATSUBARA <matsu@igel.co.jp>, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The ARM architecture now defines ARCH_HAS_DMA_MMAP_COHERENT, there's no
need to define it privately anymore.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 sound/core/pcm_native.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 53b5ada..84ead60 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3156,13 +3156,6 @@ static const struct vm_operations_struct snd_pcm_vm_ops_data_fault = {
 	.fault =	snd_pcm_mmap_data_fault,
 };
 
-#ifndef ARCH_HAS_DMA_MMAP_COHERENT
-/* This should be defined / handled globally! */
-#ifdef CONFIG_ARM
-#define ARCH_HAS_DMA_MMAP_COHERENT
-#endif
-#endif
-
 /*
  * mmap the DMA buffer on RAM
  */
-- 
1.7.0.4
