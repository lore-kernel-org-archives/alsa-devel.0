From: federico <xaero@inwind.it>
Subject: the big jack bug... > crappy audio on XRUNS
Date: Sun, 06 Nov 2005 16:48:43 +0100
Message-ID: <436E25DB.2070804@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-admin@lists.sourceforge.net>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

it happens randomly, while I play a soft synth, that jack XRUNs once, 
and the audio become crappy, noisy, like a kinda of digital 
effect....bit crusher?

then all synthesizers (all audio apps) sound the same sh*t...
i tried recording with ardour the output, and the output is clean, so I 
guess is a problem of sync or something that has to do with the hardware 
(soundcard).

in order to record this noise, i had to connect the soundcard output in 
its input and record it via analog in: 
http://xaero.ath.cx/jackbug_stereo.wav.bz2 (it is a stereo file, with 
the clean track panned on the left, and the dirty one on the right).

i hope it could be useful to debug the problem...
what other information I can provide useful for debug?
note that this happens with many version of alsa (1.0.9b, 1.0.10rc2, 
1.0.7 or less) and with many kernels (gentoo-sources (slightly patched 
for speed improvement), ck-sources, ck-sources+realtime-lsm)

i hope to solve this problem, since my audio desktop is unusable as si, 
since audio crasher after playng for just 5 minutes :(


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
