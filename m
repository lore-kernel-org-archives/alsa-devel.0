From: Mario <anyc@hadiko.de>
Subject: Enable docking station speaker jack for new Lenovo
	Thinkpads
Date: Tue, 31 Jul 2012 00:13:45 +0200
Message-ID: <50170719.8090207@hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout.scc.kit.edu (mailout.scc.kit.edu [129.13.185.202])
 by alsa0.perex.cz (Postfix) with ESMTP id A0C232652F4
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 00:13:50 +0200 (CEST)
Received: from hsi-kbw-095-208-138-254.hsi5.kabel-badenwuerttemberg.de
 ([95.208.138.254] helo=[192.168.14.85])
 by mail.hadiko.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.72) (envelope-from <anyc@hadiko.de>) id 1SvyDo-0001Xh-IN
 for alsa-devel@alsa-project.org; Tue, 31 Jul 2012 00:13:52 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

for new Lenovo Thinkpads (mine T530, will probably affect all new 
[TXW][45]30 models), the model=thinkpad module option does not enable 
the speaker jack of the docking station. Sound works perfectly with the 
laptop, only the docking station needs extra work. I managed to get it 
work using hda-analyzer. It produced the following diff:

Diff for codec 0/0 (0x10ec0269):
---
+++
@@ -210,28 +210,28 @@
    Unsolicited: tag=0x00, enabled=0
    Power: setting=D0, actual=D0
    Connection: 2
       0x0c* 0x0d
  Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
    Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
    Amp-In vals: [0x00 0x00]
    Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
-  Amp-Out vals: [0x80 0x80]
+  Amp-Out vals: [0x00 0x00]
    Pincap 0x00003734: IN OUT Detect
      Vref caps: HIZ 50 GRD 80 100
    Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
      Conn = 1/8, Color = Black
      DefAssociation = 0xf, Sequence = 0x0
      Misc = NO_PRESENCE
-  Pin-ctls: 0x20: IN VREF_HIZ
-  Unsolicited: tag=0x00, enabled=0
-  Power: setting=D0, actual=D0
-  Connection: 2
-     0x0c* 0x0d
+  Pin-ctls: 0x40: OUT VREF_HIZ
+  Unsolicited: tag=0x00, enabled=0
+  Power: setting=D0, actual=D0
+  Connection: 2
+     0x0c 0x0d*
  Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
  Node 0x1d [Pin Complex] wcaps 0x400400: Mono
    Pincap 0x00000020: IN
    Pin Default 0x40138205: [N/A] Speaker at Ext N/A
      Conn = ATAPI, Color = Purple
      DefAssociation = 0x0, Sequence = 0x5
    Pin-ctls: 0x20: IN
    Power: setting=D0, actual=D0

Relevent lspci entry:

00:1b.0 Audio device [0403]: Intel Corporation 7 Series/C210 Series 
Chipset Family High Definition Audio Controller [8086:1e20] (rev 04)

Chip: Realtek ALC269VC

Further alsa-info: 
http://www.alsa-project.org/db/?f=e297bdda4fd099425516c7c831e28a2c7d8ae6b6

Unfortunately, I failed to create a working hda-verb script. I can
change the out-pin with:

hda-verb /dev/snd/hwC0D0 0x1b SET_PIN_WIDGET_CONTROL 0x40

but I did not find the command to unmute the channel. Can anyone tell me 
which options are necessary and can this easily be fixed in the kernel?

Also, hda-analyzer showed me two mixer devices, they produce a slightly
different sound. I don't know if this is important.

Thank you very much!
Mario
