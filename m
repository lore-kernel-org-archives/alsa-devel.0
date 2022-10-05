Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BFEC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Oct 2022 15:29:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E85BC163B;
	Wed,  5 Oct 2022 17:28:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E85BC163B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664983789;
	bh=I5zGui3GsfKSJJiap7Yw6JtiZ5s3H3xBHB3x8++2Y4g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HA9Xj0rZbn8jfENHHgVMyz+mefbRDbUsuWpCZkHevl6UXWrq3I4uDXlPvo6+clKEs
	 suzF0m7QFwXNZm67M9L4blhxsxX8DY6GULuSjOcFp/9jQI83MrLp0PvBejty9ozLj9
	 pcZJ3iu0XWEtOYhB+5OD2vFDXOzyR+L8RTWZ6Tk4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8445EF8016A;
	Wed,  5 Oct 2022 17:28:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41C29F800F8; Wed,  5 Oct 2022 17:28:55 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3244EF800F8
 for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2022 17:28:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3244EF800F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Vgy/tz7d"
Received: by mail-ed1-x52e.google.com with SMTP id g27so6636814edf.11
 for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2022 08:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=fwuywd4WGVvolFvD22j6/dAaw2CZJsbhACYALh55ig8=;
 b=Vgy/tz7dPZ/T+w/aQ3czyiQTROqkjIq7lgV6PLjVfqX66scgBrngMSrmSKr88OkXBu
 smf0tFT7CW6dXmK4K53jcmtqcr3/Yo3HpigsHGeUw2HCMAMe5ECIuHG6p4X4LjpySQMH
 L5twxXu4/7jCTiDaNLSi3SfQIlJHaDDh2oqdANOQ/2lYKc3buZlYJA6PHnOx8QbI7MS/
 LmGb3qTeAf1n+vE6zmWSWqj8a5i7J6BKwxm2RuZMTDPNkJa9nPaN8+g+REVdAMgiIX5C
 G29tanTvlvGwaW7agrFQXvjcZQWTvgnTWi7u8cDOwn/s98omyNMqWtDGbH1LlUipabHU
 0Rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=fwuywd4WGVvolFvD22j6/dAaw2CZJsbhACYALh55ig8=;
 b=dqWqOywiSa521oBzx++qOrdnCKurNtslc5eObQKD0klQPg2dzf3hTWPCyUFmt2KebG
 CkkPimfEzbAg8U0hJBGKnkQbCEyyV+qWxumAqOuKA+D3JO73sDYK4HZZMgIl1OY2Mfyy
 kRqXNtvkKYgmRnbmsWzdPPIoB7MzbOE5stZoifQu8vB+cKDSwy4h3a2OeyI9nCuLuUqv
 qIfLzBl5ETKEt93m87St5UH3C0TC1n4PB0veyxKWEmwCGD/35DtLQI+iFlsK4WlJ5jxE
 O5rtdCpnPQaaLGmvWKug9BWhqTJfzv4VChrhMF+JOw7WgP9cn1dYG4OxHGDBvbRvyh4W
 bGjA==
X-Gm-Message-State: ACrzQf1HDF0MSOrwBNxdlEdFIsgBQFhoPXz4BU9fjvb2VPsthp3LUpv9
 pAsCUYvLj5N57R1AYlTK5p8bRbBfePsGVXqnjM0=
X-Google-Smtp-Source: AMsMyM4+39TGV2KC/qEk2GtuUBzBHKJnND9eigSz2jzYWKnL2098tt1n5aM7cosUvI1nuxW2HXsETa8rKx+I4nq8yYA=
X-Received: by 2002:a05:6402:4310:b0:459:7806:8ee6 with SMTP id
 m16-20020a056402431000b0045978068ee6mr323437edc.198.1664983725024; Wed, 05
 Oct 2022 08:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <MW5PR11MB57644C9D9797BB1F5B30B70795549@MW5PR11MB5764.namprd11.prod.outlook.com>
 <20220929092403.GU92394@ediswmail.ad.cirrus.com>
 <77903e11-e586-64ee-4c5e-f72cd67d924f@windriver.com>
 <20221003104133.GB92394@ediswmail.ad.cirrus.com>
In-Reply-To: <20221003104133.GB92394@ediswmail.ad.cirrus.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 5 Oct 2022 10:28:34 -0500
Message-ID: <CAHCN7xL3Ok=LkENXXsyaegUSVDbCN-4-nyxQnkAich6FNT=TrA@mail.gmail.com>
Subject: Re: wm8962 0-001a: ASoC: error at soc_component_read_no_lock on
 wm8962.0-001a: -16
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
 Xiaolei" <xiaolei.wang@windriver.com>, "steve@sk2.org" <steve@sk2.org>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
 "tiwai@suse.com" <tiwai@suse.com>,
 "chi.minghao@zte.com.cn" <chi.minghao@zte.com.cn>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
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

On Mon, Oct 3, 2022 at 5:41 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Fri, Sep 30, 2022 at 12:59:24PM +0800, Wang, Xiaolei wrote:
> > On 9/29/2022 5:24 PM, Charles Keepax wrote:
> > >On Wed, Sep 28, 2022 at 02:44:30AM +0000, Wang, Xiaolei wrote:
> > >>snd_soc_bind_card
> > >>      snd_soc_dapm_new_widgets
> > >>          soc_dapm_read
> > >>              snd_soc_component_read(dapm->component, reg);
> > >>
> > >>There is no runtime resume, which cannot perform normal
> > >>reading and writing for volatile reg, because it has been
> > >>switched to regcache only in the process of runtime suspend. I
> > >>can't find the right place to resume, can you give me any
> > >>advice?
> > >>
> > >I think the first step would be could you clarify which register
> > >is being read here? Reading a volatile register as part of
> > >setting up the widgets does feel rather problematic.
> >
> > Yes, this is reading the 0x30 register of the wm8962, it can adjust
> > Microphone Bias Voltage.
>
> Yes, that is some rather poor hardware design there, the chip has
> a bunch of volatile status bits mixed in with a bunch of
> non-volatile control bits in the same register. It would seem
> the problem is likely the two widgets TEMP_HP and TEMP_SPK.
>
> Probably the simplest solution would be to add an event handler
> for TEMP_HP and TEMP_SPK and move the register handling in there,
> if there is no register specified on the widgets the core will
> not attempt to read it on probe and will assume the widget is
> off. Although you will also need to turn them off during probe as
> they do default to on.
>
> Is that something you are comfortable writing a patch for or do
> you want me to have a look at pulling one together for you?
> Although note this might take a few days and I don't have hardware
> to test it here.

I can test it if someone wants to copy me on the patch.  I see the
same splat, but it doesn't appear to impact the performance in my
application.

adam
>
> Thanks,
> Charles
