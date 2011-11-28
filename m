From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: Staticise and constify
 cs42l73_reg_defaults
Date: Mon, 28 Nov 2011 15:26:53 -0600
Message-ID: <alpine.DEB.2.02.1111281514430.8911@heelrod.ad.cirrus.com>
References: <1321974896-11286-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 37E6C10395B
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 22:28:28 +0100 (CET)
In-Reply-To: <1321974896-11286-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> -struct reg_default cs42l73_reg_defaults[] = {
> +static const struct reg_default cs42l73_reg_defaults[] = {
> 	{ 1, 0x42 },	/* r01	- Device ID A&B */
> 	{ 2, 0xA7 },	/* r02	- Device ID C&D */
> 	{ 3, 0x30 },	/* r03	- Device ID E */

Shouldn't this require struct reg_default *reg_defaults;
be const as well?

sound/soc/codecs/cs42l73.c:1327: warning: initialization discards 
qualifiers from pointer target type

Or not use const?

-Brian
