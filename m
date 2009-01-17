From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
 machines that use it.
Date: Sat, 17 Jan 2009 18:47:11 +0000
Message-ID: <497227AF.1080907@mnementh.co.uk>
References: <496E8DD0.4090006@mnementh.co.uk> <s5hfxjl3v6s.wl%tiwai@suse.de>
	<496F0ABD.4080207@mnementh.co.uk>
	<s5hk58v4inq.wl%tiwai@suse.de> <497070D1.50301@mnementh.co.uk>
	<20090116115408.GB7554@sirena.org.uk>
	<49708E21.1060800@mnementh.co.uk>
	<20090116143135.GG7554@sirena.org.uk>
	<4970ABCB.5050300@mnementh.co.uk>
	<20090117175844.GE7210@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A6861037FC
	for <alsa-devel@alsa-project.org>; Sat, 17 Jan 2009 19:46:35 +0100 (CET)
In-Reply-To: <20090117175844.GE7210@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Jan 16, 2009 at 03:46:19PM +0000, Ian Molton wrote:
> 
>> Mark, the changes requested are implemented below. There are two
>> patchsets, one for wm9705 and one for the other codec issues I found.
> 
> This looks good, thanks - I've applied it.  A couple of the changes
> appear to be pure formatting changes:

Thanks,

Comments below on your comments:

>> --- a/sound/soc/codecs/ad1980.c
>> +++ b/sound/soc/codecs/ad1980.c
>> @@ -109,7 +109,7 @@ static unsigned int ac97_read(struct snd_soc_codec  
>> *codec,
>>  	default:
>>  		reg = reg >> 1;
>>
>> -		if (reg >= (ARRAY_SIZE(ad1980_reg)))
>> +		if (reg >= ARRAY_SIZE(ad1980_reg))
>>  			return -EINVAL;
>>
>>  		return cache[reg];
> 
> Formatting changes only in this driver?  Not sure I really like the
> extra brackets.

Exactly - nor did I, so  Iremoved them :-)

>> diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
>> index 6b27786..f93c095 100644
>> --- a/sound/soc/codecs/wm8990.c
>> +++ b/sound/soc/codecs/wm8990.c
>> @@ -116,7 +116,7 @@ static inline unsigned int  
>> wm8990_read_reg_cache(struct snd_soc_codec *codec,
>>  	unsigned int reg)
>>  {
>>  	u16 *cache = codec->reg_cache;
>> -	BUG_ON(reg > (ARRAY_SIZE(wm8990_reg)) - 1);
>> +	BUG_ON(reg >= ARRAY_SIZE(wm8990_reg));
>>  	return cache[reg];
>>  }
>>
> 
> These two bits of code are equivalent...

Yes but one is clearer and more commonly used. Testing for 'more than 
one less than the array size' is just a bit... meh :-)

(plus its inconsistent with all the other drivers as it was)

-Ian
