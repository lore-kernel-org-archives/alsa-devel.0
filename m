From: Cyrus Vafadari <cyrusv@mit.edu>
Subject: CONFIG_SND_DYNAMIC_MINORS
Date: Thu, 1 Dec 2011 13:21:51 -0500
Message-ID: <CAMd+_QD-ToD2yf9KnMkchmdMzwQa=2c2MpaKhcz-cMQqVaBocA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A0FE0103BE3
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2011 19:21:53 +0100 (CET)
Received: by ghbg15 with SMTP id g15so2360130ghb.38
	for <alsa-devel@alsa-project.org>; Thu, 01 Dec 2011 10:21:51 -0800 (PST)
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

How can I check if CONFIG_SND_DYNAMIC_MINORS is enabled, and enable it if
it is not already?

I've been having a lot of trouble assigning 10 USB soundcards, and it's
been doing fishy things when I change who's plugged in to which usb hub.
ALSA recognizes all the cards, but some of the hw:x,y plays through the
default hw:0,0. Also PulseAudio fails to recognize those same cards as
"sinks" and only recognizes their microphone capabilities.

Cheers
Cyrus
