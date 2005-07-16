From: Lee Revell <rlrevell@joe-job.com>
Subject: CVS compile issue
Date: Fri, 15 Jul 2005 22:49:26 -0400
Message-ID: <1121482166.12420.80.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Kernel is 2.6.12-RT-V0.7.51-28.

  CC [M]  /smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/ac97_codec.o
In file included from /smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/ac97_codec.c:1:
/smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/../../alsa-kernel/pci/ac97/ac97_codec.c: In function 'snd_ac97_resume':
/smb/rlrevell/cvs/alsa/alsa-driver/include/adriver.h:644: sorry, unimplemented: inlining failed in call to 'msecs_to_jiffies': function body not available
/smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/../../alsa-kernel/pci/ac97/ac97_codec.c:2252: sorry, unimplemented: called from here
/smb/rlrevell/cvs/alsa/alsa-driver/include/adriver.h:644: sorry, unimplemented: inlining failed in call to 'msecs_to_jiffies': function body not available
/smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/../../alsa-kernel/pci/ac97/ac97_codec.c:2264: sorry, unimplemented: called from here
make[4]: *** [/smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/ac97_codec.o] Error 1
make[3]: *** [/smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97] Error 2
make[2]: *** [/smb/rlrevell/cvs/alsa/alsa-driver/pci] Error 2
make[1]: *** [_module_/smb/rlrevell/cvs/alsa/alsa-driver] Error 2
make[1]: Leaving directory `/smb/rlrevell/kernel-source/linux-2.6.12-c3'
make: *** [compile] Error 2

Lee



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
