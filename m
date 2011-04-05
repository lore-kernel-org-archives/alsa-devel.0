From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [patch 1/1] sgtl5000: Fix suspend/resume
Date: Tue, 05 Apr 2011 09:56:12 +0200
Message-ID: <87aag5m8rn.fsf@lebrac.rtp-net.org>
References: <20110404151315.251129690@rtp-net.org>
	<20110405001858.GD5376@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lebrac.rtp-net.org (lebrac.rtp-net.org [88.191.135.105])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C308103995
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Apr 2011 09:56:27 +0200 (CEST)
In-Reply-To: <20110405001858.GD5376@opensource.wolfsonmicro.com> (Mark Brown's
	message of "Tue, 5 Apr 2011 09:18:59 +0900")
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Mon, Apr 04, 2011 at 05:13:00PM +0200, Arnaud Patard wrote:
>
>>  /* default value of sgtl5000 registers except DAP */
>> -static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET >> 1] =  {
>> +static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET] =  {
>>  	0xa011, /* 0x0000, CHIP_ID. 11 stand for revison 17 */
>> +	0,
>
> It's not immediately obvious that this is the best fix - the driver does
> declare a step of 2 so I'd expect it to be able to lay out the cahce
> defaults like this.  Also, it'd be easier to review the patch if you

The sgtl5000 driver is using:

static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET >> 1] =  {
       ...
};

...

.reg_cache_size = ARRAY_SIZE(sgtl5000_regs),

Which means that reg cache size is SGTL5000_MAX_REG_OFFSET / 2 and
register values stored without any "holes" in the array, except that in
flat cache case, ASoC does :

static int snd_soc_flat_cache_read(struct snd_soc_codec *codec,
                                   unsigned int reg, unsigned int
                                   *value)
{
        *value = snd_soc_get_cache_val(codec->reg_cache, reg,
                                       codec->driver->reg_word_size);
        return 0;
}

and snd_soc_get_cache_val returns cache[reg] which means that the cache
size must have a length of SGTL5000_MAX_REG_OFFSET and values stored
with "holes".

Also, without this change, the codec_reg debugfs files is returning
lines like :
0000: a0
instead of :
0000: a011

This is also the reason why resume was broken: the restored values were
not the right ones. Look at the restore regs code: instead of reading
cache[reg] like snd_soc_get_cache_val, it was reading cache[reg>>1].

Arnaud
