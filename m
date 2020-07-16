Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65554C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:48:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3CA82076A
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fDCsg0ok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3CA82076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FF9B83D;
	Thu, 16 Jul 2020 19:47:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FF9B83D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594921720;
	bh=vbsfvc94Hf1xeK3oJDQZwG9FdmllLXxi644xEHRVomg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fDCsg0okNriNCaxEydxXLUvz8Uo87fEzbdv6sRNpgnXHrQcy15j9N2rWvgcKxa9i/
	 ZgaGMuhF221isiCe9IHnwgkROcaqo/smuShM1cbjibGgrz+IqfPzdJG7C6bGTCGMwg
	 ONr0D03a75A54FzCdXCjBuNEa/TmI8J57uS4PESI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04A9BF80110;
	Thu, 16 Jul 2020 19:47:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED125F8016F; Thu, 16 Jul 2020 19:47:45 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B45EF80110
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 19:47:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B45EF80110
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: eballetbo) with ESMTPSA id 6E9772A56D3
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Reset I2S RX when probing
To: Guenter Roeck <groeck@google.com>, Yu-Hsuan Hsu <yuhsuan@chromium.org>
References: <20200716170914.3623060-1-yuhsuan@chromium.org>
 <CABXOdTffo_PoFytXTR0DthRgxrp9SLkTrg2Wp6dMDXXj060KFw@mail.gmail.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f53d5f7b-6d9a-af68-7a48-fbb411625336@collabora.com>
Date: Thu, 16 Jul 2020 19:47:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABXOdTffo_PoFytXTR0DthRgxrp9SLkTrg2Wp6dMDXXj060KFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Tzung-Bi Shih <tzungbi@google.com>, Mark Brown <broonie@kernel.org>,
 Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>,
 Cheng-Yi Chiang <cychiang@chromium.org>
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

On 16/7/20 19:23, Guenter Roeck wrote:
> On Thu, Jul 16, 2020 at 10:09 AM Yu-Hsuan Hsu <yuhsuan@chromium.org> wrote:
>>
>> It is not guaranteed that I2S RX is disabled when the kernel booting.
>> For example, if the kernel crashes while it is enabled, it will keep
>> enabled until the next time EC reboots. Reset I2S RX when probing to
>> fix this issue.
>>
>> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
>> ---
>>  drivers/platform/chrome/cros_ec_proto.c        | 7 ++++++-
>>  include/linux/platform_data/cros_ec_commands.h | 1 +
>>  sound/soc/codecs/cros_ec_codec.c               | 9 +++++++++
>>  3 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
>> index 3e745e0fe092c..2c60690d7147c 100644
>> --- a/drivers/platform/chrome/cros_ec_proto.c
>> +++ b/drivers/platform/chrome/cros_ec_proto.c
>> @@ -572,7 +572,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>>                 return -ENOTSUPP;
>>         } else if (msg->result != EC_RES_SUCCESS) {
>>                 dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
>> -               return -EPROTO;
>> +               switch (msg->result) {
>> +               case EC_RES_INVALID_PARAM:
>> +                       return -EINVAL;
> 
> As we have learned, this may impact other callers of
> cros_ec_cmd_xfer_status() which only accept -EPROTO as error return
> value. In addition to that, the code is odd:
> 
>     if (msg->result == EC_RES_INVALID_VERSION) {
>         ...
>     } else if (msg->result != EC_RES_SUCCESS) {
>         switch (msg->result) {
>         ....
>         }
>     }
> 

Ack, this is odd.

> I really dislike the notion of changing error return values of
> cros_ec_cmd_xfer_status() one by one. That can only cause ongoing
> trouble with callers expecting specific error return codes (as we have
> already seen).
> 

Hmm, that's a good point. Ok.

Let's apply the Guenter's patch that maps the errors *and* fix the callers of
cros_ec_cmd_xfer_status which only accept -EPROTO (there are few).

Yu-Hsuan, can you take care of this and send a patch series with all the
required patches? If not, I can work on this next week.

Thanks,
  Enric

> Guenter
> 
>> +               default:
>> +                       return -EPROTO;
>> +               }
>>         }
>>
>>         return ret;
>> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
>> index 69210881ebac8..11ce917ca924c 100644
>> --- a/include/linux/platform_data/cros_ec_commands.h
>> +++ b/include/linux/platform_data/cros_ec_commands.h
>> @@ -4598,6 +4598,7 @@ enum ec_codec_i2s_rx_subcmd {
>>         EC_CODEC_I2S_RX_SET_SAMPLE_DEPTH = 0x2,
>>         EC_CODEC_I2S_RX_SET_DAIFMT = 0x3,
>>         EC_CODEC_I2S_RX_SET_BCLK = 0x4,
>> +       EC_CODEC_I2S_RX_RESET = 0x5,
>>         EC_CODEC_I2S_RX_SUBCMD_COUNT,
>>  };
>>
>> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
>> index f23956cf4ed84..b5ff30b7f1aa8 100644
>> --- a/sound/soc/codecs/cros_ec_codec.c
>> +++ b/sound/soc/codecs/cros_ec_codec.c
>> @@ -1034,6 +1034,15 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
>>         }
>>         priv->ec_capabilities = r.capabilities;
>>
>> +       /* Reset EC codec I2S RX. */
>> +       p.cmd = EC_CODEC_I2S_RX_RESET;
>> +       ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
>> +                                  (uint8_t *)&p, sizeof(p), NULL, 0);
>> +       if (ret == -EINVAL)
>> +               dev_info(dev, "Missing reset command. Please update your EC firmware.\n");
>> +       else if (ret)
>> +               dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
>> +
>>         platform_set_drvdata(pdev, priv);
>>
>>         ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
>> --
>> 2.27.0.389.gc38d7665816-goog
>>
