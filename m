Return-Path: <SRS0=HcWj=ED=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EC3C388F7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 12:16:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A028124707
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Oct 2020 12:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LkCpzHyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A028124707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7C761607;
	Wed, 28 Oct 2020 13:15:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7C761607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603887387;
	bh=UNxPlF5gcJ36uDtKjuQ2oj02B2FYaEFxrw6PTylVIj4=;
	h=To:From:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LkCpzHydI36d2l6Cly+Mc2b4hYod32722Olv4R5y4B2fog8NRKnZ19jcBYmhgFrWU
	 mUgYJXk4Uv2OC3hZ5iIAW0WA9aUqpuo0F1VVwXUVonlaG4wteHJe4xQNzXoEPeRh+0
	 azjS9C5rBEgGlNw1/gnjAsbnswcAQCg4rnu00Zek=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 462A6F800FF;
	Wed, 28 Oct 2020 13:15:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C92FF80212; Wed, 28 Oct 2020 13:15:36 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 211B8F800FF
 for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2020 13:15:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 211B8F800FF
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1kXkMS-0005Pl-G9; Wed, 28 Oct 2020 12:15:28 +0000
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
From: Colin Ian King <colin.king@canonical.com>
Subject: re: ASoC: qcom: sm8250: add sound card qrb5165-rb5 support
Message-ID: <f441bb6c-12eb-a565-c34d-950da2b045d7@canonical.com>
Date: Wed, 28 Oct 2020 12:15:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
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

Hi,

Static analysis on linux-next with Coverity had detected a potential
array out-of-bounds write issue in the following commit:

commit aa2e2785545aab21b6cb2e23f111ae0751cbcca7
Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date:   Mon Oct 26 17:09:47 2020 +0000

    ASoC: qcom: sm8250: add sound card qrb5165-rb5 support

The analysis is as follows:

139 static int sm8250_snd_hw_free(struct snd_pcm_substream *substream)
140 {
141        struct snd_soc_pcm_runtime *rtd = substream->private_data;
142        struct sm8250_snd_data *data =
snd_soc_card_get_drvdata(rtd->card);
143        struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
144        struct sdw_stream_runtime *sruntime =
data->sruntime[cpu_dai->id];
145

   1. Switch case value 105.

146        switch (cpu_dai->id) {

   2. equality_cond: Jumping to case 105.

147        case WSA_CODEC_DMA_RX_0:
148        case WSA_CODEC_DMA_RX_1:

   Out-of-bounds write (OVERRUN)
   3. Condition sruntime, taking true branch.
   4. Condition data->stream_prepared[cpu_dai->id], taking true branch.

149                if (sruntime && data->stream_prepared[cpu_dai->id]) {
150                        sdw_disable_stream(sruntime);
151                        sdw_deprepare_stream(sruntime);

   Out-of-bounds write (OVERRUN)
   5. overrun-local: Overrunning array data->stream_prepared of 16 bytes
at byte offset 105 using index cpu_dai->id (which evaluates to 105).

152                        data->stream_prepared[cpu_dai->id] = false;
153                }
154                break;
155        default:
156                break;
157        }
158
159        return 0;
160 }

So cpu_dia->id is 105 in this case statement, and yet
data->steam_prepared is an array of 16 elements, so this looks suspect.

Colin
