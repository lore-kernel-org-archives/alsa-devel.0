From: "Handrigan, Paul" <Paul.Handrigan@cirrus.com>
Subject: Re: [bug report] ASoC: cs35l34: Initial commit of the
 cs35l34 CODEC driver.
Date: Thu, 10 Nov 2016 15:21:14 +0000
Message-ID: <D449EC6A.18966%Paul.Handrigan@cirrus.com>
References: <20161110125402.GB18664@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 40A5426663B
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 16:21:18 +0100 (CET)
In-Reply-To: <20161110125402.GB18664@mwanda>
Content-Language: en-US
Content-ID: <0BE56E2E7349B647BB0E586FFDB6446A@ad.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On 11/10/16, 6:54 AM, "Dan Carpenter" <dan.carpenter@oracle.com> wrote:

>Hello Paul Handrigan,
>
>The patch c1124c09e103: "ASoC: cs35l34: Initial commit of the cs35l34
>CODEC driver." from Oct 12, 2016, leads to the following static
>checker warning:
>
>	sound/soc/codecs/cs35l34.c:613 cs35l34_dai_set_sysclk()
>	warn: odd binop '0xffffffffffffffef & 0x0'
>
>sound/soc/codecs/cs35l34.c
>   604  static int cs35l34_dai_set_sysclk(struct snd_soc_dai *dai,
>   605                                  int clk_id, unsigned int freq,
>int dir)
>   606  {
>   607          struct snd_soc_codec *codec = dai->codec;
>   608          struct cs35l34_private *cs35l34 =
>snd_soc_codec_get_drvdata(codec);
>   609          unsigned int value;
>   610  
>   611          switch (freq) {
>   612          case CS35L34_MCLK_5644:
>   613                  value = ~CS35L34_MCLK_DIV &
>CS35L34_MCLK_RATE_5P6448;
>                  
>^^^^^^^^^^^^^^^^^^^^^^^^
>This is zero.  Maybe intentional?  If so just send a reply to this email
>and I won't bother you again.
This is ok.

>
