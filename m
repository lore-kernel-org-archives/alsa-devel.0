From: "Ted T. Logan" <tedtheologian@gmail.com>
Subject: ctxfi/pulse audio problems and skype - only hear
 digital noise after a while in call
Date: Sat, 14 Feb 2009 19:34:57 -0600
Message-ID: <1234661697.22246.8.camel@home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f20.google.com (mail-qy0-f20.google.com
	[209.85.221.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EE601037F5
	for <alsa-devel@alsa-project.org>; Sun, 15 Feb 2009 02:35:00 +0100 (CET)
Received: by qyk13 with SMTP id 13so2701202qyk.8
	for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2009 17:34:59 -0800 (PST)
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

 Help,

I have x-fi live, using ctxfi driver.  I had to start using pulse audio
because after a recent alsa upgrade, no matter what I did, my creative
x-fi would no longer show as default sound card, but was way down the
list, no matter what I did.

Anyway, my current problem is I use skype all the time, but after I am
in a phone call for a while, when the other person talks, I just hear
digital noise/garbage whenever they talk, so I have to hang up.  It is
causing me a lot of grief because I use skype for business.

I am not telling skype to use pulseaudio even though the rest of my apps
are, because it doesn't seem to work well with skype, so I just have it
use alsa/ctxfi.

I don't know what to do, I didn't have this problem a few months ago,
and I'm not sure if it's:

1.Since I upgraded from f9 to f10
2.Since I started using pulseaudio
3.Since I switched from sbxfi driver to ctxfi

My current system is f10
rpmq alsa
alsa-oss-1.0.17-1.fc10.i386
alsa-oss-libs-1.0.17-1.fc10.i386
alsa-utils-1.0.19-1.fc10.i386
alsa-plugins-pulseaudio-1.0.18-2.fc10.i386
alsa-lib-1.0.19-2.fc10.i386
alsa-lib-devel-1.0.19-2.fc10.i386
alsa-tools-1.0.17-1.fc10.i386
bluez-alsa-4.22-2.fc10.i386
alsa-plugins-oss-1.0.18-2.fc10.i386



Thanks in advance!
