From: Ismael Valladolid Torres <ismael@sambara.org>
Subject: Measuring latency on my Apple G3
Date: Mon, 21 Jul 2003 11:58:04 +0200
Message-ID: <3F1BB92C.6090600@sambara.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-powerpc=debian-powerpc=m.gmane.org@lists.debian.org>
Resent-Message-ID: <G0eA_C.A.bb.tl7G_@murphy>
List-Post: <mailto:debian-powerpc@lists.debian.org>
List-Help: <mailto:debian-powerpc-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-powerpc-request@lists.debian.org?subject=unsubscribe>
List-Archive: <http://lists.debian.org/debian-powerpc/>
To: linux-audio-dev@music.columbia.edu, linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net, debian-powerpc@lists.debian.org
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying latencytest-0.42-png.tar.gz for measuring latency on my 
Apple G3 (Debian/Sid PowerPC). Of course I am enabling USE_GENERIC_TIMER 
and tuning my hard disk using hdparam before tests. But, results show a 
very poor performance. Indeed, any X11 stressing involves a raise of the 
latency and lots of dropouts.

I can't blame hardware. Apple hardware is top-class, and this same 
machine features under 1,5 ms of latency using CoreAudio on Mac OS X. 
So, whether the PowerPC kernel or X11 are not fully optimized, or the 
latencytest application is not reliable on non-Intel platforms.

Any ideas?

Sorry for crossposting... ;)

Regards, Ismael
