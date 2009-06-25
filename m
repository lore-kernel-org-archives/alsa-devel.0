From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add EXT_MUTE gpio to reduce
 pop-noise effect
Date: Thu, 25 Jun 2009 10:54:15 +0300
Message-ID: <20090625105415.43ca95be.jhnikula@gmail.com>
References: <1245896733-3973-1-git-send-email-x0107209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f226.google.com (mail-ew0-f226.google.com
	[209.85.219.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F4D124B2F
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 09:53:35 +0200 (CEST)
Received: by ewy26 with SMTP id 26so127400ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2009 00:53:35 -0700 (PDT)
In-Reply-To: <1245896733-3973-1-git-send-email-x0107209@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jorge Eduardo Candelaria <x0107209@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Jun 2009 21:25:33 -0500
Jorge Eduardo Candelaria <x0107209@ti.com> wrote:

> According to TRM, an external FET controlled by a 1.8V output signal
> can be used to reduce the pop-noise heard when the audio amplifier is
> switched on.
> 
> The signal is controlled by a gpio pin and should be defined in the
> machine driver. However, the codec driver takes care of enabling and
> disabling this output during the headset pop attenuation sequence.
> 
> If the board does not have an EXT_MUTE, then the machine driver should
> set the value of ext_mute_gpio to -EINVAL through ramp delay setup
> data, to bypass execution of the code that manages the gpio line.
> 
Two cents side comment. Are there any reason why the mute FET can not
be driven on thus grounding the output pin always when output is not
active? I know this patch follows the TPS65950 TRM but IMO simplier and
cleanear would be consider this FET like an amplifier (with inverted
control) and define and control it only from machine driver.


-- 
Jarkko
