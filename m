From: Mark Knecht <markknecht@attbi.com>
Subject: HDSP 9652 - a couple of small (?) issues
Date: 10 Dec 2002 20:42:32 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1039581753.1681.7.camel@Godzilla>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
Cc: PlanetCCRMA <planetccrma@ccrma.stanford.edu>
List-Id: alsa-devel@alsa-project.org

Hi,
   I'm finding that I seem to have two problems with this new card:

1) I am unable to turn down the volume with alsamixer. All the way up or
down, the volume is always very loud. Has anyone else seen this? Is
there some other tool which will actually control the volume?

2) If I use alsamixer and set volume bars and then use 'alsactl store'
to store the levels, if I use 'alsactl restore' the restore process
always sets channel 0 back to 0. Other channels are restored at their
saved levels. Is alsactl the right tool to use to accomplish this?

   I'm not at all clear who to report this to. Who works on alsactl and
alsamixer?

Thanks,
Mark





-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
