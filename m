From: Unet <burududu@hotpop.com>
Subject: Fwd: Problem wth alsa-driver (rc3-rc4) rc5
Date: Thu, 24 Oct 2002 19:34:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210241934.38927.burududu@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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

I have a problem having alsa-driver to work since rc3.

The driver compiles fine, but when I try to register the modules, here's =
what
I got:
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/acore/oss/snd-mixer-oss.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/acore/oss/snd-pcm-oss.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/acore/seq/oss/snd-seq-oss.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/acore/seq/snd-seq-device.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/acore/seq/snd-seq-instr.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/acore/seq/snd-seq-midi-emul.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/acore/seq/snd-seq-midi-event.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/acore/seq/snd-seq-midi.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/acore/seq/snd-seq.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/acore/snd-hwdep.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/acore/snd-pcm.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/acore/snd-rawmidi.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/acore/snd-timer.o
depmod: *** Unresolved symbols in
 /lib/modules/2.4.19/kernel/sound/acore/snd.o depmod: *** Unresolved symb=
ols
 in
/lib/modules/2.4.19/kernel/sound/drivers/mpu401/snd-mpu401-uart.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/drivers/opl3/snd-opl3-lib.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/drivers/opl3/snd-opl3-synth.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/pci/ac97/snd-ac97-codec.o
depmod: *** Unresolved symbols in
/lib/modules/2.4.19/kernel/sound/pci/ymfpci/snd-ymfpci.o


I'd *love* to know what is wrong.

I'm using 2.4.19 with preempt + low-latency patches.

Thank you :)

--
-------------------------------------------------
=09        Unet !=3D UUnet

>SourceMage

=09Grimoire Guru for Audio<
void Unet_im(gabber unet@bravegnuworld.com);
void Unet_dm(mail burududu@hotpop.com)
=09{
=09=09subject(to change);
=09};
--------------------------------------------------



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0003en
