Return-Path: <SRS0=OWbI=IH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAD2C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 13:32:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908DF64F62
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Mar 2021 13:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908DF64F62
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B68917BB;
	Tue,  9 Mar 2021 14:31:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B68917BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615296745;
	bh=6Ha/Gz5ySEerErYhPPDFIX9xSYciJJU+VpqZkO0stuc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uv4y6txSSczDU1VeuP2WFnS7FC5KpQ8QTz7p0FY1uoYH6S3QVsteR88L9v9RRtw47
	 nqqFLTcH/S+11oeDeCrVooYcIzWA/ymFDmT5OOWggeVzFKtsepa2yf0136pOYJ8emW
	 NN9CH7DX+0rzX3HmZZrbtD9FnsuTr/IyqWO75Jbc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AB0BF80166;
	Tue,  9 Mar 2021 14:31:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21431F80227; Tue,  9 Mar 2021 14:31:33 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7EEB3F80166
 for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2021 14:31:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7EEB3F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="AQm1lvwf"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 129DR3q2004454; Tue, 9 Mar 2021 07:31:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=L+AL+FQ7OXS8XENOakvv10pPi7OI5CEzWLiz/gh7v58=;
 b=AQm1lvwfJta1jsOpVr2yMGXb7aFQL6rrFFHVSBvkXbqmsrNc+qkCfFDNlz4nl3kGKGCu
 10lv4rgLnWnIfxBBJHKfxVxTU77lm4rUEVRtwbxVU09ONw9yWLnmQS5ih6Zx7l+YlyfG
 KKAV1KvwmDStBCTClz9J1ccWXFXaQsUQ6Cyz4hFJUjQUXKne8JLmJ7KLQBs5dtzdQkwE
 B3U9zZbsSUHTwwKoD9EFsGJqTA3qP8UGvyIx1e7WTzoZ0LegQiaozlHFuOaiStVV7vzM
 EdHzB8ARgdK7YI9TBoA8ZJDAw7ilgQDatfin4F6jJwOXphZEx93TbTEeZ980ShOgJOdj 5g== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 374819bdya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 09 Mar 2021 07:31:19 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 9 Mar 2021
 13:31:17 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 9 Mar 2021 13:31:17 +0000
Received: from [198.90.238.45] (unknown [198.90.238.45])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7387011CF;
 Tue,  9 Mar 2021 13:31:17 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] ALSA: hda/cirrus: Add support for CS8409 HDA
 bridge and CS42L42 companion codec.
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20210306111934.4832-1-vitalyr@opensource.cirrus.com>
 <20210306111934.4832-3-vitalyr@opensource.cirrus.com>
 <3e1bd870-b0e6-cc30-fcdb-b65c7668b0c3@linux.intel.com>
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <04d34713-a1a3-dbc5-ec5e-59c10af152e9@opensource.cirrus.com>
Date: Tue, 9 Mar 2021 13:31:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <3e1bd870-b0e6-cc30-fcdb-b65c7668b0c3@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103090067
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On 08/03/2021 3:33 pm, Pierre-Louis Bossart wrote:

Hi Pierre-Louis

Thanks a lot for your comments. Since this patch set has been merged we 
will address
your comments in a next fix patch.
>
>> +/* Enable I2C clocks */
>> +static void cs8409_enable_i2c_clock(struct hda_codec *codec, 
>> unsigned int flag)
>> +{
>> +    unsigned int retval = 0;
>> +    unsigned int newval = 0;
>
> initializations not needed
Will fix that.
>
>> +    retval = cs_vendor_coef_get(codec, 0x0);
>> +    newval = (flag) ? (retval | 0x8) : (retval & 0xfffffff7);
>> +    cs_vendor_coef_set(codec, 0x0, newval);
>> +}
>> +
>> +/* Wait I2C transaction  */
>> +static int cs8409_i2c_wait_complete(struct hda_codec *codec)
>> +{
>> +    int repeat = 5;
>> +    unsigned int retval = 0;
>
> initialization not needed.
Will fix that.
>
>> +
>> +    do {
>> +        retval = cs_vendor_coef_get(codec, CIR_I2C_STATUS);
>> +        if ((retval & 0x18) != 0x18) {
>> +            usleep_range(2000, 4000);
>> +            --repeat;
>> +        } else
>> +            break;
>> +
>> +    } while (repeat);
>> +
>> +    return repeat > 0 ? 0 : -1;
>
> can we simplify by returning !!repeat ?
Yes, we can simplify this code as well.
>
>> +}
>> +
>> +/* CS8409 slave i2cRead */
>> +static unsigned int cs8409_i2c_read(struct hda_codec *codec,
>> +        unsigned int i2c_address,
>> +        unsigned int i2c_reg,
>> +        unsigned int paged)
>> +{
>> +    unsigned int i2c_reg_data;
>> +    unsigned int retval = 0;
>> +
>> +    cs8409_enable_i2c_clock(codec, 1);
>> +    cs_vendor_coef_set(codec, CIR_I2C_ADDR, i2c_address);
>> +
>> +    if (paged) {
>> +        cs_vendor_coef_set(codec, CIR_I2C_QWRITE, i2c_reg >> 8);
>> +        if (cs8409_i2c_wait_complete(codec) == -1) {
>> +            codec_err(codec,
>> +                "%s() Paged Transaction Failed 0x%02x : 0x%04x = 
>> 0x%02x\n",
>> +                __func__, i2c_address, i2c_reg, retval);
>
> return an error?
Yes, you are right there is no reason to continue if we hit an error 
here. Will be fixed.
>
>> +        }
>> +    }
>> +
>> +    i2c_reg_data = (i2c_reg << 8) & 0x0ffff;
>> +    cs_vendor_coef_set(codec, CIR_I2C_QREAD, i2c_reg_data);
>> +    if (cs8409_i2c_wait_complete(codec) == -1) {
>> +        codec_err(codec, "%s() Transaction Failed 0x%02x : 0x%04x = 
>> 0x%02x\n",
>> +            __func__, i2c_address, i2c_reg, retval);
>
> return and error?
Same as above
>
>> +    }
>> +
>> +    /* Register in bits 15-8 and the data in 7-0 */
>> +    retval = cs_vendor_coef_get(codec, CIR_I2C_QREAD);
>> +    retval &= 0x0ff;
>> +
>> +    cs8409_enable_i2c_clock(codec, 0);
>> +
>> +    return retval;
>> +}
>> +
>> +/* CS8409 slave i2cWrite */
>> +static unsigned int cs8409_i2c_write(struct hda_codec *codec,
>> +        unsigned int i2c_address, unsigned int i2c_reg,
>> +        unsigned int i2c_data,
>> +        unsigned int paged)
>> +{
>> +    unsigned int retval = 0;
>> +    unsigned int i2c_reg_data = 0;
>> +
>> +    cs8409_enable_i2c_clock(codec, 1);
>> +    cs_vendor_coef_set(codec, CIR_I2C_ADDR, i2c_address);
>> +
>> +    if (paged) {
>> +        cs_vendor_coef_set(codec, CIR_I2C_QWRITE, i2c_reg >> 8);
>> +        if (cs8409_i2c_wait_complete(codec) == -1) {
>> +            codec_err(codec,
>> +                "%s() Paged Transaction Failed 0x%02x : 0x%04x = 
>> 0x%02x\n",
>> +                __func__, i2c_address, i2c_reg, retval);
>
> return error?
Same as above
>
>> +        }
>> +    }
>> +
>> +    i2c_reg_data = ((i2c_reg << 8) & 0x0ff00) | (i2c_data & 0x0ff);
>> +    cs_vendor_coef_set(codec, CIR_I2C_QWRITE, i2c_reg_data);
>> +
>> +    if (cs8409_i2c_wait_complete(codec) == -1) {
>> +        codec_err(codec, "%s() Transaction Failed 0x%02x : 0x%04x = 
>> 0x%02x\n",
>> +            __func__, i2c_address, i2c_reg, retval);
>
> return error?
Same as above
>
>> +    }
>> +
>> +    cs8409_enable_i2c_clock(codec, 0);
>> +
>> +    return retval;
>> +}
>> +
>> +/* Assert/release RTS# line to CS42L42 */
>> +static void cs8409_cs42l42_reset(struct hda_codec *codec)
>> +{
>> +    /* Assert RTS# line */
>> +    snd_hda_codec_write(codec,
>> +            codec->core.afg, 0, AC_VERB_SET_GPIO_DATA, 0);
>> +    /* wait ~10ms */
>> +    usleep_range(10000, 15000);
>> +    /* Release RTS# line */
>> +    snd_hda_codec_write(codec,
>> +            codec->core.afg, 0, AC_VERB_SET_GPIO_DATA, GPIO5_INT);
>> +    /* wait ~10ms */
>> +    usleep_range(10000, 15000);
>> +
>> +    /* Clear interrupts status */
>> +    cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1308, 1);
>> +    cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x1309, 1);
>> +    cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130A, 1);
>> +    cs8409_i2c_read(codec, CS42L42_I2C_ADDR, 0x130F, 1);
>
> clear on read?
This is how CS42L42 works, to clear interrupts we have to read 
interrupts status registers.
>
>
>> +static int cs8409_cs42l42_fixup(struct hda_codec *codec)
>> +{
>> +    int err = 0;
>
> useless init
Will fix.
>
>> +    struct cs_spec *spec = codec->spec;
>> +    unsigned int pincap = 0;
>> +
>> +    /* Basic initial sequence for specific hw configuration */
>> +    snd_hda_sequence_write(codec, cs8409_cs42l42_init_verbs);
>> +
>> +    /* CS8409 is simple HDA bridge and intended to be used with a 
>> remote
>> +     * companion codec. Most of input/output PIN(s) have only basic
>> +     * capabilities. NID(s) 0x24 and 0x34 have only OUTC and INC
>> +     * capabilities and no presence detect capable (PDC) and call to
>> +     * snd_hda_gen_build_controls() will mark them as non detectable
>> +     * phantom jacks. However, in this configuration companion codec
>> +     * CS42L42 is connected to these pins and it has jack detect
>> +     * capabilities. We have to override pin capabilities,
>> +     * otherwise they will not be created as input devices.
>> +     */
>> +    _snd_hdac_read_parm(&codec->core,
>> +            CS8409_CS42L42_HP_PIN_NID, AC_PAR_PIN_CAP, &pincap);
>> +
>> +    snd_hdac_override_parm(&codec->core,
>> +            CS8409_CS42L42_HP_PIN_NID, AC_PAR_PIN_CAP,
>> +            (pincap | (AC_PINCAP_IMP_SENSE | AC_PINCAP_PRES_DETECT)));
>> +
>> +    _snd_hdac_read_parm(&codec->core, CS8409_CS42L42_AMIC_PIN_NID,
>> +            AC_PAR_PIN_CAP, &pincap);
>> +
>> +    snd_hdac_override_parm(&codec->core,
>> +            CS8409_CS42L42_AMIC_PIN_NID, AC_PAR_PIN_CAP,
>> +            (pincap | (AC_PINCAP_IMP_SENSE | AC_PINCAP_PRES_DETECT)));
>> +
>> +    snd_hda_override_wcaps(codec, CS8409_CS42L42_HP_PIN_NID,
>> +            (get_wcaps(codec, CS8409_CS42L42_HP_PIN_NID) | 
>> AC_WCAP_UNSOL_CAP));
>> +
>> +    snd_hda_override_wcaps(codec, CS8409_CS42L42_AMIC_PIN_NID,
>> +            (get_wcaps(codec, CS8409_CS42L42_AMIC_PIN_NID) | 
>> AC_WCAP_UNSOL_CAP));
>> +
>> +    snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
>> +
>> +    err = snd_hda_parse_pin_defcfg(codec, &spec->gen.autocfg, 0, 0);
>> +    if (err < 0)
>> +        return err;
>> +
>> +    err = snd_hda_gen_parse_auto_config(codec, &spec->gen.autocfg);
>> +    if (err < 0)
>> +        return err;
>> +
>> +    snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
>> +
>> +    return err;
>> +}
>> +
>> +static int patch_cs8409(struct hda_codec *codec)
>> +{
>> +    struct cs_spec *spec;
>> +    int err = -EINVAL;
>> +
>> +    spec = cs_alloc_spec(codec, CS8409_VENDOR_NID);
>> +    if (!spec)
>> +        return -ENOMEM;
>> +
>> +    snd_hda_pick_fixup(codec,
>> +            cs8409_models, cs8409_fixup_tbl, cs8409_fixups);
>> +
>> +    codec_dbg(codec, "Picked ID=%d, VID=%08x, DEV=%08x\n",
>> +            codec->fixup_id,
>> +            codec->bus->pci->subsystem_vendor,
>> +            codec->bus->pci->subsystem_device);
>> +
>> +    switch (codec->fixup_id) {
>> +    /* Dell platforms with CS42L42 companion codec */
>> +    case CS8409_BULLSEYE:
>> +    case CS8409_WARLOCK:
>> +    case CS8409_CYBORG:
>> +
>> +        snd_hda_add_verbs(codec, cs8409_cs42l42_add_verbs);
>> +
>> +        codec->patch_ops = cs8409_cs42l42_patch_ops;
>> +
>> +        spec->gen.suppress_auto_mute = 1;
>> +        spec->gen.no_primary_hp = 1;
>> +        /* GPIO 5 out, 3,4 in */
>> +        spec->gpio_dir = GPIO5_INT;
>> +        spec->gpio_data = 0;
>> +        spec->gpio_mask = 0x03f;
>> +
>> +        err = cs8409_cs42l42_fixup(codec);
>> +
>> +        if (err > 0)
>
> better keep the convention that errors are negative and zero is success.
Agreed. Will fix.
>
>> +            err = cs8409_cs42l42_hw_init(codec);
>> +        break;
>> +
>> +    default:
>> +        codec_err(codec, "VID=%08x, DEV=%08x not supported\n",
>> +                codec->bus->pci->subsystem_vendor,
>> +                codec->bus->pci->subsystem_device);
>> +        break;
>> +    }
>> +    if (err < 0)
>> +        cs_free(codec);
>> +    else
>> +        snd_hda_codec_set_name(codec, "CS8409/CS42L42");
>> +
>> +    return err;
>> +}
>>     /*
>>    * patch entries
>> @@ -1229,6 +1804,7 @@ static const struct hda_device_id 
>> snd_hda_id_cirrus[] = {
>>       HDA_CODEC_ENTRY(0x10134208, "CS4208", patch_cs4208),
>>       HDA_CODEC_ENTRY(0x10134210, "CS4210", patch_cs4210),
>>       HDA_CODEC_ENTRY(0x10134213, "CS4213", patch_cs4213),
>> +    HDA_CODEC_ENTRY(0x10138409, "CS8409", patch_cs8409),
>>       {} /* terminator */
>>   };
>>   MODULE_DEVICE_TABLE(hdaudio, snd_hda_id_cirrus);
>>

