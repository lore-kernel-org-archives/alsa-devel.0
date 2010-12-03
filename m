From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/3] ASoC: Laying the groundwork for
 compress_type overriding
Date: Fri, 03 Dec 2010 16:15:57 +0000
Message-ID: <1291392957.3271.142.camel@odin>
References: <1291301583-15491-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42])
	by alsa0.perex.cz (Postfix) with ESMTP id D2D2C103B19
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 17:16:00 +0100 (CET)
Received: by ewy1 with SMTP id 1so5225093ewy.29
	for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2010 08:16:00 -0800 (PST)
In-Reply-To: <1291301583-15491-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-12-02 at 14:53 +0000, Dimitris Papastamos wrote:
> This patch series is to prepare ASoC for allowing the compress_type of the
> codec to be overriden by the machine driver.  Typically this will be done by
> providing an snd_soc_codec_conf struct which will contain the new compress_type
> in the machine driver.
> 
> Dimitris Papastamos (3):
>   ASoC: Add compress_type as a member to snd_soc_codec
>   ASoC: Change the base value of compress_type
>   ASoC: soc-core: Generalize snd_soc_prefix_map and rename to
>     snd_soc_codec_conf
> 
> _______________________________________________

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
