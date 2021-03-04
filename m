Return-Path: <SRS0=cpFx=IC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F5FC433DB
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 19:00:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8053964F64
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 19:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8053964F64
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 427DB175F;
	Thu,  4 Mar 2021 19:59:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 427DB175F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614884426;
	bh=aHcGcllDnKnpauPffFsIt3DYeIs6YX2a5KhPVxTudLE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HV5vVM76fGW75tt+doH+impKOvg1mmJj33G3aN/rdpw2Cb0QivzXkAQcpQDGu1gmu
	 yH1401R0Yt7UWvEobNe/7wzeSU+w8VZRDgodeAE+p6P4WVSxwYmxyNrodS3CSaq2wP
	 eRLbiy0QV2jtvNPbEXjCCZMfKJx/8H2rOywq/V/4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 719C4F8025B;
	Thu,  4 Mar 2021 19:59:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B601F80269; Thu,  4 Mar 2021 19:59:33 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 72624F8007E
 for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2021 19:59:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72624F8007E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="H9Jzk0Ik"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 124IujVs026128; Thu, 4 Mar 2021 12:59:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=AlTMCerrUAg3Nk6mF7nb9+dbxC8AujF2woftsi5XpLo=;
 b=H9Jzk0IkTw0QC7TJIxI9AFo74X8gPwZqgcxNZ5PpvZyoci5rEIeRnKA4uaJzrKnJ2GpO
 HhqiJznVHRc4oGjm7RiPPKK8ZUqcY3nPRb5TdzE0/pW5sTLWZG0DJLFhhBq+NeduOTx2
 8otyhuOYdFU1K3+LYXvcGJBzdK7ck9ir1zOOmwvxYp/+a95hLWobHE1O/6A+S1xzQJbT
 EjIsBvOkhtyNF9HVIR4ElQ+kMAN/ff7O6AXcdI+d4KCmj3753El4H9k0OENE6uM+0R4s
 pPWehXzy/JFf71Diet6fJ1E9goBK6c2NpE4VvypHLhImdpjnunK7Q635yp8niAoH2ZOo mw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 36ykctq0vv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 04 Mar 2021 12:59:19 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 4 Mar 2021
 18:44:15 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 4 Mar 2021 18:44:15 +0000
Received: from [198.90.238.45] (unknown [198.90.238.45])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4D3EA11CB;
 Thu,  4 Mar 2021 18:44:15 +0000 (UTC)
Subject: Re: [PATCH 3/4] ALSA: hda/cirrus: Add jack detect interrupt support
 from CS42L42 companion codec.
To: Takashi Iwai <tiwai@suse.de>
References: <20210303182959.5322-1-vitalyr@opensource.cirrus.com>
 <20210303182959.5322-4-vitalyr@opensource.cirrus.com>
 <s5h7dmn9gmo.wl-tiwai@suse.de>
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Message-ID: <d5387324-6eb3-1cb1-e8e1-1fb9604a6149@opensource.cirrus.com>
Date: Thu, 4 Mar 2021 18:44:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <s5h7dmn9gmo.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103040089
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
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

On 04/03/2021 1:45 pm, Takashi Iwai wrote:
> On Wed, 03 Mar 2021 19:29:58 +0100,
> Vitaly Rodionov wrote:
>> @@ -1243,6 +1258,8 @@ static int patch_cs4213(struct hda_codec *codec)
>>   #define CIR_I2C_QWRITE	0x005D
>>   #define CIR_I2C_QREAD	0x005E
>>   
>> +static struct mutex cs8409_i2c_mux;
> Any reason that this must be the global mutex?  I suppose it can fit
> in own spec->i2c_mutex instead?
No,  there is no reason to have global mutex, will move it out to spec.
>
>
>> +static void cs8409_cs42l42_cap_sync_hook(struct hda_codec *codec,
>> +					 struct snd_kcontrol *kcontrol,
>> +					 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct cs_spec *spec = codec->spec;
>> +	unsigned int curval, expval;
>> +	/* CS8409 DMIC Pin only allows the setting of the Stream Parameters in
>> +	 * Power State D0. When a headset is unplugged, and the path is switched to
>> +	 * the DMIC, the Stream is restarted with the new ADC, but this is done in
>> +	 * Power State D3. Restart the Stream now DMIC is in D0.
>> +	 */
>> +	if (spec->gen.cur_adc == CS8409_CS42L42_DMIC_ADC_PIN_NID) {
>> +		curval = snd_hda_codec_read(codec, spec->gen.cur_adc,
>> +			0, AC_VERB_GET_CONV, 0);
>> +		expval = (spec->gen.cur_adc_stream_tag << 4) | 0;
>> +		if (curval != expval) {
>> +			codec_dbg(codec, "%s Restarting Stream after DMIC switch\n", __func__);
>> +			__snd_hda_codec_cleanup_stream(codec, spec->gen.cur_adc, 1);
>> +			snd_hda_codec_setup_stream(codec, spec->gen.cur_adc,
>> +					   spec->gen.cur_adc_stream_tag, 0,
>> +					   spec->gen.cur_adc_format);
> Hrm, this looks a big scary.  We may need to reconsider how to handle
> this better later, but it's OK as long as you've tested with this
> code...

We have been thinking about this code, and we have some ideas , it was 
tested by us, DELL and Canonical and works.

But we would like to change it a bit later, and handle it in a more 
generic way.

>
>> +static int cs8409_cs42l42_init(struct hda_codec *codec)
>> +{
>> +	int ret = 0;
>> +
>> +	ret = snd_hda_gen_init(codec);
>> +
>> +	if (!ret) {
>> +		/* On Dell platforms with suspend D3 mode support we
>> +		 * have to re-initialise cs8409 bridge and companion
>> +		 * cs42l42 codec
>> +		 */
>> +		snd_hda_sequence_write(codec, cs8409_cs42l42_init_verbs);
>> +		snd_hda_sequence_write(codec, cs8409_cs42l42_add_verbs);
>> +
>> +		cs8409_cs42l42_hw_init(codec);
> Ah... the init stuff at resume appears finally here.  This part should
> be in the second patch instead.
Yes, moving this into second patch.
>
>> +static int cs8409_cs42l42_exec_verb(struct hdac_device *dev,
>> +		unsigned int cmd, unsigned int flags, unsigned int *res)
>> +{
>> +	struct hda_codec *codec = container_of(dev, struct hda_codec, core);
>> +	struct cs_spec *spec = codec->spec;
>> +
>> +	unsigned int nid = 0;
>> +	unsigned int verb = 0;
> The blank line above should be removed.
>
>> +	case CS8409_CS42L42_HP_PIN_NID:
>> +		if (verb == AC_VERB_GET_PIN_SENSE) {
>> +			*res = (spec->cs42l42_hp_jack_in)?AC_PINSENSE_PRESENCE:0;
> The spaces are needed around operators.
> Similar coding-style issues are seen other places.  Please try to run
> scripts/checkpatch.pl.

Fixed, and checked with scripts/checkpatch.pl. Base has 19 warnings. 
This patch will not introduce any new.

>
>
> thanks,
>
> Takashi

Thanks,

Vitaly


