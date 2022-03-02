Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E2BC433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Mar 2022 06:26:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 344881693;
	Wed,  2 Mar 2022 07:25:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 344881693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646202377;
	bh=rng+/Rk6P9a/8HN+vTnzSxiUSMV+O9bwD1fP29VK2SE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MRSY5hZWGsXXs4kav6mXYq5blrbp6rZNoD/i/OgBXqFU3g/qE4zwNLmkm/Ln5WWhU
	 Q7gYDBdx0HkvOGxzC9BzA3wINR5SdM7jeOBBCrHMPkKYmbt97MfJklgGJzomr1UWgu
	 wCX4ZWo2Va+41LSrVSK96262hlnfiE5UtBa40g1M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3FAAF80171;
	Wed,  2 Mar 2022 07:25:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A0B07F801D5; Wed,  2 Mar 2022 07:25:24 +0100 (CET)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by alsa1.perex.cz (Postfix) with ESMTP id 6AEF2F80054
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2022 07:25:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6AEF2F80054
Received: from localhost.localdomain (unknown [124.16.138.126])
 by APP-01 (Coremail) with SMTP id qwCowACHjPjCDR9iPrUDAg--.19038S2;
 Wed, 02 Mar 2022 14:25:09 +0800 (CST)
From: Jiasheng Jiang <jiasheng@iscas.ac.cn>
To: kuninori.morimoto.gx@renesas.com
Subject: Re: Re: [PATCH v2] ASoC: fsi: Add check for clk_enable
Date: Wed,  2 Mar 2022 14:25:05 +0800
Message-Id: <20220302062505.46727-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACHjPjCDR9iPrUDAg--.19038S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYq7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
 6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
 kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8I
 cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z2
 80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
 zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx
 8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
 xwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l4I
 8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
 xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
 AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
 cIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
 v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU59a9DUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Cc: alsa-devel@alsa-project.org, songliubraving@fb.com, bpf@vger.kernel.org,
 daniel@iogearbox.net, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 Jiasheng Jiang <jiasheng@iscas.ac.cn>, john.fastabend@gmail.com,
 tiwai@suse.com, ast@kernel.org, andrii@kernel.org, broonie@kernel.org,
 netdev@vger.kernel.org, kpsingh@kernel.org, yhs@fb.com, f.suligoi@asem.it,
 kafai@fb.com
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

On Wed, Mar 02, 2022 at 12:35:02PM +0800, Kuninori Morimoto wrote:
>> +disable_xck:
>> +	clk_disable(clock->xck);
>> +disable_ick:
>> +	clk_disable(clock->ick);
>> +err:
>> +	return ret;
>>  }
> 
> I think disable_ick() / disable_xck() order are inverted ?

Thanks, I will submit a v3 to solve it.

Jiang

