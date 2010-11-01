From: pl bossart <bossart.nospam@gmail.com>
Subject: iec958 and 24-bit audio
Date: Mon, 1 Nov 2010 14:14:41 -0500
Message-ID: <AANLkTi=U5k+mYy-kSCn4699LwFF6J2gxYQKePSNayDth@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B1FED2437F
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 20:14:48 +0100 (CET)
Received: by gxk28 with SMTP id 28so2592147gxk.38
	for <alsa-devel@alsa-project.org>; Mon, 01 Nov 2010 12:14:48 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

When I try playing 24-bit audio files on my SPDIF output, I get this

[alsa-lib]$ aplay -Diec958 file24bits.wav
aplay: set_params:1059: Sample format non available
Available formats:
- S16_LE
- S32_LE

Is there an built-in assumption that the iec958 device can only take
as input what the slave hardware device supports? The IEC subframes
can convey 24 bit audio, and it's possible to insert the 24 bits
starting from bit 4 when adding the preambles and status bits. What am
I missing?
Thanks,
-Poerre
