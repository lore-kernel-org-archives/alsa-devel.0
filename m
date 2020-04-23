Return-Path: <SRS0=JLiH=6H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD20C54FD0
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:27:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC43520736
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Apr 2020 07:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hFubZ6SM";
	dkim=pass (1024-bit key) header.d=fudan.edu.cn header.i=@fudan.edu.cn header.b="3gfq+gpd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC43520736
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=fudan.edu.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CE751701;
	Thu, 23 Apr 2020 09:26:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CE751701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587626864;
	bh=LrjWODa0X+DhJjf9qk4KdS3bXX4r23p+duv4y71ajts=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hFubZ6SMTuz99LN97ZTbd4k5znxelO4IpQ6cTCRPn2ZSgcxZs8IVeZHD6z9A2cmZv
	 dKK6+gwI0d2YkLxRXpZm64u9OvhvdI5ZbeX4C/hySSzv9N50V2LWJlrR/65TfFAn7s
	 03+RCpu5Ut7yxaBVvjmfgAK93FDvkNL/iC3QjPSE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E21A8F80279;
	Thu, 23 Apr 2020 09:25:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 272D8F801EC; Thu, 23 Apr 2020 07:02:07 +0200 (CEST)
Received: from fudan.edu.cn (mail.fudan.edu.cn [202.120.224.73])
 by alsa1.perex.cz (Postfix) with ESMTP id 6FD47F800FF
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2020 07:01:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FD47F800FF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=fudan.edu.cn header.i=@fudan.edu.cn
 header.b="3gfq+gpd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
 Message-Id; bh=FzFFOupEbTJiKCO0+vjZwkaOJbfDiGf31CZ3WKTh5eI=; b=3
 gfq+gpdSWJL6dCPSa7mWohhjKPqPIrzUPVPR8PZi4VQQwYuAThZKEq3p4J+n0VIP
 FeweYYqwE8HcipEcUV7W5wRyUqxDK1H7qiiM79ripExcNVO+DZPfAlomMXtX8bFy
 4WmA3fOdKlXZ71ZQFVIuvdbWasW6XYgOwVyEFMO2AA=
Received: from localhost.localdomain (unknown [120.229.255.80])
 by app2 (Coremail) with SMTP id XQUFCgDXiOErIaFe4opPAA--.26330S3;
 Thu, 23 Apr 2020 13:01:34 +0800 (CST)
From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Xin Tan <tanxin.ctf@gmail.com>, "Geoffrey D. Bennett" <g@b4.vu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Colin Ian King <colin.king@canonical.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Xiyu Yang <xiyuyang19@fudan.edu.cn>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Fix usb audio refcnt leak when getting spdif
Date: Thu, 23 Apr 2020 12:54:19 +0800
Message-Id: <1587617711-13200-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XQUFCgDXiOErIaFe4opPAA--.26330S3
X-Coremail-Antispam: 1UD129KBjvJXoW7CryrGFy3WFWkCr1rZr1DWrg_yoW8Ar13pr
 W3WrWvyF1YqFW3X3Z8tr4kuF95Za1Iya93GFWfKwn7Zw47Jas3Xw48t34Yvr4jk397G34a
 va1jvF18ua98C37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26rxl
 6s0DM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
 YxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
 AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
 17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
 IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq
 3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
 nIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
X-Mailman-Approved-At: Thu, 23 Apr 2020 09:25:07 +0200
Cc: yuanxzhang@fudan.edu.cn, kjlu@umn.edu
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

snd_microii_spdif_default_get() invokes snd_usb_lock_shutdown(), which
increases the refcount of the snd_usb_audio object "chip".

When snd_microii_spdif_default_get() returns, local variable "chip"
becomes invalid, so the refcount should be decreased to keep refcount
balanced.

The reference counting issue happens in several exception handling paths
of snd_microii_spdif_default_get(). When those error scenarios occur
such as usb_ifnum_to_if() returns NULL, the function forgets to decrease
the refcnt increased by snd_usb_lock_shutdown(), causing a refcnt leak.

Fix this issue by jumping to "end" label when those error scenarios
occur.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 sound/usb/mixer_quirks.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index c237e24f08d9..0f072426b84c 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -1508,11 +1508,15 @@ static int snd_microii_spdif_default_get(struct snd_kcontrol *kcontrol,
 
 	/* use known values for that card: interface#1 altsetting#1 */
 	iface = usb_ifnum_to_if(chip->dev, 1);
-	if (!iface || iface->num_altsetting < 2)
-		return -EINVAL;
+	if (!iface || iface->num_altsetting < 2) {
+		err = -EINVAL;
+		goto end;
+	}
 	alts = &iface->altsetting[1];
-	if (get_iface_desc(alts)->bNumEndpoints < 1)
-		return -EINVAL;
+	if (get_iface_desc(alts)->bNumEndpoints < 1) {
+		err = -EINVAL;
+		goto end;
+	}
 	ep = get_endpoint(alts, 0)->bEndpointAddress;
 
 	err = snd_usb_ctl_msg(chip->dev,
-- 
2.7.4

