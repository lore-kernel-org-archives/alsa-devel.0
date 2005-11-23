From: "Theodoros V. Kalamatianos" <thkala@softlab.ece.ntua.gr>
Subject: Conexant softmodem and snd-intel8x0m
Date: Thu, 24 Nov 2005 01:41:24 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0511240134010.7042@rhama.deepcore.ngn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ulysses.noc.ntua.gr (ulysses.noc.ntua.gr [147.102.222.230])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 47C831BA
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2005 00:44:06 +0100 (MET)
Received: from theseas.softlab.ece.ntua.gr (theseas.softlab.ece.ntua.gr [147.102.1.1])
	by ulysses.noc.ntua.gr (8.13.1/8.13.1) with ESMTP id jANNi2qi051205
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2005 01:44:03 +0200 (EET)
	(envelope-from thkala@softlab.ece.ntua.gr)
Received: from rhama.deepcore.ngn (ppp161.dialup.ntua.gr [147.102.223.161])
	(authenticated bits=0)
	by theseas.softlab.ece.ntua.gr (8.13.4/8.13.4/Debian-3) with ESMTP id jANNhvus012152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2005 01:44:00 +0200
Received: from rhama.deepcore.ngn (localhost.localdomain [127.0.0.1])
	by rhama.deepcore.ngn (8.13.5/8.13.3) with ESMTP id jANNfOJb007931
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2005 01:41:24 +0200
Received: from localhost (sysop@localhost)
	by rhama.deepcore.ngn (8.13.5/8.13.3/Submit) with ESMTP id jANNfOLQ007925
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2005 01:41:24 +0200
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

Hi,

I own a Dell Latitude D800 laptop with a Centrino chipset and a Conexant 
modem chip, which I have seen refered to as a CXT22 in some logs. The pcm 
part of the modem is properly recognised by the snd-intel8x0m ALSA module, 
but I am unable to tell the modem to go off-hook, as the related mixer 
control does not seem to do anything. Has anyone had any success with ALSA 
and these modems ? How can I help to add support for them to ALSA ?


Regards,

Theodoros Kalamatianos


PS: Oh, the modem works with the Linuxant hsfmodem driver, but it has 
some problems and the speed is limited to 14.4kbps, since I use the free 
vesion. I'd really like to move to a more open driver...


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
