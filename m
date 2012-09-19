From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 4/5] ASoC: wm8960: add support for
 big-endian audio samples
Date: Wed, 19 Sep 2012 02:58:29 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B70805EFC4@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1347657278-25295-1-git-send-email-timur@freescale.com>
 <1347657278-25295-4-git-send-email-timur@freescale.com>
 <20120919023404.GC8832@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 526C526512E
 for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2012 04:58:35 +0200 (CEST)
In-Reply-To: <20120919023404.GC8832@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <CBB5A23F92C3E04880C048B336C57947@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
>> >+	snd_pcm_format_t format = params_format(params);
>> >  	int i;
>> >
>> >  	/* bit size */
>> >-	switch (params_format(params)) {
>> >+	switch (format) {
> ...please don't introduce unrelated changes, especially ones you don't
> mention in the changelog.

Well, the introduction of variable 'format' is for the default case in the 
switch statement:

+       default:
+               dev_err(codec->dev, "unsupported format %i\n", format);
+               return -EINVAL;

I would not call this change "unrelated".

-- 
Timur Tabi
Linux kernel developer at Freescale
