From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [bug report] ASoC: cs35l34: Initial commit of the
 cs35l34 CODEC driver.
Date: Thu, 10 Nov 2016 17:46:17 +0100
Message-ID: <e3e2e43c-0fa2-6566-f5ca-67fbb519adae@metafoo.de>
References: <D449EC6A.18966%Paul.Handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9862826663B
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 17:46:22 +0100 (CET)
In-Reply-To: <D449EC6A.18966%Paul.Handrigan@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 11/10/2016 04:21 PM, Handrigan, Paul wrote:
> 
> 
> On 11/10/16, 6:54 AM, "Dan Carpenter" <dan.carpenter@oracle.com> wrote:
> 
>> Hello Paul Handrigan,
>>
>> The patch c1124c09e103: "ASoC: cs35l34: Initial commit of the cs35l34
>> CODEC driver." from Oct 12, 2016, leads to the following static
>> checker warning:
>>
>> 	sound/soc/codecs/cs35l34.c:613 cs35l34_dai_set_sysclk()
>> 	warn: odd binop '0xffffffffffffffef & 0x0'
>>
>> sound/soc/codecs/cs35l34.c
>>   604  static int cs35l34_dai_set_sysclk(struct snd_soc_dai *dai,
>>   605                                  int clk_id, unsigned int freq,
>> int dir)
>>   606  {
>>   607          struct snd_soc_codec *codec = dai->codec;
>>   608          struct cs35l34_private *cs35l34 =
>> snd_soc_codec_get_drvdata(codec);
>>   609          unsigned int value;
>>   610  
>>   611          switch (freq) {
>>   612          case CS35L34_MCLK_5644:
>>   613                  value = ~CS35L34_MCLK_DIV &
>> CS35L34_MCLK_RATE_5P6448;
>>                  
>> ^^^^^^^^^^^^^^^^^^^^^^^^
>> This is zero.  Maybe intentional?  If so just send a reply to this email
>> and I won't bother you again.
> This is ok.

It is still a slightly unusual way to write this. And I can see why it'd
confuse both humans as well as static checkers. Usually if you don't want to
set a bit in a bitmask you just leave it out.
