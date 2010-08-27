From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 0/4] ASoC: tlv320aic3x: Output stage cleanup
Date: Fri, 27 Aug 2010 16:56:46 +0300
Message-ID: <1282917410-12000-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 51EE424611
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 15:56:02 +0200 (CEST)
Received: by eyd9 with SMTP id 9so2009580eyd.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 06:56:01 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi

I have had always difficulties to remember which aic3x mixer control controls
what route but haven't bothered to look any deeper until very recently
after wondering why the swapped routes aren't working. It turned out that
there were two reasons:

1. Output mixers were misdefined to mix output pins to internal signals
   where DAPM logic and hw as well does opposite
2. Swapped routes are not working due this misdefinition

Then there wasn't uniform way to represent and name volume controls for those
output mixer stages.

This patchset does first some minor cleanups, then fixes the mixer stage
also adding a few missing routes and then puts hopefully some logic to
output controls.

Unfortunately this means control name changes but hopefully driver is now more
understandable and complete.


-- 
Jarkko
