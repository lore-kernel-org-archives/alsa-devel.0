From: Supphachoke Suntiwichaya <mrchoke@opentle.org>
Subject: au88xo spin_lock and spin_unlock error
Date: Mon, 13 Oct 2003 10:30:13 +0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8A1C45.6040403@opentle.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=TIS-620; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
    I can't  compile ALSA-DRIVER 0.9.7b .

====
In file included from au8810_core.c:2:
au88x0_core.c: In function `vortex_adb_allocroute':
au88x0_core.c:1780: incompatible type for argument 1 of `_raw_spin_lock'
au88x0_core.c:1887: incompatible type for argument 1 of `_raw_spin_unlock'
make[2]: *** [au8810_core.o] Error 1
make[1]: *** [_modsubdir_au88x0] Error 2

====
I used kernel 2.4.22
http://www-ccrma.stanford.edu/planetccrma/software/system.html#kernel

MrChoke
-- 

Name : Supphachoke Suntiwichaya
Email : MrChoke@opentle.org
URL : http://jedi.links.nectec.or.th/mrchoke/
Distribution : Linux TLE 5.0 (Andaman)
OS : Linux 2.4.23-pre4-tv #2 อา. ก.ย. 14 16:58:21 ICT 2003 i686 GNU/Linux
Uptime :  10:25:00  up 6 days, 18:39,  1 user,  load average: 0.13, 0.15, 0.16




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
