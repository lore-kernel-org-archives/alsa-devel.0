From: Michael Williamson <michael.williamson@criticallink.com>
Subject: Re: [RFC PATCH 1/1] ASoC: dsd1791: Introduce driver
 for TI DSD1791 stereo codec
Date: Thu, 15 Dec 2011 15:32:22 -0500
Message-ID: <4EEA5956.1090208@criticallink.com>
References: <1323906043-28408-1-git-send-email-michael.williamson@criticallink.com>
	<1323906043-28408-2-git-send-email-michael.williamson@criticallink.com>
	<20111215071621.GE24248@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id B0AC9247E6
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 21:32:30 +0100 (CET)
Received: by qadz3 with SMTP id z3so1681862qad.17
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 12:32:27 -0800 (PST)
In-Reply-To: <20111215071621.GE24248@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 12/15/2011 2:16 AM, Mark Brown wrote:

> On Wed, Dec 14, 2011 at 06:40:43PM -0500, Michael Williamson wrote:
>


[...]

>> +static int dsd1791_set_sysclk(struct snd_soc_dai *codec_dai,
>> +				int clk_id, unsigned int freq, int dir)
>> +{
>> +	struct snd_soc_codec *codec = codec_dai->codec;
>> +	struct dsd1791 *dsd1791 = snd_soc_codec_get_drvdata(codec);
>> +	dsd1791->mclk = freq;
>> +	return 0;
>> +}
>
> Implement this as a CODEC wide operation, it's simpler.



Not sure I follow you here.  Are you meaning to create something to
replace these lines (which are in many of the routines) with a local inline?

>> +	struct snd_soc_codec *codec = codec_dai->codec;
>> +	struct dsd1791 *dsd1791 = snd_soc_codec_get_drvdata(codec);



Or are you talking about the entire function?  I think I will remove this
entire function.  The mclk is not yet used, but could be if support for
some additional features of the chip is added.  If I get that far I'll
put it back in.

I understand all your other comments and will incorporate.  Thanks for
your review time.

-Mike
