From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: ASoC for TI OMAP - Multiformat ASoC DAI link driver?
Date: Wed, 2 Apr 2008 13:45:38 +0300
Message-ID: <20080402134538.67d67d6e.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 9314E243F3
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Apr 2008 12:45:23 +0200 (CEST)
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m32Aimdp016902
	for <alsa-devel@alsa-project.org>; Wed, 2 Apr 2008 13:45:21 +0300
Received: from kikka3 (esdhcp04048.research.nokia.com [172.21.40.48])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with SMTP id
	m32Aj6K1000813
	for <alsa-devel@alsa-project.org>; Wed, 2 Apr 2008 13:45:06 +0300
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently in ASoC v1 we have one DAI driver per one format? E.g.
separate drivers for I2S, AC97, etc and type field in cpu_dai
structure is not a bit field or at least not used such way in
soc-core.c and DAI link drivers.

struct snd_soc_cpu_dai pxa_i2s_dai = {
...
	.type = SND_SOC_DAI_I2S,
...

I looked shortly asoc-v2-dev branch and now this type field is gone.
Does it mean that there you can have DAI link driver which supports
multiple formats in set_fmt callback?

I'm asking this since McBSP (Multichannel Buffered Serial Port) found
in OMAP processors can be configured to almost any imaginable format
and IMO it doesn't make a sense to have separate drivers for each of
them if there is a difference only in few configuration bits.

-- 
Jarkko
