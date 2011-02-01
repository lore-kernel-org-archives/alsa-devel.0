From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv2] ASoC: omap: rx51: Add earphone support
Date: Tue, 01 Feb 2011 13:59:59 +0000
Message-ID: <1296568799.3327.12.camel@odin>
References: <20110127152718.GB9774@opensource.wolfsonmicro.com>
	<1296477828-19434-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 260E024519
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 15:00:03 +0100 (CET)
Received: by wwe15 with SMTP id 15so6792092wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 06:00:02 -0800 (PST)
In-Reply-To: <1296477828-19434-1-git-send-email-jhnikula@gmail.com>
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

On Mon, 2011-01-31 at 14:43 +0200, Jarkko Nikula wrote:
> Earphone in Nokia RX-51/N900 is connected to left HP output of B part of the
> TLV320AIC34 dual codec. In RX-51 the codec A is used as a traditional codec
> and the codec B as an auxiliary device.
> 
> Audio from codec A goes via the codec B to earphone:
> MONO_LOUT of A -> LINE2R of B (B interconnects) -> HPLOUT of B -> Earphone.
> 
> Take earphone into use by utilizing the recent ASoC auxiliary and
> cross-device support.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> v2: Uses SOC_DAPM_PIN_SWITCH for implementing the "Earphone" widget and
> kcontrol.

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
