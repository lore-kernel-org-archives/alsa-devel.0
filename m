From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2.6.38] ASoC: CX20442: fix wrong
 reg_cache_default content
Date: Thu, 10 Feb 2011 23:59:57 +0000
Message-ID: <1297382397.3313.102.camel@odin>
References: <201102101324.40463.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 66006243FA
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 01:00:00 +0100 (CET)
Received: by wwe15 with SMTP id 15so1964092wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 16:00:00 -0800 (PST)
In-Reply-To: <201102101324.40463.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-02-10 at 13:24 +0100, Janusz Krzysztofik wrote:
> Content of the CX20442's snd_soc_codec_driver.reg_cache_default pointed 
> area, introduced with my recent NULL pointer dereferece fix (commit 
> f019ee5feb344ff0b22b58df4568676295aae14f), occured wrong after further 
> testing, more thorough than just booting successfully. There are two 
> problems with it:
> 
> 1) It should read
> 	(1 << CX20442_TELOUT) | (1 << CX20442_MIC),
>    not 
> 	CX20442_TELOUT | CX20442_MIC.
> 
> 2) While correctly matching actual codec hardware state on boot when 
>    fixed per 1), a few more code modifications would still be required 
>    to reflect that state not only into register cache, but also force 
>    them into DAPM pins state, otherwise an inconsitency occures which 
>    may prevent further codec state changes from being applied correctly. 
>    As a result, the phone stops ringing after reboot, until someone 
>    picks up the handset for the first time.
> 
> Revert that reg_cache_default content to a working, previous de facto 
> default value of 0, in hope this change can still be accepted as an rc 
> cycle fix.
> 
> Created and tested against linux-2.6.38-rc4
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
