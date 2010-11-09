From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Update DAPM debug and error
 prints
Date: Tue, 09 Nov 2010 18:26:50 +0000
Message-ID: <1289327210.3290.14.camel@odin>
References: <1289306428-1067-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 49BBB103879
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 19:26:54 +0100 (CET)
Received: by wwi17 with SMTP id 17so5078837wwi.20
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 10:26:54 -0800 (PST)
In-Reply-To: <1289306428-1067-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-11-09 at 14:40 +0200, Jarkko Nikula wrote:
> Switch printk and pr_ prints to dev_ variants. It is helpful to see
> parent device of DAPM context especially when there are multiple DAPM
> contexts (codecs currently).
> 
> This is mostly simple conversion. Exceptions are in snd_soc_dapm_set_pin
> that prints also pin state, uniform "dapm: unknown pin" error prints from
> snd_soc_dapm_set_pin, snd_soc_dapm_force_enable_pin and
> snd_soc_dapm_ignore_suspend, and pop_dbg which is converted by an another
> patch.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---

Both 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
