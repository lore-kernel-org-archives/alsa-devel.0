Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2B4C48BDF
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 12:40:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA36A61463
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 12:40:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA36A61463
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC40B169A;
	Tue, 15 Jun 2021 14:39:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC40B169A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623760838;
	bh=IIHLleX4SxWGEBSpDI3UIepwbTPu6SjVKPF+NoTNjpw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=agBQZMIz7JM3fqRB2EPTCjy0pgqf7xwVHSmpCqvTHhZoTl+R3MIg+V5kwmYgyxG1l
	 2rzaHN/abTFptses9nh9xl4W45sApgd7IweCkuC6DePaRPem+1IakawlFGRWQ5JGQ1
	 yf3Hdgigj9tZmLG7xRrtPDnSx7Ym/fcoImeonH7c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33EBBF8016D;
	Tue, 15 Jun 2021 14:39:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 04437F80165; Tue, 15 Jun 2021 14:39:46 +0200 (CEST)
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85FDFF80165
 for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2021 14:39:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85FDFF80165
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de
 header.b="OfkEtT3r"
Received: from [10.88.0.186]
 (dslb-084-062-104-230.084.062.pools.vodafone-ip.de [84.62.104.230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: ch@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8653F80EC6;
 Tue, 15 Jun 2021 14:39:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1623760783;
 bh=/himMSkTfivyhxtCVhwVEdFJBtlSgUHF5C534nSY1zc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=OfkEtT3rkWUW/EmOvthWli3dCtmF/VbkMUJ1dTkJQdvYNrLKspj42M9CDfMnqjnu/
 W4CHBr9KkzsxLIEm/lhDxTg6dMKGhPQpbHBTBBlaBeGz6uTYxhM74YFLwrBuhSHeow
 XBNmRJ7GJu1jyKCLfebdYHYnc0WfvJsEVZTgtASTuD6W4Ky7/cJD3idrTM88YdseEh
 /3CG0aloWVFE9D6XMoGdUSlSM3SnvN+pHc1vC9NtmWS7C0enPkBviw3R8IuuV76QZt
 orETqX2VGOdQEztl+cy1NGy5wYClMqt6Qt+Xe4mr6tmMrEormt49oJHQrURg73v6P+
 EWyEo9QOq06OA==
Subject: Re: [PATCH 2/3] ASoC: tlv320aic32x4: add support for TAS2505
To: Mark Brown <broonie@kernel.org>
References: <20210615094933.3076392-1-ch@denx.de>
 <20210615094933.3076392-3-ch@denx.de> <20210615122241.GE5149@sirena.org.uk>
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
Message-ID: <4b72d6cd-ef07-fcdd-f90b-1cd53a3e3c8b@denx.de>
Date: Tue, 15 Jun 2021 14:39:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210615122241.GE5149@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Cc: Marek Vasut <marex@denx.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Sia Jee Heng <jee.heng.sia@intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Annaliese McDermond <nh6z@nh6z.net>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
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

On 2021-06-15 14:22, Mark Brown wrote:
> On Tue, Jun 15, 2021 at 11:49:31AM +0200, Claudius Heine wrote:
> 
>> +static int aic32x4_tas2505_spkdrv_putvol(struct snd_kcontrol *kcontrol,
>> +	struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
>> +	struct soc_mixer_control *mc =
>> +		(struct soc_mixer_control *)kcontrol->private_value;
>> +	u8 val;
>> +
>> +	val = (ucontrol->value.integer.value[0] & 0x7f);
>> +	val = mc->invert ? mc->max - val : val;
>> +	val = (val < 0) ? 0 : val;
>> +	snd_soc_component_write(component, TAS2505_SPKVOL1, val);
>> +
>> +	return 0;
>> +}
> 
> Controls should return a boolean indicating if they changed their value
> when written.  Other than the hard coded register what's device specific
> here?  It looks like a normal control with a maximum value, it is
> unclear why this is being open coded.

Well probably because I didn't knew any better. Will look into it. Thx!

> 
>> +	SOC_DOUBLE_R_S_TLV("HP Driver Gain Playback Volume", AIC32X4_HPLGAIN,
>> +			AIC32X4_HPLGAIN, 0, -0x6, 0x1d, 5, 0,
>> +			tlv_driver_gain),
> 
> Drop the Gain.  See control-names.rst.
> 

Ok.

Thanks!
Claudius
