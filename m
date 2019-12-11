Return-Path: <SRS0=ZYEx=2B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE48C43603
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 21:26:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 066002054F
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Dec 2019 21:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CxgWNp7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 066002054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4088D1674;
	Wed, 11 Dec 2019 22:25:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4088D1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576099595;
	bh=D23ufbQmFRtK1b3kXwTX4H/bKl7MPosrjH5AYELekk0=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CxgWNp7Sc6hGBWEttK07LOjCZ/5+YKT/PXLg/Pmqpyll/cX/TOLOW/6fmHsM1dI+Q
	 4WFDZdGq8c96w/pQN7NUQMhGknLN7lOmiMLqoGtdFrXUd8LfG2gpquAzZ2J8/jZsqW
	 ui9ufc88HyZO3oL2FJrOnZBqQW209tb/2rUaJn5A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3CB9F8028F;
	Wed, 11 Dec 2019 22:20:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 59EFEF8026F; Wed, 11 Dec 2019 22:20:52 +0100 (CET)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2210F80240
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2019 22:20:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2210F80240
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MhCq4-1i2E1j40qQ-00eMD8; Wed, 11 Dec 2019 22:20:34 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: alsa-devel@alsa-project.org,
	Takashi Iwai <tiwai@suse.com>
Date: Wed, 11 Dec 2019 22:20:25 +0100
Message-Id: <20191211212025.1981822-10-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211212025.1981822-1-arnd@arndb.de>
References: <20191211212025.1981822-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:lCktzJYozNs3B0kWxyrFoZnS1JrDshoD0BgAOOtPca5RzXgAQmc
 l2W4MPeCpp+inIq/7xjx/JNBcdZMsOMO+ZGxkgXmmlTdZIz4PmlxmfS9CnXtK5JOYnXIzNl
 7hd+IjJQcFknL4nQjrbDyV6y+M1TgsPkdrQKscsHLB8MBvVeNLTPTo0P/axUvyUXy0JEzPV
 QEBxYIL+LVVq/qBET8lWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Me9XM8idYBw=:PpSHMQCjMCOePdCjSzUNcb
 XIhHkC5twEGrwaTXmoAViaEsJuuZsIwshSMm6rS69sQgmCDyGt347t9xcufhQOdjfPVY5Lz5X
 VvOeVZRHdH9iS7YdcUMpGvcci0+u35WxvX5V6wzI810OhowCUd4oAh7oD2pGuiCTQF6buCV9q
 ZRh64e0TzMHnXVJnR5S5K1/g2IWA8VNYj+72lmzR7Nce+Ne3nE86anPtQeOdse93DqM4VFsAl
 m/IV/o+vOscmgzwqbmLRs1Rcfen/AR8FY6d/vIF+v5VkFhRRJTBcW3s44CEvuJsXZBT4VbH+9
 XZr8p8C2stni19yy6007gcRA8Ttlx68V6bdLnBhu/1jAvn5ESFo/zuM6FlOkrNm6/MkO2Y8wv
 UuLSwXT0eZydx8d9jRuZH/sO5Asdec0mcNmUFI/VXq8MsXNOcQDqg19mG1EEh7NbFKXcM+uaJ
 pqRduztWV0RSwx6a9PrYCy9/5YpbGrYsv3/+uEJaTjyMnXfZ63C6ErvnlwJWleH1OMj9fiqZE
 bJAZE0t/nIFNdJCxk1U4WKdfC7fLxv8Vum1nvTVpgztuyit5L1/VNyQRy31W/cjm4d5/ngM/8
 6usvnt3rvtp/svkTjBTrza+o2wYrCph66B4WcQjZ7Xe3xfbYqyq20+pHlHlh0lmJSyZfPiXzc
 fgoXbV1z4mRKNcEgHaIatcBTzDEKtPY+2/XblOWVSjYGc9m2zO6TErjus1qUC9Fm5o3rRXPwL
 6XwPGoLyRME5cZcqzCO+7NN1Emwk6/vuNHRXJIODICPF50HXVowfoimva+aG87VWGVS4K0YkK
 Hk2qQswi1SjfY5SvMz+DoN9/i/AayNLXUfflLc3jFM4e9W/ceY7JAdvRhJd7AQDrGHxzz8G1I
 Pc5XxChsunG7YtGvMWHA==
Cc: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Baolin Wang <baolin.wang7@gmail.com>
Subject: [alsa-devel] [PATCH v7 9/9] ALSA: bump uapi version numbers
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Change SNDRV_PCM_VERSION, SNDRV_RAWMIDI_VERSION and SNDRV_TIMER_VERSION
to indicate the addition of the time64 version of the mmap interface and
these ioctl commands:

SNDRV_PCM_IOCTL_SYNC
SNDRV_RAWMIDI_IOCTL_STATUS
SNDRV_PCM_IOCTL_STATUS
SNDRV_PCM_IOCTL_STATUS_EXT
SNDRV_TIMER_IOCTL_TREAD
SNDRV_TIMER_IOCTL_STATUS

32-bit applications built with 64-bit time_t require both the headers
and the running kernel to support at least the new API version. When
built with earlier kernel headers, some of these may not work
correctly, so applications are encouraged to fail compilation like

 #if SNDRV_PCM_VERSION < SNDRV_PROTOCOL_VERSION(2, 0, 15)
 extern int __fail_build_for_time_64[sizeof(long) - sizeof(time_t)];
 #endif

or provide their own updated copy of the header file.
At runtime, the interface is unchanged for 32-bit time_t, but new
kernels are required to work with user compiled with 64-bit time_t.

A runtime check can be used to detect old kernel versions and
warn about those.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/sound/asound.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index df9983e7ead5..e6a958b8aff1 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -156,7 +156,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 14)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 15)
 
 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
@@ -710,7 +710,7 @@ enum {
  *  Raw MIDI section - /dev/snd/midi??
  */
 
-#define SNDRV_RAWMIDI_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 0)
+#define SNDRV_RAWMIDI_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 1)
 
 enum {
 	SNDRV_RAWMIDI_STREAM_OUTPUT = 0,
@@ -766,7 +766,7 @@ struct snd_rawmidi_status {
  *  Timer section - /dev/snd/timer
  */
 
-#define SNDRV_TIMER_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 6)
+#define SNDRV_TIMER_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 7)
 
 enum {
 	SNDRV_TIMER_CLASS_NONE = -1,
-- 
2.20.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
