From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Detecting the sample format in the driver
Date: Sun, 19 Mar 2006 23:20:12 +0000
Message-ID: <1142810413.9700.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 83C3C1CA
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2006 00:20:18 +0100 (MET)
Received: from bossclass ([192.168.62.105])
	by localhost.localdomain (8.13.4/8.13.4/Debian-3) with ESMTP id k2JNKE0I027030
	for <alsa-devel@alsa-project.org>; Sun, 19 Mar 2006 23:20:15 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

for some reason this isn't working for me - and I need to set hardware
channel parameters on the basis of the sample.

My hardware plays signed 8 bit, signed 16 bit little endian and 8 bit
adaptive differential PCM and I have this set...



.formats =
	    (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
	     SNDRV_PCM_FMTBIT_IMA_ADPCM),



But when I try to detect the format...

	if ((substream->runtime)->format == SNDRV_PCM_FMTBIT_S16_LE)
		channel->sfmt = SM_16BIT;


It doesn't seem to work.

I am assuming the alsa subsystem ought to process the stream for me - ie
any 16 bit stream will turn up as SNDRV_PCM_FMTBIT_S16_LE - is that
right? And if it is, why isn't it working?



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
