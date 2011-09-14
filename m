From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/3] ASoC: support sample sizes properly in
 the WM8776 codec driver
Date: Wed, 14 Sep 2011 16:51:24 -0500
Message-ID: <4E7121DC.908@freescale.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<1316003710.3229.14.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 84D3110380B
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 23:52:25 +0200 (CEST)
In-Reply-To: <1316003710.3229.14.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

> Sounds like we also need this for the other codec drivers too at some
> point.

Yes, but I can only test *this* codec on a big-endian system. :-)

>>  	/* Set word length */
>> -	switch (params_format(params)) {
>> -	case SNDRV_PCM_FORMAT_S16_LE:
>> +	i = snd_pcm_format_width(params_format(params));
>> +	switch (i) {
> 
> Just a minor nitpick. I would not have used the intermediate 'i' here
> and would have just embedded the snd_pcm call within the switch(). I
> guess it may not fit the line width though.

'i' is used twice:

	switch (i) {

and

	dev_err(codec->dev, "Unsupported sample size: %i\n", i);

-- 
Timur Tabi
Linux kernel developer at Freescale
