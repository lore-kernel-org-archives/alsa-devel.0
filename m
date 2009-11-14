From: Reiner <reiner1210@googlemail.com>
Subject: no sound when using TV-Out
Date: Sat, 14 Nov 2009 11:06:31 +0100
Message-ID: <4AFE8127.9070506@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 12977243FE
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2009 11:06:41 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 19so1538793fgg.2
	for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2009 02:06:39 -0800 (PST)
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

I have something strange:
I have had Suse 11.1 (64 bit) and everything was ok.
Now I have Suse 11.2 (64 bit) and xine, MPlayer are playing fine (with
audio) if using the already running x-Server. For using the TV-OUT I
have a seperate section in xorg.conf and I start a new X server with
this conf, chnage the DISPLAY variable and launch xine, Mplayer. This
has worked! Now I get a picture but no sound with BOTH players (xine,
mplayer).So I think it has to do with some access rights to the sound
device.

PS: Pulse audio is not installed (with it flash has no sound)

Any ideas ?

Thanks
Reiner
