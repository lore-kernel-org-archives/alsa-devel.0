From: Joshua N Pritikin <vishnu@pobox.com>
Subject: [SMP] unresolved symbol kernel_flag_cacheline
Date: Mon, 9 Jun 2003 17:34:17 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030609120416.GB917@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

i must be doing something really silly.  i compiled alsa 0.9.4
with linux 2.4.20 SMP + lowlatency.  When i try to load the
snd module, i get this:

remix:/usr/src/alsa-driver-0.9.4# modprobe snd
/lib/modules/2.4.20/kernel/sound/acore/snd.o: unresolved symbol kernel_flag_cacheline
/lib/modules/2.4.20/kernel/sound/acore/snd.o: insmod /lib/modules/2.4.20/kernel/sound/acore/snd.o failed
/lib/modules/2.4.20/kernel/sound/acore/snd.o: insmod snd failed

But my kernel looks OK:

remix:/usr/src/linux# grep SMP .config
CONFIG_SMP=y

remix:/usr/src/linux# nm vmlinux |grep kernel_flag_cache
c02ec8a0 R __kstrtab_kernel_flag_cacheline
c02f9530 R __ksymtab_kernel_flag_cacheline
c02fe2e0 D kernel_flag_cacheline

i don't have much experience tracking down this kind of link problem.
Where should i look?

-- 
Victory to the Divine Mother!!         after all,
  http://sahajayoga.org                  http://why-compete.org


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
