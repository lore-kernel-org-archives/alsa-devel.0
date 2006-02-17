From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: DMA buffers
Date: Fri, 17 Feb 2006 17:36:00 +0000
Message-ID: <1140197760.9094.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 8B72417A
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2006 18:36:02 +0100 (MET)
Received: from bossclass (bossclass [192.168.62.105])
	by localhost.localdomain (8.13.4/8.13.1) with ESMTP id k1HHa0Uj032280
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2006 17:36:00 GMT
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

Sorry, this is a bit of a basic question...

I want to use DMA to transfer data from normal memory to my device's
(Dreamcast sound card) memory.

When I use the ALSA DMA buffer code what is the buffer type that is
allocated - is this a buffer into which the data from user space is read
into and therefore is ready to be transferred using the DMA API my
system uses?



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
