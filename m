From: VDR User <user.vdr@gmail.com>
Subject: Is this a bug in alsa? (mute + hdmi audio related)
Date: Mon, 5 Apr 2010 23:37:27 -0700
Message-ID: <n2oa3ef07921004052337tf2d85812l1efafc996199db62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8618024420
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Apr 2010 08:37:31 +0200 (CEST)
Received: by vws12 with SMTP id 12so2037163vws.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Apr 2010 23:37:27 -0700 (PDT)
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

I've got an htpc using the following:

Debian linux (testing)
kernel 2.6.33.2 (stable)
VDR-1.7.14 with the vdr-xine-0.9.3 output plugin
Nvidia GT220 video card
xine-lib-1.2 w/vdpau
alsa-driver-20100307.tar.gz w/Wei's reworked nvhdmi code

I'm using an HDMI cable going from the video card to my tv, and audio
is going over the cable as well.  When I press mute in VDR, I see the
mute icon appear but the audio is not muted.  I'm not sure if this is
a xine problem or alsa but I'm guessing alsa since my previous setup
was all the same except I was using a different Nvidia video card, but
still with vdpau, and audio/video going from DVI-OUT on the card, to a
DVI->HDMI cable into my tv.  Could the problem be within the alsa
driver somewhere or am I barking up the wrong tree?

Thanks for any help.
