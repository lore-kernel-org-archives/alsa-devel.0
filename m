From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Choosing the sysclk in simple-card looks broken to
	me.
Date: Mon, 11 Aug 2014 08:04:23 -0400
Message-ID: <CAKON4OzaPMwAB52iuBjL_xAWcp3yMmtFRwWH=9keTCj9zh+1Sg@mail.gmail.com>
References: <CAKON4Oxusv_VuHNgbum1wBBz_N_V-a11N_rPu8m-rLFYAcQ_sQ@mail.gmail.com>
 <20140810105405.GW17528@sirena.org.uk>
 <CAKON4OzhSFJ4-cGkbr10LNorb+ihi6gqm1V4-YhTMHq8kmcWGg@mail.gmail.com>
 <CAKON4OxvoLBiq64t6Oh1i3CgA=Zy5DU7xYEe2kkpVdWkXMmqsg@mail.gmail.com>
 <20140811104854.GX17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B67D26518A
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 14:04:24 +0200 (CEST)
Received: by mail-la0-f42.google.com with SMTP id pv20so6650293lab.1
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 05:04:23 -0700 (PDT)
In-Reply-To: <20140811104854.GX17528@sirena.org.uk>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, zengzm.kernel@gmail.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 11, 2014 at 6:48 AM, Mark Brown <broonie@kernel.org> wrote:
> On Sun, Aug 10, 2014 at 02:42:23PM -0400, jonsmirl@gmail.com wrote:
>> This should fix it to use the output clocks, but does it break any of
>> the other DTS using simple-audio?
>>
>> diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
>> index 03a7fdc..8c4b267 100644
>> --- a/sound/soc/generic/simple-card.c
>> +++ b/sound/soc/generic/simple-card.c
>> @@ -116,6 +116,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
>>  {
>>   struct device_node *node;
>>   struct clk *clk;
>> + const char *clk_name = NULL;
>>   int ret;
>>
>>   /*
>> @@ -156,11 +157,14 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
>>       "system-clock-frequency",
>>       &dai->sysclk);
>>   } else {
>> - clk = of_clk_get(node, 0);
>> - if (!IS_ERR(clk))
>> - dai->sysclk = clk_get_rate(clk);
>> + of_property_read_string(node, "clock-output-names", &clk_name);
>> + if (clk_name) {
>> + clk = of_clk_get_by_name(node, clk_name);
>> + if (!IS_ERR(clk)) {
>> + dai->sysclk = clk_get_rate(clk);
>> + }
>
> Jon, please use indentation when sending code via e-mail - this is far
> too hard to read.

Seems that gmail is eating my tabs. I'll see if I can set the my
editor to convert them to spaces before pasting.

-- 
Jon Smirl
jonsmirl@gmail.com
