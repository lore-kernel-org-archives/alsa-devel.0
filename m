Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F76C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  6 May 2022 07:09:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47C32177E;
	Fri,  6 May 2022 09:08:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47C32177E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651820961;
	bh=mb2R3B4rxxl3J9P7UluIn2ZMQQO3u4wQuTllGLpuUbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c01TBROaAez2JM0Cd0Ha8W/1OicF2EY66+/L2I17kJVCTh7hHe6OXd9FOJU1Ieqx3
	 yvsuV1+x7UcLmQIDo0fZRt9zbKjEF+Xg7xWmrOA+HM423qMGtGD2D+vt7TbMytFeCK
	 /ILCG11AmlkovuENs3Vd8Q7Qig/1ZhO8Wf6mzEtc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE0E6F8012F;
	Fri,  6 May 2022 09:08:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9EBFAF8014B; Fri,  6 May 2022 09:08:29 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26655F800E3
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2022 09:08:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26655F800E3
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTikV-1nNo8N2Doj-00U50L for <alsa-devel@alsa-project.org>; Fri, 06 May
 2022 09:08:26 +0200
Received: by mail-wr1-f47.google.com with SMTP id c11so8767438wrn.8
 for <alsa-devel@alsa-project.org>; Fri, 06 May 2022 00:08:26 -0700 (PDT)
X-Gm-Message-State: AOAM530GLz/MTDB++HLml/tpmGKql7sfcccww1ecJqMondJXSM72fwDa
 kse1NdQCjUYpbFnU3NYTWzN8zHDJNgCjE5YBx/g=
X-Google-Smtp-Source: ABdhPJyxQL7zXUvqc8Kd4IsKQ8DDXXLoN0a7JzRoOljSaWzZBetR0EfL9eTA1FbUSvR8gVY1EVpw67HhWtjipCJXf7Q=
X-Received: by 2002:a5d:5986:0:b0:20c:5844:820d with SMTP id
 n6-20020a5d5986000000b0020c5844820dmr1442079wri.192.1651820906011; Fri, 06
 May 2022 00:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220506022638.15864-1-yuehaibing@huawei.com>
In-Reply-To: <20220506022638.15864-1-yuehaibing@huawei.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 6 May 2022 09:08:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2iPwOaRgrW6gw+8ZvxwKDROWFtoCz2LLF9RFDuDrEcJQ@mail.gmail.com>
Message-ID: <CAK8P3a2iPwOaRgrW6gw+8ZvxwKDROWFtoCz2LLF9RFDuDrEcJQ@mail.gmail.com>
Subject: Re: [PATCH -next] ASoC: mediatek: mt8195: Fix build warning without
 CONFIG_OF
To: YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bqFmcCz5P7OK68sSlVwqeEEs4lFgGO56hJuUzAtYvuLViqJZgAP
 sMMahvfaEKN95U/Wd84t4yE2g4C8G7f8bmr0pJkE++n26kYbhybh7vhdGOgpeVDBK2VROYQ
 zbZmMFZixHkU+t6GpQ+ABuWr5FFfy7SoqViYQJIIkTHWrYcjrzCWbRXGXPyvAwFOPf7TC8C
 Maxyb3H/DPa2RrXtvYw1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZW7QETVaCm0=:83N0s+iicRZgfV4GN45gki
 XQW621WMHX2zDw1FxYDH5aCRicq8MCjh1trlizHFGLQAl0MK66KZN6pceWDrYvWPeTkCcmlCB
 F/kKF6CSPlmKIIDCO1UCK5PTMD44sftMPPGiwkpbzbvYmKJs8FIw6uA+i89LOYJQqDHx26hDc
 EcVXw/svTgBbZ8Sdd8N/LP+a9t7nY+NQoBg7YYprXHW2o7u6rmmoOoPWdgTB3z1BMIhiHFSbC
 1Q2QXKenrL5lFEoA5bbpe3ygZjnA/Q5sa7KKrG8FroM9s8KyiCTbO+JvP5+QWoFUvr09+AAwO
 bVPMFlRvbObSR1bbC/YesRPoWLMwh5hz/IKuQhIFtfmjFZ2drvRIi0fZbWaL+NYYjqsXUc//g
 gFWG3grvCtoN7HNwmuJ45rsMsOPJrhC+kzzcEeVWyLRu99Nxl5ov4SJehjtzoouSPbXdh9LXA
 hdUxbCQjyDiccFbKQC8E6cSMhHeQWNnC+1HtjYGxliIcNnWQTUUGB31YRpsJnwWV6UlEmr/9i
 A1jBZRhUT6PwLTuffzfIde5L5FtI1VmAS2tlbB5iWj7zzzc3FRPz63iCBpd1nbd93zXWaHbgN
 BjLsYkHCaN7A/WBPSKm18mPQttkT2+iRV7qGRJpIgHBZgpYnKhKnLpKSIKEgCom2WNgc4jXoB
 pYwSy+x3pbbQnulKQbMMnHQIXPMFUUVqSv/V/KN3C83FstdTEHZnD82oauVQGx7olCffzIyJ3
 WhnH01uFRqwOhjd2+3WoY+pMACix2qm+gAxvbZc0VIM+ROlrHFbxU0kmeEG+l+17JmD0pDdjW
 zKCAusDLezgrABQdFHuIvVGz6eazASeyADy5yOVWgQSWqKLd60=
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Tzung-Bi Shih <tzungbi@google.com>, Mark Brown <broonie@kernel.org>,
 "moderated list:ARM/Mediatek SoC..." <linux-mediatek@lists.infradead.org>,
 Trevor Wu <trevor.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

On Fri, May 6, 2022 at 4:26 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> sound/soc/mediatek/mt8195/mt8195-mt6359.c:1639:32: warning: =E2=80=98mt81=
95_mt6359_max98390_rt5682_card=E2=80=99 defined but not used [-Wunused-vari=
able]
>  1639 | static struct mt8195_card_data mt8195_mt6359_max98390_rt5682_card=
 =3D {
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/mediatek/mt8195/mt8195-mt6359.c:1634:32: warning: =E2=80=98mt81=
95_mt6359_rt1011_rt5682_card=E2=80=99 defined but not used [-Wunused-variab=
le]
>  1634 | static struct mt8195_card_data mt8195_mt6359_rt1011_rt5682_card =
=3D {
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/mediatek/mt8195/mt8195-mt6359.c:1629:32: warning: =E2=80=98mt81=
95_mt6359_rt1019_rt5682_card=E2=80=99 defined but not used [-Wunused-variab=
le]
>  1629 | static struct mt8195_card_data mt8195_mt6359_rt1019_rt5682_card =
=3D {
>       |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> These variables is only used with CONFIG_OF, move it into the ifdef block=
.
>
> Fixes: 86a6b9c9dfff ("ASoC: mediatek: mt8195: add machine support for max=
98390 and rt5682")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

It's generally better to remove the #ifdef rather than expanding it,
there is no need to
save a few bytes on kernel builds of this driver that disable
CONFIG_OF. Just drop
the of_match_ptr() macro as well.


        Arnd
