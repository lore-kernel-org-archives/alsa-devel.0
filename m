From: =?iso-8859-15?q?Z=E9bulon?= <zeb@zebulon.org.uk>
Subject: Terratec Aureon Space
Date: Thu, 15 May 2003 18:26:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305151826.55345.zeb@zebulon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Are there any debvelopers working on the Terratec Aureon Space ?

The sound chip is a Envy24HT, like for the Revolution, and there is a Wolfson 
chip WM8770IFT.
I cannot make it work with the 9.3a driver snd-ice1724, I get that error :

#modprobe snd-ice1724

Warning: loading 
/lib/modules/2.4.21-0.19mm-mdk/kernel/sound/i2c/other/snd-ak4xxx-adda.o will 
taint the kernel: no license
  See http://www.tux.org/lkml/#export-tainted for information about tainted 
modules
Module snd-ak4xxx-adda loaded, with warnings
/lib/modules/2.4.21-0.19mm-mdk/kernel/sound/pci/ice1712/snd-ice1724.o: 
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including 
invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
modprobe: insmod 
/lib/modules/2.4.21-0.19mm-mdk/kernel/sound/pci/ice1712/snd-ice1724.o failed
modprobe: insmod snd-ice1724 failed



Can I expect to see it supported in the future ?

Thanks a lot
Zeb


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
