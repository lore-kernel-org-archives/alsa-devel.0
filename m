From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: cvs not compiling cleanly
Date: Fri, 31 May 2002 12:27:26 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CF6ED9E.D49C9B5F@boosthardware.com>
References: <Pine.LNX.4.21.0205301633140.699-100000@summer.quitte> <200205302319.QAA14997@cmn29.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com ([66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id FAA26580
	for <alsa-devel@alsa-project.org>; Fri, 31 May 2002 05:23:23 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fernando Pablo Lopez-Lezcano wrote:
> 
> Hi, today's cvs, fresh download. Not all modules are compiled
> when doing a cvscompile from scratch. Last ones are the usb
> modules, the whole pci directory is apparently skipped. The
> final depmod also fails (maybe because there are modules
> missing?):
> 
> /sbin/depmod -a -e -b /var/tmp/alsa-driver-root/  2.4.18-8.llsmp
> depmod: *** Unresolved symbols in
> /var/tmp/alsa-driver-root//lib/modules/2.4.18-8.llsmp/kernel/drivers/sound/acore/seq/snd-seq-midi.o
> depmod:         snd_midi_event_reset_decode_Rsmp_89a9caf3
> depmod:         snd_midi_event_new_Rsmp_d1f14cea
> depmod:         snd_midi_event_free_Rsmp_0d42135c
> depmod:         snd_midi_event_decode_Rsmp_b1332d2d
> depmod:         snd_midi_event_encode_Rsmp_06daaf77
> depmod: *** Unresolved symbols in
> /var/tmp/alsa-driver-root//lib/modules/2.4.18-8.llsmp/kernel/drivers/sound/acore/seq/snd-seq-virmidi.o
> depmod:         snd_midi_event_new_Rsmp_d1f14cea
> depmod:         snd_midi_event_reset_encode_Rsmp_06e732f9
> depmod:         snd_midi_event_free_Rsmp_0d42135c
> depmod:         snd_midi_event_decode_Rsmp_b1332d2d
> depmod:         snd_midi_event_encode_Rsmp_06daaf77
> 
> CVS from 2002-05-15.10:15:43 compiles fine on the same machine.
> -- Fernando
> 

I get a similar problem with the sequencer support for the cmipci. It
has been like that since Monday AFAICR.


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
=======================================================================

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
