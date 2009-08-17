From: Shine Liu <shinel@foxmail.com>
Subject: [PATCH] ASoC: UDA134X: Fix mistaken mute/unmute code
Date: Mon, 17 Aug 2009 18:52:01 +0800
Message-ID: <1250506321.1932.7.camel@shinel>
References: <1250498216.2764.1.camel@shinel>
	<20090817103248.GA4464@sirena.org.uk>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg74.qq.com (smtpbg74.qq.com [119.147.10.233])
	by alsa0.perex.cz (Postfix) with SMTP id 36FF210381B
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 12:52:46 +0200 (CEST)
In-Reply-To: <20090817103248.GA4464@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Resend the patch for the mistaken mute/unmute code.


Signed-off-by: Shine Liu <shinel@foxmail.com>


--- sound/soc/codecs/uda134x.c.orig	2009-07-14 09:18:52.000000000 +0800
+++ sound/soc/codecs/uda134x.c	2009-08-17 13:46:57.000000000 +0800
@@ -163,7 +163,7 @@
 	else
 		mute_reg &= ~(1<<2);
 
-	uda134x_write(codec, UDA134X_DATA010, mute_reg & ~(1<<2));
+	uda134x_write(codec, UDA134X_DATA010, mute_reg);
 
 	return 0;
 }


On Mon, 2009-08-17 at 11:32 +0100, Mark Brown wrote:
> On Mon, Aug 17, 2009 at 04:36:56PM +0800, Shine Liu wrote:
> > There is a mistake in current uda134x_mute function: mute_reg has been
> > changed in line 162 or line 164, so uda134x_write should write
> > "mute_reg" but not "mute_reg & ~(1<<2)" to 
> > UDA134X_DATA010.
> 
> This is OK but please split it out into a separate patch and resend
> since...
> 
> > Besides, because there is no DAPM configuration for uda134x, when system
> > starts up, snd_soc_int_card calls snd_soc_dapm_new_widgets, and
> > snd_soc_dapm_new_widgets calls dapm_power_widgets. In function
> > dapm_power_widgets, codec->dapm_widgets has no list entry, so sys_power
> > retains it's original value zero. Then
> 
> ...this isn't, partly because I can't really follow what you're trying
> to do here.  It looks awfully like you're trying to implement DAPM
> support - certainly things like adding the switches for DAC and ADC
> power shouldn't be there, they should be automatically managed in the
> drivers.
> 
> 
> 
