From: Fred Jan Kraan <fjkraan@xs4all.nl>
Subject: VxPocket module beta doesn't load
Date: Fri, 8 Nov 2002 13:33:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021108133336.R29821@xs4all.nl>
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

The cvs-alsa tree compiled ok, but the module will not load. This could be an
operator error, as the compiling machine isn't the test machine (portable).
So I could have forgotten to copy some files.


#boot.msg:
 <notice>/etc/init.d/rc5.d/S12alsasound start
 Starting sound driver:  opl3sa2 vxpocket/lib/modules/2.4.18-4GB/pcmcia/snd-vxp-lib.o: unresolved symbol snd_verbose_printd

 /lib/modules/2.4.18-4GB/pcmcia/snd-vxp-lib.o: unresolved symbol snd_wrapper_vfree

 /lib/modules/2.4.18-4GB/pcmcia/snd-vxp-lib.o: unresolved symbol snd_wrapper_vmalloc

 /lib/modules/2.4.18-4GB/pcmcia/snd-vxp-lib.o: insmod /lib/modules/2.4.18-4GB/pcmcia/snd-vxp-lib.o failed

 /lib/modules/2.4.18-4GB/pcmcia/snd-vxp-lib.o: insmod snd-vxpocket failed


 failed

 Restoring the previous sound setting
 done


#messages:
 Nov  8 12:14:13 portable cardmgr[2332]: socket 1: Digigram VX-POCKET
 Nov  8 12:14:14 portable cardmgr[2332]: executing: 'insmod -v /lib/modules/2.4.18-4GB//pcmcia/snd-vxpocket.o'
 Nov  8 12:14:14 portable cardmgr[2332]: + /lib/modules/2.4.18-4GB//pcmcia/snd-vxpocket.o: unresolved symbol snd_vxpocket_free_chip
 Nov  8 12:14:14 portable cardmgr[2332]: + /lib/modules/2.4.18-4GB//pcmcia/snd-vxpocket.o: unresolved symbol snd_vx_irq_handler
 Nov  8 12:14:14 portable cardmgr[2332]: + /lib/modules/2.4.18-4GB//pcmcia/snd-vxpocket.o: unresolved symbol snd_vxpocket_assign_resources
 Nov  8 12:14:14 portable cardmgr[2332]: + /lib/modules/2.4.18-4GB//pcmcia/snd-vxpocket.o: unresolved symbol snd_vxpocket_card_busy
 Nov  8 12:14:14 portable cardmgr[2332]: + /lib/modules/2.4.18-4GB//pcmcia/snd-vxpocket.o: unresolved symbol snd_vxpocket_create_chip
 Nov  8 12:14:14 portable cardmgr[2332]: + Using /lib/modules/2.4.18-4GB//pcmcia/snd-vxpocket.o
 Nov  8 12:14:14 portable cardmgr[2332]: + Symbol version prefix ''
 Nov  8 12:14:14 portable cardmgr[2332]: insmod exited with status 1
 Nov  8 12:14:14 portable cardmgr[2332]: executing: 'modprobe -v snd-vxpocket'
 Nov  8 12:14:14 portable cardmgr[2332]: + modprobe: Can't locate module snd-vxpocket
 Nov  8 12:14:14 portable cardmgr[2332]: modprobe exited with status 255
 Nov  8 12:14:15 portable cardmgr[2332]: get dev info on socket 1 failed: Resource temporarily unavailable


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
