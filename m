From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH RFT] ASoC: sgtl5000: Fix up define for
	SGTL5000_SMALL_POP
Date: Wed, 22 Jul 2015 17:45:54 +0800
Message-ID: <CAFRkauBy06Ua6UZ1oonH9asb8pHXc045V4o-tVEGZEAMbm8MLw@mail.gmail.com>
References: <1437535665.17780.1.camel@ingics.com> <1979834.BYYY6Fhuui@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id C9A7C2606CA
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 11:45:54 +0200 (CEST)
Received: by lblf12 with SMTP id f12so132891772lbl.2
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 02:45:54 -0700 (PDT)
In-Reply-To: <1979834.BYYY6Fhuui@ws-stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Zeng Zhaoming <zengzm.kernel@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Filip Brozovic <fbrozovic@gmail.com>
List-Id: alsa-devel@alsa-project.org

2015-07-22 16:58 GMT+08:00 Alexander Stein
<alexander.stein@systec-electronic.com>:
> On Wednesday 22 July 2015 11:27:45, Axel Lin wrote:
>> Currently, below code actually does not update any bit because
>> SGTL5000_SMALL_POP is 0.
>>
>> snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL, SGTL5000_SMALL_POP, 1);
>>
>> The SGTL5000_SMALL_POP should be BIT(0) rather than 0, fix it.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
> I can not test this right now, but it seems appropriate.
> Acked-By: Alexander Stein <alexander.stein@systec-electronic.com>
>
>> Hi,
>> I don't have h/w and datasheet, but the code looks obvious does not make
>> sense. Can someone help to confirm and test if this patch?
>
> The datasheet can be found online: http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=SGTL5000&fpsp=1&tab=Documentation_Tab

I just checked the datasheet and confirm the SMALL_POP is BIT(0).
Thanks,
Axel
