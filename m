From: Stephen Warren <swarren@nvidia.com>
Subject: aplay can't run in background since adding pause
	support
Date: Mon, 23 May 2011 13:55:44 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A4808F@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id A0A942437E
	for <alsa-devel@alsa-project.org>;
	Mon, 23 May 2011 22:55:54 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "perex@perex.cz" <perex@perex.cz>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav,

In recent versions of aplay, if I try to either run them in the
background, or run them in the foreground, then ^Z and bg them, they
hang indefinitely:

aplay foo.wav &
# doesn't play anything

aplay foo.wav
...
^Z
bg
[1]+  Stopped      aplay foo.wav
bg
[1]+  Stopped      aplay foo.wav

At least, this is true under ChromeOS on ARM with kernel 2.6.38 and
ALSA 1.0.24.2, or an Ubuntu Natty rootstock on ARM with the same ChromeOS
kernel.

This was introduced by alsa-utils commit:
3bd65336222a4d00cefc4db5e74a7a96c07ab567
aplay/arecord: Added hardware pause support (press SPACE or Enter)

What happens is that the call to tcsetattr causes the process to receive
signal TTOU and be stopped. Running under strace yields an infinite loop
with ioctl(TCSETS) returning -ERESTARTSYS, and being retried.

I believe this is related to http://lkml.org/lkml/2008/6/2/157.

I'm not exactly sure how to solve this though. Another post in that
thread implied that adding a signal handler for TTOU and then adjusting
the tcsetattr settings might help, but I'm not convinced about that,
since I believe the -ERESTARTSYS handling loop is inside the call to
tcsetattr, and hence tcsetattr's parameters can't be changed.

Does anyone have any ideas? Thanks.

-- 
nvpublic
