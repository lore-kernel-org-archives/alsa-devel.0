Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FECC433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Jan 2022 08:42:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B4161820;
	Thu,  6 Jan 2022 09:41:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B4161820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641458543;
	bh=6lCMeztgA60wkr24oML08v2CjAEx3a65F0RNe9x9ujs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nKfkeL1C8X5v0lDKKBW3eikwEQ0BWs63BFfVEua3HOWpexMqBDlcouxD8MUUgJQ05
	 TkaksNaGLYU5Jf2JBmZ0ToLMvVjhS2ZcPlLINMO0ZxpRLZkW/Tchb3Kw6JHpbaKqej
	 37YxF34fTkUjxBP0FtZfWLu1UDIyjCLkkHvNSw1o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24E04F80121;
	Thu,  6 Jan 2022 09:41:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B394F80155; Thu,  6 Jan 2022 09:41:32 +0100 (CET)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by alsa1.perex.cz (Postfix) with ESMTP id 333B5F8007E
 for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2022 09:41:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 333B5F8007E
Received: from localhost.localdomain (unknown [124.16.138.126])
 by APP-05 (Coremail) with SMTP id zQCowAAnLwMnq9Zh9Ae1BQ--.62457S2;
 Thu, 06 Jan 2022 16:41:11 +0800 (CST)
From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
To: tiwai@suse.de
Subject: Re: Re: [PATCH] ALSA: intel_hdmi: Check for error num after setting
 mask
Date: Thu,  6 Jan 2022 16:41:10 +0800
Message-Id: <20220106084110.2691207-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAAnLwMnq9Zh9Ae1BQ--.62457S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xry8Gw47Jw45CFWfKFWruFg_yoWxAwb_W3
 48X3s5Xw4DtFy7Z34vyrn3Zry2qayjvr1xXrsYqF47Xw15ZFW8XrWUCr4ak3WxG34jyFZx
 Cr4fZw45Xrya9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
 Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
 4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4a0PUUUUU=
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Cc: alsa-devel@alsa-project.org, leon@kernel.org, linux-kernel@vger.kernel.org,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>, tiwai@suse.com, broonie@kernel.org,
 joe@perches.com
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

On Thu, Jan 06, 2022 at 04:18:01PM +0800, Takashi Iwai wrote:
> Well, 32bit DMA mask practically never fails on x86 (and other
> architectures, IIRC).  It's fine to add a sanity check, but it's
> better to be mentioned that it never fails.

Actually, I have already found many place check the 32bit DMA mask.
For example:
snd_ad1889_create() in `sound/pci/ad1889.c`, 
snd_vortex_create() in `sound/pci/au88x0/au88x0.c`
tegra_pcm_dma_allocate() in `sound/soc/tegra/tegra_pcm.c`.
Therefore, I think there must be some reason that 32bit may fail.
So, to make the system more robust, it should be better to add the
sanity check.

Sincerely thanks,
Jiang

