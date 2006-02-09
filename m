From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Can anyone help?
Date: Thu, 09 Feb 2006 23:07:35 +0000
Message-ID: <1139526455.9296.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 9E37E19D
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2006 00:07:38 +0100 (MET)
Received: from bossclass (bossclass [192.168.62.105])
	by localhost.localdomain (8.13.4/8.13.1) with ESMTP id k19N7Z8B031822
	for <alsa-devel@alsa-project.org>; Thu, 9 Feb 2006 23:07:35 GMT
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

I cannot get aplay to work on my architecture (afaics anyway) eg

/ # aplay -D hw:0,0 /bin/busybox
aplay: pcm.c: 2119: snd_pcm_open: Assertion `pcmp && name' failed.
Aborted

(Nobody has explained to me what that error is - and my reading of the
code hasn't helped too much :-< )

So how can I test my driver code?

I can do things like this:

/ # cat /bin/busybox > /dev/snd/pcmC0D0p
ALSA /home/adrian/aica/aica/snd_card_aica.c:151: In snd_aicapcm_pcm_open
cat: Write Error: File descriptor in bad state
/ # Feb 10 00:01:02 dreamy user.warn kernel:
ALSA /home/adrian/aica/aica/snd_card_aica.c:151: In snd_aicapcm_pcm_open

But as the above fragment shows this opens the device file but not much
else (as I assume it has no automagic way of accessing the alsa
subsystem)

My driver code is at http://newgolddream.dyndns.info/repos btw



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
