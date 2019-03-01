From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
Date: Fri, 1 Mar 2019 16:04:40 +1100
Message-ID: <5c60b8c7-cb85-dec8-0358-6773251d3f2c@flatmax.org>
References: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
 <20190301045041.GA5064@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0B26F8073C
 for <alsa-devel@alsa-project.org>; Fri,  1 Mar 2019 06:04:51 +0100 (CET)
In-Reply-To: <20190301045041.GA5064@Asurada>
Content-Language: en-AU
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

It would be a mistake to remove S32_LE from the format list.

If you removed that, then we wouldn't be able to do 32 bit native 
playback - it would force users to go through an ALSA plugin.

If you look at the cs42448 data sheet for example, the I2S and TDM bus 
uses a 32 bit word size. For that reason, native S32_LE format is 
handled by the codec. While the codec only uses the 24 MSBs, the I2S bus 
is 32 bit.

Matt

On 1/3/19 3:50 pm, Nicolin Chen wrote:
> Hi Shengjiu,
>
> On Thu, Feb 28, 2019 at 05:56:31AM +0000, S.j. Wang wrote:
>> cs42xx8 is a 24-bit A/D and 24-bit D/A device, so the S32_LE
>> should not be in the supported format list.
>>
>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>> ---
>>   sound/soc/codecs/cs42xx8.c | 3 +--
> This is for cs42xx8 codec driver, but its maintainers aren't
> seemly in To/Cc list. Please run ./scripts/get_maintainer.pl
> for it and resend.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
