From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: pcm1792a codec driver
Date: Sat, 3 Aug 2013 10:49:09 +0200
Message-ID: <20130803084908.GA7162@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f45.google.com (mail-ee0-f45.google.com [74.125.83.45])
 by alsa0.perex.cz (Postfix) with ESMTP id B51512617AE
 for <alsa-devel@alsa-project.org>; Sat,  3 Aug 2013 10:49:19 +0200 (CEST)
Received: by mail-ee0-f45.google.com with SMTP id c50so706137eek.32
 for <alsa-devel@alsa-project.org>; Sat, 03 Aug 2013 01:49:19 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark

Yesterday I have done the pcm1792a codec driver and tested connected
to the pandaboard es. The driver is working using spi/i2s connection with
the codec and support l/r attenuation and digital mute. Other fmt
are supported but not tested. Anyway it's a base of the complete driver.
Hope that I can take again the hardware for feature release.
Can I submit this initial support patch of it?

Michael
