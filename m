From: Mark Knecht <markknecht@comcast.net>
Subject: Why does Alsa sometimes not find the HDSP 9652?
Date: Sat, 20 Dec 2003 08:21:45 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1071937305.5565.1.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Wizard root # /etc/init.d/alsasound start
 * Loading ALSA drivers...
 * Loading: snd-seq-oss
 * Loading: snd-pcm-oss
 * Loading: snd-mixer-oss
 * Loading: snd-via82xx
 * Loading: snd-hdsp
/lib/modules/2.4.20-gentoo-r9/kernel/sound/pci/rme9652/snd-hdsp.o:
init_module: 
No such device
Hint: insmod errors can be caused by incorrect module parameters,
including inva
lid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.20-gentoo-r9/kernel/sound/pci/rme9652/snd-hdsp.o:
insmod /lib/m
odules/2.4.20-gentoo-r9/kernel/sound/pci/rme9652/snd-hdsp.o failed
/lib/modules/2.4.20-gentoo-r9/kernel/sound/pci/rme9652/snd-hdsp.o:
insmod snd-hd
sp failed
 * Loading: snd-usb-audio
 * Loading: snd-seq-oss
 * Running card-dependent scripts
 * Restoring Mixer
Levels                                                 [ ok ]
Wizard root # lspci
<SNIP>
00:0e.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall
DSP (rev 65)
<SNIP>
Wizard root # 



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
