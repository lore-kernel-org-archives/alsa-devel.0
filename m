From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: cvs not compiling cleanly
Date: Thu, 30 May 2002 16:19:22 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205302319.QAA14997@cmn29.stanford.edu>
References: <Pine.LNX.4.21.0205301633140.699-100000@summer.quitte>
Mime-Version: 1.0 (NeXT Mail 3.3 v148.2.1)
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA24276
	for <alsa-devel@alsa-project.org>; Fri, 31 May 2002 01:19:57 +0200
In-Reply-To: <Pine.LNX.4.21.0205301633140.699-100000@summer.quitte>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: nando@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

Hi, today's cvs, fresh download. Not all modules are compiled
when doing a cvscompile from scratch. Last ones are the usb
modules, the whole pci directory is apparently skipped. The
final depmod also fails (maybe because there are modules
missing?):

/sbin/depmod -a -e -b /var/tmp/alsa-driver-root/  2.4.18-8.llsmp
depmod: *** Unresolved symbols in  
/var/tmp/alsa-driver-root//lib/modules/2.4.18-8.llsmp/kernel/drivers/sound/acore/seq/snd-seq-midi.o
depmod: 	snd_midi_event_reset_decode_Rsmp_89a9caf3
depmod: 	snd_midi_event_new_Rsmp_d1f14cea
depmod: 	snd_midi_event_free_Rsmp_0d42135c
depmod: 	snd_midi_event_decode_Rsmp_b1332d2d
depmod: 	snd_midi_event_encode_Rsmp_06daaf77
depmod: *** Unresolved symbols in  
/var/tmp/alsa-driver-root//lib/modules/2.4.18-8.llsmp/kernel/drivers/sound/acore/seq/snd-seq-virmidi.o
depmod: 	snd_midi_event_new_Rsmp_d1f14cea
depmod: 	snd_midi_event_reset_encode_Rsmp_06e732f9
depmod: 	snd_midi_event_free_Rsmp_0d42135c
depmod: 	snd_midi_event_decode_Rsmp_b1332d2d
depmod: 	snd_midi_event_encode_Rsmp_06daaf77

CVS from 2002-05-15.10:15:43 compiles fine on the same machine.
-- Fernando

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
