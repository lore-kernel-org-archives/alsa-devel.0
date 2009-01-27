From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 0/6] ASoC: TWL4030: Cleanups and analog
	loopback support
Date: Tue, 27 Jan 2009 11:29:38 +0200
Message-ID: <1233048584-29662-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6458914227981858642=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 5482D103831
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 10:30:11 +0100 (CET)
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

--===============6458914227981858642==
Content-Type: text/plain; charset=unknown-8bit
Content-Transfer-Encoding: quoted-printable

Hello,
The following series - at the end - will add analog loopback/bypass suppo=
rt
for the twl4030 codec.

The main changes:
[1] ANAMICL register self cleaning bit handling
[2] Simplified power up/down function
[3] Move the Headset anti-pop/bias ramp enabling to be happend only if th=
e
    headset is actually in use
[4] Change the place for the DAC power switch
[5] Preparation for the loopback implementation
[6] Analog loopback/bypass implementation

You can find a bit more detailed notes in the actuall patches.

In short: if none of the loopbacks are enabled, the codec behaves in the
same way as it used to. If the loopback is enabled the codec will be kept
powered as long as the loopback is enabled.

P=E9ter

---
Peter Ujfalusi (6):
  ASoC: TWL4030: Syncronize the reg_cache for ANAMICL after the offset
    cancelation
  ASoC: TWL4030: Code clean up for codec power up and down
  ASoC: TWL4030: Enable Headset Left anti-pop/bias ramp only if the
    Headset Left is in use
  ASoC: TWL4030: Physical ADC and amplifier power switch change
  ASoC: TWL4030: Move the twl4030_power_up and _power_down function
  ASoC: TWL4030: Add analog loopback support

 sound/soc/codecs/twl4030.c |  340 ++++++++++++++++++++++++++++++--------=
------
 1 files changed, 232 insertions(+), 108 deletions(-)


--===============6458914227981858642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6458914227981858642==--
