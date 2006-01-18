From: Lee Revell <rlrevell@joe-job.com>
Subject: mutex problems
Date: Tue, 17 Jan 2006 22:11:05 -0500
Message-ID: <1137553866.3587.51.camel@mindpipe>
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

Since the mutex patches were merged to CVS I can't build against 2.6.15:

make -C /home/rlrevell/kernel-source/linux-2.6.15-rc5-rt2
SUBDIRS=/smb/rlrevell/cvs/alsa/alsa-driver  modules
make[1]: Entering directory
`/smb/rlrevell/kernel-source/linux-2.6.15-rc5-rt2'
  CC [M]  /smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.o
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:28:25: error:
linux/mutex.h: No such file or directory
In file included
from /smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:32:
/smb/rlrevell/cvs/alsa/alsa-driver/include/sound/hwdep.h:63: error:
field 'open_mutex' has incomplete type
In file included
from /smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:33:
/smb/rlrevell/cvs/alsa/alsa-driver/include/sound/info.h:87: error: field
'access' has incomplete type
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:40: warning: type
defaults to 'int' in declaration of 'DEFINE_MUTEX'
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:40: warning: parameter
names (without types) in function declaration
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c: In function
'snd_hwdep_open':
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:115: warning: implicit
declaration of function 'mutex_lock'
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:132: warning: implicit
declaration of function 'mutex_unlock'
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c: In function
'snd_hwdep_control_ioctl':
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:276: error:
'register_mutex' undeclared (first use in this function)
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:276: error: (Each
undeclared identifier is reported only once
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:276: error: for each
function it appears in.)
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c: In function
'snd_hwdep_new':
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:398: warning: implicit
declaration of function 'mutex_init'
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c: In function
'snd_hwdep_dev_register':
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:424: error:
'register_mutex' undeclared (first use in this function)
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c: In function
'snd_hwdep_dev_unregister':
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:466: error:
'register_mutex' undeclared (first use in this function)
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c: In function
'snd_hwdep_proc_read':
/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.c:492: error:
'register_mutex' undeclared (first use in this function)
make[3]: *** [/smb/rlrevell/cvs/alsa/alsa-driver/acore/hwdep.o] Error 1
make[2]: *** [/smb/rlrevell/cvs/alsa/alsa-driver/acore] Error 2
make[1]: *** [_module_/smb/rlrevell/cvs/alsa/alsa-driver] Error 2
make[1]: Leaving directory
`/smb/rlrevell/kernel-source/linux-2.6.15-rc5-rt2'
make: *** [compile] Error 2

Shouldn't the patch handle this?

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
