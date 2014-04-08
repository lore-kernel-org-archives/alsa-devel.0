From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5640: add rt5639 support
Date: Tue, 8 Apr 2014 11:33:27 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694359BF5@RTITMBSV03.realtek.com.tw>
References: <1396927929-31775-1-git-send-email-oder_chiou@realtek.com>
 <20140408110543.GC6518@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 907AA2675A1
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 13:33:32 +0200 (CEST)
In-Reply-To: <20140408110543.GC6518@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Tuesday, April 08, 2014 7:06 PM
> To: Oder Chiou
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Bard Liao; Flove
> Subject: Re: [PATCH] ASoC: rt5640: add rt5639 support
> 
> On Tue, Apr 08, 2014 at 11:32:09AM +0800, Oder Chiou wrote:
> 
> > -static const SOC_ENUM_SINGLE_DECL(rt5640_if1_dac_enum,
> RT5640_DIG_INF_DATA,
> > -				RT5640_IF1_DAC_SEL_SFT, rt5640_data_select);
> > +static SOC_ENUM_SINGLE_DECL(rt5640_if1_dac_enum,
> RT5640_DIG_INF_DATA,
> > +	RT5640_IF1_DAC_SEL_SFT, rt5640_data_select);
> 
> This seems to contain a lot of changes like this which are purely coding style
> changes rather than actual code changes.  As far as I can tell the majority of this
> change is coding style or comment changes.  Can you please split these out into
> separate commits, it is much harder to review if it's hard to find the active
> changes.  There's nothing wrong with the stylistic stuff particularly but it should
> be done as separate changes.

We will follow your recommendation and resend the patch.
