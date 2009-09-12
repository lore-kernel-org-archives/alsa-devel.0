From: Ben <donneh@gmail.com>
Subject: SPDIF issues
Date: Sat, 12 Sep 2009 15:03:46 +0100
Message-ID: <dbecb5df0909120703ydede4c8ta85418b6ea27f130@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id DF57C103818
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Sep 2009 16:03:47 +0200 (CEST)
Received: by fxm3 with SMTP id 3so1333847fxm.32
	for <alsa-devel@alsa-project.org>; Sat, 12 Sep 2009 07:03:46 -0700 (PDT)
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

All,

I have been happily using a small setup for the purpose of MythTV. I
recently decided to upgrade the graphics so I could enjoy VPDAU which has
been integrated into the 0.22 branch of MythTV. There is just one snag, I
don't have any sound.

I am using an Asus P5E-VM HDMI board, it has onboard sound & graphics. The
HDMI interface outputs to my TV and it works fine.

I then came across an nvidia 9500GT (gainwood) card which has a VGA/DVI/HDMI
out and also takes in sound via SPDIF. I connected the cable to my spdif
headers and I can't seem to get any sound. I'm running Ubuntu Karmic so I
thought I would upgrade the Alsa drivers/lib/utils to the latest, this has
not helped matters. I have checked Alsa mixer and nothing is muted.

I have tried: speaker-test -Dplughw:0,1 - (I think this is correct). I'm
sure it's something pretty trivial I could be doing wrong but someone
mentioned this kind of setup can be quite problematic and suggested I posted
the details to this list.

Details here:
http://www.alsa-project.org/db/?f=ffb9e4b76f37a87f21fec2a4db18295479608d24

I'd appreciate your thoughts!

Thanks,
Ben
