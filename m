From: Daniel Matuschek <daniel@matuschek.net>
Subject: Re: [PATCH] ASoC: wm8804: Allow fine-grained control
	of the PLL generation
Date: Thu, 9 Jan 2014 16:29:13 +0100
Message-ID: <9DF5D0F7-F5A7-4705-8ACB-286B49D668C1@matuschek.net>
References: <alpine.DEB.2.02.1401082231260.4025@parallels-Parallels-Virtual-Platform>
 <20140109142745.GB6110@opensource.wolfsonmicro.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f174.google.com (mail-ea0-f174.google.com
 [209.85.215.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E4502652DC
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 16:29:17 +0100 (CET)
Received: by mail-ea0-f174.google.com with SMTP id b10so1543841eae.33
 for <alsa-devel@alsa-project.org>; Thu, 09 Jan 2014 07:29:16 -0800 (PST)
In-Reply-To: <20140109142745.GB6110@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Dimitris.Papastamos@Wolfsonmicro.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org


On 09.01.2014, at 15:27, Charles Keepax <ckeepax@opensource.wolfsonmicro.com> wrote:

> On Wed, Jan 08, 2014 at 10:36:53PM +0100, Daniel Matuschek wrote:
>> Signed-off-by: Daniel Matuschek <daniel@matuschek.net>
>> 
> 
> <snip>
> 
>> 			pll_div->freqmode = post_table[i].freqmode;
>> -			pll_div->mclkdiv = post_table[i].mclkdiv;
>> -			target *= post_table[i].div;
>> -			break;
>> +			if ((mclk_div == WM8804_MCLKDIV_DONTCARE) ||
>> +			    ((post_table[i].mclkdiv == 1) &&
>> +				(mclk_div == WM8804_MCLKDIV_1)) ||
>> +			    ((post_table[i].mclkdiv == 0) &&
>> +				(mclk_div == WM8804_MCLKDIV_0))) {
> 
> Would probably be nicer to update the post_table to use the new
> defines and directly compare.

Yes, this is an option.

> 
>> +				pll_div->mclkdiv = post_table[i].mclkdiv;
>> +				target *= post_table[i].div;
>> +				break;
>> +			}
>> 		}
>> 	}
>> 
>> @@ -388,7 +396,7 @@ static int wm8804_set_pll(struct snd_soc_dai *dai, int pll_id,
>> 		int ret;
>> 		struct pll_div pll_div;
>> 
>> -		ret = pll_factors(&pll_div, freq_out, freq_in);
>> +		ret = pll_factors(&pll_div, freq_out, freq_in, pll_id);
> 
> This does feel like a slight abuse of pll_id, it feels to me that
> using the set_clkdiv callback would be a little more natural from
> a user perspective.

Good idea, I will move it to set_clkdiv.

> 
>> 		if (ret)
>> 			return ret;
>> 
>> diff --git a/sound/soc/codecs/wm8804.h b/sound/soc/codecs/wm8804.h
>> index 8ec14f5..0365177 100644
>> --- a/sound/soc/codecs/wm8804.h
>> +++ b/sound/soc/codecs/wm8804.h
>> @@ -58,4 +58,11 @@
>> 
>> #define WM8804_CLKOUT_DIV			1
>> 
>> +#define WM8804_MCLKDIV_DONTCARE			0
>> +#define WM8804_MCLKDIV_0			1
>> +#define WM8804_MCLKDIV_1			2
>> +#define WM8804_PLL_MCLKDIV_DONTCARE		WM8804_MCLKDIV_DONTCARE
>> +#define WM8804_PLL_MCLKDIV_0			WM8804_MCLKDIV_0
>> +#define WM8804_PLL_MCLKDIV_1			WM8804_MCLKDIV_1
> 
> Do we really need two copies of these?

Not really ;-) I will remove the duplicates.
