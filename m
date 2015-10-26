From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2] ASoC: wm9713: convert to regmap
Date: Mon, 26 Oct 2015 18:53:27 +0100
Message-ID: <8737wxldns.fsf@belgarion.home>
References: <1445722627-28854-1-git-send-email-robert.jarzmik@free.fr>
	<20151026110257.GH10520@ck-lbox>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151026110257.GH10520@ck-lbox> (Charles Keepax's message of
	"Mon, 26 Oct 2015 11:02:57 +0000")
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Charles Keepax <ckeepax@opensource.wolfsonmicro.com> writes:

> On Sat, Oct 24, 2015 at 11:37:07PM +0200, Robert Jarzmik wrote:
>> Convert the Wolfson WM9713 to regmap API. This will leverage all the
>> regmap functions (debug, registers update, etc ...).
>> 
>> As a bonus, this will pave the path to gpio chip introduction, and
>> devicetree support.
>> 
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>> Since v1: fix suspend/resume (that specific part is not tested yet)
>> ---
>>  sound/soc/codecs/Kconfig  |   1 +
>>  sound/soc/codecs/wm9713.c | 296 +++++++++++++++++++++++-----------------------
>>  2 files changed, 152 insertions(+), 145 deletions(-)
> <snip>
>> @@ -1156,16 +1165,17 @@ static int wm9713_set_bias_level(struct snd_soc_codec *codec,
>>  
>>  static int wm9713_soc_suspend(struct snd_soc_codec *codec)
>>  {
>> -	u16 reg;
>> +	regcache_cache_only(codec->component.regmap, true);
>> +	snd_soc_cache_sync(codec);
>
> I am assuming we don't want to be doing a cache_sync just after we
> have marked the regmap as cache only.
Ah, this denotes my lack of understanding of regmap cache behavior.
Basically what I want at this point is that :
 1) All previous writes should hit the cache (cache coherency barrier)
 2) All subsequent writes should not go into the cache (uncached writes)
    => especially the next writes in wm9713_soc_suspend()

>> +	snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x7fff,
>> +				 0x7fff);
>> +	snd_soc_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
>> +	snd_soc_write(codec, AC97_POWERDOWN, 0x6f00);
>> +	snd_soc_write(codec, AC97_POWERDOWN, 0xffff);
>
> Also as you have already marked the regmap as cache only these
> writes won't go to the hardware.
Ah, exactly the opposite of what I wanted :(

Would you have an example driver I can inspire myself from. If not, I'll dig in
more in the regmap cache API.

Cheers.

-- 
Robert
