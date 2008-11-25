From: ngc@drvlabo.jp
Subject: (SoC) Does i.MX27's SSI work as I2S clock master?
Date: Wed, 26 Nov 2008 04:54:11 +0900
Message-ID: <D66C4C05-340D-4A6E-98FC-7B36F4059C36@drvlabo.jp>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.asahi-net.or.jp (mail2.asahi-net.or.jp [202.224.39.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 348FD1037E3
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 20:54:32 +0100 (CET)
Received: from mail.drvlabo.jp (d232177.ppp.asahi-net.or.jp [210.253.232.177])
	by mail.asahi-net.or.jp (Postfix) with ESMTP id 4E0266A724
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 04:54:31 +0900 (JST)
Received: from localhost (localhost [127.0.0.1])
	by mail.drvlabo.jp (Postfix) with ESMTP id E405C706446
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 04:54:30 +0900 (JST)
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

Hello, lists.

Now I'm porting WM8728 driver with i.MX27ADS, based on Freescale's BSP
kernel(2.6.22) and refering to ALSA SoC git repository.

I'm connecting the WM8728 to the SSI2 controller via SSI-3 signal set.
Then, my ADS board has altered:
  i.MX27         WM8728
  ---------------------
  SSI3_CLK       BCLKIN
  SSI3_FS        LRCIN
  SSI3_TXDAT     DIN
  TOUT/SSI2_MCLK  MCLK

Of course, I added some codes to configure GPIO pins as appropriate into
board specific sources.

Then, I'm trying to play sounds via WM8728 and
have not hear any sounds yet.
I checked SSI-3 signal set with an oscilloscope,
no clock signal appears on SSI3_CLK.
I tried the various SSI setting, I2S normal, I2S master,
asychronous/synchronous, normal mode/network mode, ...
But, I can't see clock signal, yet.


I want to know an example setting to act i.MX' SSI as I2S clock master.


Regards,

--------------
NOGUCHI Hiroshi
ngc@drvlabo.jp
