From: Mark Knecht <markknecht@attbi.com>
Subject: alsaconf -L - where's Waldo?
Date: 21 Mar 2003 05:50:47 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048254648.3400.24.camel@Wizard>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
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
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
   The --help option says that I can get a log file from alsaconf using
the -L option. If I look in /tmp while alsaconf is running, I see some
files, but when alsaconf has finished, the files are gone...


[mark@Wizard mark]$ ls /tmp
alsaconf.3nMgvm  alsaconf.txNTFm  ksocket-mark  orbit-mark  =20
ssh-XX7Jn9me
alsaconf.Ef6KCm  kde-mark         mcop-mark     ssh-XX1CS1IB=20
ssh-XXIbrHpS
[mark@Wizard mark]$ ls /tmp
kde-mark  ksocket-mark  mcop-mark  orbit-mark  ssh-XX1CS1IB=20
ssh-XX7Jn9me  ssh-XXIbrHpS
[mark@Wizard mark]$

Is this file possibly put somewhere else? I'm trying to figure out why
alsaconf is complaining about this card.

Loading driver..
Starting sound driver snd-hdsp
/lib/modules/2.4.20-1.12.ll.acpi/kernel/drivers/sound/pci/rme9652/snd-hdsp.=
o: Hint: insmod errors can be caused by incorrect module parameters, includ=
ing invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
init_module: No such device
/lib/modules/2.4.20-1.12.ll.acpi/kernel/drivers/sound/pci/rme9652/snd-hdsp.=
o: insmod /lib/modules/2.4.20-1.12.ll.acpi/kernel/drivers/sound/pci/rme9652=
/snd-hdsp.o failed
/lib/modules/2.4.20-1.12.ll.acpi/kernel/drivers/sound/pci/rme9652/snd-hdsp.=
o: insmod snd-hdsp failed
                                                           [FAILED]
Setting default volumes..
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

 Now ALSA is ready to use.
 For adjustment of volumes, please use alsamixer or gamix.

 Have a lot of fun!                                   =81
[root@Wizard etc]# =81




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
