From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [2.6.30-rc2][PATCH 0/2] Yet another DSP format fix
	into OMAP McBSP DAI
Date: Wed, 15 Apr 2009 13:48:15 +0300
Message-ID: <1239792497-31761-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 255951038CF
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 12:47:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hopefully this is the last fourth DSP format fix into McBSP DAI...

Tested with N810 modified to use DSP_B and with AIC33 codec. Also with Beagle
by using McBSP3 routed to expansion pin header and using scope.

Luckily TLV320AIC23 and TLV320AIC33 codec drivers seems to be correct but
machine driver for OSK5912 must be corrected to not use inverted FS polarity
since AIC23 doesn't have support for it.


-- 
Jarkko
