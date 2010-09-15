From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Emulated IEC958 Card
Date: Wed, 15 Sep 2010 23:05:40 +0900
Message-ID: <AANLkTi=52wHCZZNSBitaMO+O6--JLHg7nmtNOVYQ6cof@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0ED0F1037E3
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Sep 2010 16:05:42 +0200 (CEST)
Received: by eye27 with SMTP id 27so83216eye.38
	for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2010 07:05:41 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, yadi brar <yadi.brar01@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

 Ok, so there is already the iec958 plugin, but wouldn't it be nice to have an
'Emulated IEC958-Card' driver that implements implements all the possible
components of the IEC958-cum-AES/EBU specification. The user could have
the look and feel of a real card via ALSA control and audio i/f ....
User Data can be
provided too (which lacks in the iec958 plugin ?)

This driver might be boon for low-end embedded devices which have neither IEC958
controller in the SoC nor a codec chip that supports it. In fact the
SPDIF controller
of one SoC that I know implements only a subset of the standard with
limitations.

The only requirement for the emulated-iec958 card would be a shifter
with deep enough
fifo, that can shift out bits at around 6Mbps (for 48KHz Stereo). And
most SoCs have
such a resource available that can be put to the use -- OMAP has
McBSP, Samsung's
and other SoCs can leverage a SPI controller.

Any suggestions welcome.

Regards,
Jassi

PS: I start the topic upon insistence from Angat
<yadi.brar01@gmail.com>, a grad student who
wanted to implement the feature for his univ project on his beagle board.
