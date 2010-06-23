From: anilkumar <kollianil2009@gmail.com>
Subject: Re:
	=?utf-8?q?imx-ssi=2Ec_=26amp=3B_SND=5FSOC=5FDAIFMT?=
	=?utf-8?q?=5FI2S?=
Date: Wed, 23 Jun 2010 10:15:09 +0000 (UTC)
Message-ID: <loom.20100623T120433-100@post.gmane.org>
References: <4BFCEB10.6000205@eukrea.com>
	<20100527005647.GC22091@sirena.org.uk>
	<4BFDC7C7.7000507@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 3476E24418
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 12:20:06 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1ORN3s-0004NB-4u
	for alsa-devel@alsa-project.org; Wed, 23 Jun 2010 12:20:04 +0200
Received: from 203.201.62.66 ([203.201.62.66])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 12:20:04 +0200
Received: from kollianil2009 by 203.201.62.66 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 12:20:04 +0200
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


Hi Eric,

I am using the same Devices i.mx27 ssi as a slave and tlv320aic33 as a master.

I am getting the bit clock and word clock but I am not getting the data when I
play using aplay command and it is giving the underrun error.

I am using the linux-2.6.32 kernel

I am giving here the register dump.

mx27# aplay test_file.wav 
dump @ imx_ssi_startup
STX0 0
STX1 0
scr 0
sisr 3003
stcr 200
srcr 200
stccr 40000
srccr 40000
sfcsr 440044
stmsk 0
srmsk 0
sier 3003
Playing WAVE 'test_file.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
dump @ imx_ssi_prepare
STX0 0
STX1 0
scr 50
sisr 3003
stcr 289
srcr 289
stccr 4e000
srccr 4e000
sfcsr 440044
stmsk 0
srmsk 0
sier 783503
dump @ dma_new_period
STX0 0
STX1 0
scr 50
sisr 3003
stcr 289
srcr 289
stccr 4e000
srccr 4e000
sfcsr 440044
stmsk 0
srmsk 0
sier 783503
dump @ dma_new_period
STX0 0
STX1 0
scr 50
sisr 3003
stcr 289
srcr 289
stccr 4e000
srccr 4e000
sfcsr 440044
stmsk 0
srmsk 0
sier 783503
dump @ imx_ssi_trigger
STX0 0
STX1 0
scr 53
sisr 3001
stcr 289
srcr 289
stccr 4e000
srccr 4e000
sfcsr 440044
stmsk 0
srmsk 0
sier 783503
dump @ audio_dma_irq
STX0 0
STX1 0
scr 53
sisr 3001
stcr 289
srcr 289
stccr 4e000
srccr 4e000
sfcsr 440044
stmsk 0
srmsk 0
sier 783503
dump @ imx_ssi_trigger
STX0 0
STX1 0
scr 51
sisr 3001
stcr 289
srcr 289
stccr 4e000
srccr 4e000
sfcsr 440044
stmsk 0
srmsk 0
sier 783503
underrun!!! (at least 2.738 ms long)
underrun!!! (at least 2.329 ms long)
underrun!!! (at least 9.367 ms long)
underrun!!! (at least 8.608 ms long)
underrun!!! (at least 5.143 ms long)
underrun!!! (at least 9.898 ms long)
underrun!!! (at least 10.871 ms long)
underrun!!! (at least 2.419 ms long)
underrun!!! (at least 7.744 ms long)
underrun!!! (at least 1.232 ms long)
underrun!!! (at least 9.252 ms long)
underrun!!! (at least 11.574 ms long)
underrun!!! (at least 0.977 ms long)
underrun!!! (at least 2.145 ms long)
underrun!!! (at least 0.123 ms long)
underrun!!! (at least 0.246 ms long)
underrun!!! (at least 9.592 ms long)
underrun!!! (at least 5.880 ms long)
underrun!!! (at least 10.787 ms long)
underrun!!! (at least 10.750 ms long)
underrun!!! (at least 1.000 ms long)
underrun!!! (at least 2.313 ms long)
underrun!!! (at least 7.890 ms long)
underrun!!! (at least 10.555 ms long)
underrun!!! (at least 8.590 ms long)
underrun!!! (at least 8.882 ms long)
underrun!!! (at least 8.340 ms long)
underrun!!! (at least 10.537 ms long)
underrun!!! (at least 11.060 ms long)
underrun!!! (at least 8.724 ms long)
underrun!!! (at least 2.152 ms long)
underrun!!! (at least 8.223 ms long)
underrun!!! (at least 11.946 ms long)
underrun!!! (at least 5.138 ms long)
underrun!!! (at least 20.275 ms long)
underrun!!! (at least 13.806 ms long)
underrun!!! (at least 0.882 ms long)
underrun!!! (at least 5.893 ms long)
underrun!!! (at least 6.395 ms long)
underrun!!! (at least 5.790 ms long)
underrun!!! (at least 11.237 ms long)
underrun!!! (at least 9.248 ms long)
underrun!!! (at least 7.412 ms long)
underrun!!! (at least 9.083 ms long)
underrun!!! (at least 0.182 ms long)
underrun!!! (at least 3.309 ms long)
underrun!!! (at least 9.153 ms long)
underrun!!! (at least 9.418 ms long)
underrun!!! (at least 8.878 ms long)
underrun!!! (at least 6.878 ms long)
underrun!!! (at least 9.293 ms long)
underrun!!! (at least 8.395 ms long)
underrun!!! (at least 9.006 ms long)
underrun!!! (at least 9.996 ms long)
underrun!!! (at least 0.635 ms long)
underrun!!! (at least 10.810 ms long)
underrun!!! (at least 10.753 ms long)
underrun!!! (at least 1.756 ms long)
underrun!!! (at least 1.574 ms long)
imx_dma_free: trying to free free channel 8
mx27#

Please send me the configuration [if any changes] from i.mx ssi slave and
tlv320aic33.

Thanks & Regards,
Anil.
