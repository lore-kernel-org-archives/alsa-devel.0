From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Have multiple opens removed on one device?
Date: Mon, 22 Aug 2011 18:13:03 +0800
Message-ID: <CAHG8p1BRN365PTyDxh-6UFWKtf_M-WcVZDGmuXB0W+CjTgPNGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1330B24502
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 12:13:04 +0200 (CEST)
Received: by qwf7 with SMTP id 7so2934707qwf.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2011 03:13:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark and Takashi,

In kernel 2.6.34 I can use aplay to play audio at the same time, alsa
will mix the audio. Now the second open will return device busy.
So it seems this feature has been removed. What's the proper approach
for this operation at present?

Thanks.

Scott
