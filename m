From: Josh Huber <huber+keyword+alsa.9c0e1c@alum.wpi.edu>
Subject: snd-usb-midi fails to load w/current CVS
Date: Fri, 20 Sep 2002 00:21:11 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87admdi954.fsf@mail.paradoxical.net>
Reply-To: Josh Huber <huber+dated+1032926673.3f2d8b@alum.wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I've got a USB midi device (MidiSport 2x2), but the snd-usb-midi
driver from current CVS does not load for me:

mystic:/home/huber# modprobe snd-usb-midi
/lib/modules/2.4.19/kernel/sound/acore/seq/snd-seq-virmidi.o:
unresolved symbol snd_rawmidi_set_ops_Rc01247d9
/lib/modules/2.4.19/kernel/sound/acore/seq/snd-seq-virmidi.o:
unresolved symbol snd_rawmidi_transmit_peek_R9d1a0acb
/lib/modules/2.4.19/kernel/sound/acore/seq/snd-seq-virmidi.o:
unresolved symbol snd_rawmidi_new_R14f74041
/lib/modules/2.4.19/kernel/sound/acore/seq/snd-seq-virmidi.o:
unresolved symbol snd_rawmidi_transmit_ack_Ra57c2838
/lib/modules/2.4.19/kernel/sound/acore/seq/snd-seq-virmidi.o:
unresolved symbol snd_rawmidi_receive_R8e703b33
/lib/modules/2.4.19/kernel/sound/acore/seq/snd-seq-virmidi.o: insmod
/lib/modules/2.4.19/kernel/sound/acore/seq/snd-seq-virmidi.o failed
/lib/modules/2.4.19/kernel/sound/acore/seq/snd-seq-virmidi.o: insmod
snd-usb-midi failed
mystic:/home/huber# 

Ah, it's because the "usb-rawmidi" module does not get installed with
a make install.

I was originally using ./configure --with-cards=powermac,usb-audio,
which built all the modules required for usb-midi, including
snd-rawmidi.  To get the rawmidi module to install, I had to specify
support for virmidi as well.

Just FYI.

-- 
Josh Huber




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
