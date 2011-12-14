From: Michael Williamson <michael.williamson@criticallink.com>
Subject: [RFC PATCH 0/1] ASoC: dsd1791: Introduce driver for TI
	DSD1791 stereo codec
Date: Wed, 14 Dec 2011 18:40:42 -0500
Message-ID: <1323906043-28408-1-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B22DA1037FC
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 00:42:56 +0100 (CET)
Received: by qadz3 with SMTP id z3so1029517qad.17
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 15:42:53 -0800 (PST)
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
Cc: Michael Williamson <michael.williamson@criticallink.com>, lrg@ti.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The following patch is an introduction of a codec driver for the TI DSD1791
audio part.

This patch adds basic support and has been tested using a MityDSP-L138F SOM sitting
on a Critical Link Industrial I/O evaluation board in 16 bit and 24 bit I2S mode.

This is an RFC, as I'm still wandering around the ALSA framework a bit.  Comments
and guidance greatly appreciated.  I can follow with control registers (gain, etc.)
if this stuff looks OK.  Thanks.

-Mike

Michael Williamson (1):
  ASoC: dsd1791: Introduce driver for TI DSD1791 stereo codec

 sound/soc/codecs/Kconfig   |    4 +
 sound/soc/codecs/Makefile  |    2 +
 sound/soc/codecs/dsd1791.c |  282 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/codecs/dsd1791.c

-- 
1.7.5.4
