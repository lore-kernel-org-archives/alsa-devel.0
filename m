From: Timur Tabi <timur@freescale.com>
Subject: Re: asoc multi-component: CPU DAI name is wrong
Date: Fri, 23 Jul 2010 13:56:07 -0500
Message-ID: <4C49E5C7.8020500@freescale.com>
References: <4C48BEBA.8080207@freescale.com> <1279908983.3076.8.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EAD510382A
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 20:56:12 +0200 (CEST)
Received: from mail59-va3 (localhost.localdomain [127.0.0.1])	by
	mail59-va3-R.bigfish.com (Postfix) with ESMTP id BC2321BE8113	for
	<alsa-devel@alsa-project.org>; Fri, 23 Jul 2010 18:56:10 +0000 (UTC)
Received: from VA3EHSMHS009.bigfish.com (unknown [10.7.14.254])	by
	mail59-va3.bigfish.com (Postfix) with ESMTP id 8B678117004F	for
	<alsa-devel@alsa-project.org>; Fri, 23 Jul 2010 18:56:10 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6NIu768002491	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 11:56:07 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6NIuDDY020870	for <alsa-devel@alsa-project.org>;
	Fri, 23 Jul 2010 13:56:13 -0500 (CDT)
In-Reply-To: <1279908983.3076.8.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> My mistake, I'd missed something in the forward port. I've fixed the DAI
> naming problem and you should see your DAI use the correct name.

Looks like you forgot something:

  CC      sound/soc/soc-core.o
sound/soc/soc-core.c: In function 'snd_soc_register_dai':
sound/soc/soc-core.c:2872: error: 'struct snd_soc_dai' has no member named 'id'
sound/soc/soc-core.c: In function 'snd_soc_register_dais':
sound/soc/soc-core.c:2949: error: 'struct snd_soc_dai' has no member named 'id'
sound/soc/soc-core.c: In function 'snd_soc_register_platform':
sound/soc/soc-core.c:3004: error: 'struct snd_soc_platform' has no member
named 'id'
sound/soc/soc-core.c: In function 'snd_soc_register_codec':
sound/soc/soc-core.c:3102: error: 'struct snd_soc_codec' has no member named
'id'
make[2]: *** [sound/soc/soc-core.o] Error 1
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2
