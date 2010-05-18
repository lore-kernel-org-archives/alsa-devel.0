From: Adish Kuvelker <adkuvi@gmail.com>
Subject: Creating a /dev entry.
Date: Tue, 18 May 2010 18:51:31 +0530
Message-ID: <AANLkTiljJRpLd4koKAuELpbJc8GgiDj4_9kHlnX3eScu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B793A103874
	for <alsa-devel@alsa-project.org>;
	Tue, 18 May 2010 15:21:36 +0200 (CEST)
Received: by vws14 with SMTP id 14so4098826vws.38
	for <alsa-devel@alsa-project.org>; Tue, 18 May 2010 06:21:34 -0700 (PDT)
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

Hello,

I am writing a ALSA driver for the AtlasIII AC'97 Controller. The
controller communicates with the AC'97 Codec and the necessary PCM,
Sequencer, Control and Timer nodes are created in the /sys. Also I get
the necessary information registered in the procfs under /proc/asound.
However, I do not see any sound nodes created under /dev. Are these
nodes created by the sound driver registration function which creates
necessary files under /sys or will I have to use utilities like
"snddevices" to create the "snd" node under /dev. I read that
"snddevices" would create the necessary entries under /dev/snd, and I
reckon that it does not create the entry "snd" under /dev.
Although I am using kernel 2.6.19.2, it doesn't have the "udev"
enabled. Will I need the "udev" to create these nodes under /dev?

Regards;
Aadish
