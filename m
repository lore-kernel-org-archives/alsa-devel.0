From: linuxcbon <linuxcbon@yahoo.fr>
Subject: dont know if bug in /tmp/217usbkeyboardbug.log
Date: Sun, 7 Oct 2007 22:32:17 +0200 (CEST)
Message-ID: <833694.23104.qm@web26108.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web26108.mail.ukl.yahoo.com (web26108.mail.ukl.yahoo.com
	[217.146.182.149])
	by alsa0.perex.cz (Postfix) with SMTP id CA79B243AA
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Oct 2007 22:32:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi,

I have no idea if this is a bug : tv card is hauppauge wintv model 44346,
tuner model is Philips FI1216MF MK2 

I found in /tmp/217usbkeyboardbug.log

Last 20 lines of dmesg:
tveeprom 2-0050: has radio
bttv0: Hauppauge eeprom indicates model#44346
bttv0: using tuner=3
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp3400 2-0040: MSP3415G-B8 found @ 0x80 (bt878 #0 [sw])
msp3400 2-0040: MSP3415G-B8 supports nicam and radio, mode is autodetect
and autoselect
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner 2-0061: chip found @ 0xc2 (bt878 #0 [sw])
tuner 2-0061: type set to 3 (Philips (SECAM+PAL_BG) (FI1216MF, FM1216MF,
FR1216MF))
tuner 2-0061: type set to 3 (Philips (SECAM+PAL_BG) (FI1216MF, FM1216MF,
FR1216MF))
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv0: PLL: 28636363 => 35468950 .. ok
ALSA /mnt/hda3/sources/sources116/alsa-driver-1.0.15rc2/pci/bt87x.c:872:
unknown card 0x878-0x70:0x13eb
ALSA /mnt/hda3/sources/sources116/alsa-driver-1.0.15rc2/pci/bt87x.c:875:
please mail id, board name, and, if it works, the correct digital_rate
option to <alsa-devel@alsa-project.org>
ACPI: PCI Interrupt 0000:01:04.1[A] -> Link [LNK1] -> GSI 5 (level, low)
-> IRQ 5
ALSA /mnt/hda3/sources/sources116/alsa-driver-1.0.15rc2/pci/bt87x.c:943:
bt87x0: Using board 0, analog, digital (rate 32000 Hz)

I hope this can help.

regards



      _____________________________________________________________________________ 
Ne gardez plus qu'une seule adresse mail ! Copiez vos mails vers Yahoo! Mail 
