From: Paul Davis <paul@linuxaudiosystems.com>
Subject: access to GPLONLY symbol SNAFU?
Date: Tue, 4 Mar 2003 09:55:52 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303041455.h24EtqT17634@linuxaudiosystems.com>
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

i've been rebuilding kernels and drivers and stuff like that. after a
complete new checkout of ALSA, a complete rebuild of 2.4.19 and of
alsa-driver, then installing ALSA, i get this:

% sudo depmod -ae
depmod: *** Unresolved symbols in /lib/modules/2.4.19-pre6/kernel/sound/acore/snd-pcm.o
depmod:         vmalloc_to_page

% grep GPLONLY /proc/ksyms
c012c980 GPLONLY_vmalloc_to_page

now, i know something the EXPORT_SYMBOL_GPLONLY, but i don't
understand why this is happening.

linux 2.4.19 + ll
ALSA CVS
gcc 3.2.2
module-init-tools 0.9.10

can anyone help me out?


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
