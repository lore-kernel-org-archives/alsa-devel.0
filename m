From: Florian Schmidt <mista.tapas@gmx.net>
Subject: dmix is equivalent to /dev/null on my system [cs46xx]
Date: Fri, 11 Jun 2004 17:46:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040611174611.1b33b034@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 62110285
	for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2004 17:41:17 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi,

a while back i reporte this problem before. On my system [debian unstable, kernel 2.6.6] the dmix plugin behaves like a black hole. Means: no sound coming out of my speakers at all..

aplay -D plug:dmix file.wav  

-> silence

aplay -D plughw:0,0 file.wav

-> sound

dsnoop on the other hand doesn't work as expected either: When i start a recording with

arecord -D plughw:0,0 -f cd file.wav

-> records nicely

arecord -D plug:dsnoop -f cd file.wav

-> noise - seems to be the first captured buffer repeated endlessly..

Other pcm stuff like the ladspa pcm plugin work flawlessly..

Florian Schmidt

-- 
Palimm Palimm!



-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
