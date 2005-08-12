From: Lee Revell <rlrevell@joe-job.com>
Subject: CVS build error with kernel 2.6.13-rc4
Date: Fri, 12 Aug 2005 17:48:22 -0400
Message-ID: <1123883302.12680.60.camel@mindpipe>
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

  CC [M]  /smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/ac97_codec.o
/smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/ac97_codec.c: In function 'snd_ac97_resume':
/smb/rlrevell/cvs/alsa/alsa-driver/include/adriver.h:653: sorry, unimplemented: inlining failed in call to 'msecs_to_jiffies': function body not available
/smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/ac97_codec.c:2300: sorry, unimplemented: called from here
/smb/rlrevell/cvs/alsa/alsa-driver/include/adriver.h:653: sorry, unimplemented: inlining failed in call to 'msecs_to_jiffies': function body not available
/smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/ac97_codec.c:2312: sorry, unimplemented: called from here
make[4]: *** [/smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97/ac97_codec.o] Error 1
make[3]: *** [/smb/rlrevell/cvs/alsa/alsa-driver/pci/ac97] Error 2
make[2]: *** [/smb/rlrevell/cvs/alsa/alsa-driver/pci] Error 2
make[1]: *** [_module_/smb/rlrevell/cvs/alsa/alsa-driver] Error 2
make[1]: Leaving directory `/smb/rlrevell/kernel-source/linux-2.6.13-rc4'
make: *** [compile] Error 2

Is this a gcc (4.0.2) bug or a kernel issue?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
