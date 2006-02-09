From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Can anyone help?
Date: Thu, 09 Feb 2006 23:33:51 +0000
Message-ID: <1139528032.9296.8.camel@localhost.localdomain>
References: <1139526455.9296.5.camel@localhost.localdomain>
	 <1139527169.30058.130.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 5A26F19E
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2006 00:33:54 +0100 (MET)
In-Reply-To: <1139527169.30058.130.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-02-09 at 18:19 -0500, Lee Revell wrote:
> On Thu, 2006-02-09 at 23:07 +0000, Adrian McMenamin wrote:

> It looks like you fail to set card->id in your __devinit routine.  This
> field is used by the alsa-lib to find the right config file
> in /usr/share/alsa/cards/.  For example if alsa-lib is supposed to use 
> /usr/share/alsa/cards/Audigy2.conf set it to "Audigy2".
> 

I don't think that is it:

/ # modprobe snd_card_aica
ALSA /home/adrian/aica/aica/snd_card_aica.c:323: Probing for AICA device
ALSA /home/adrian/aica/aica/snd_card_aica.c:305: Loading aica firmware
ALSA /home/adrian/aica/aica/snd_card_aica.c:366: ALSA Driver for Yamaha
AICA Super Intelligent Sound Processor on slot 0
/ # cd /proc/asound
/proc/asound # ls
AICA     card0    cards    devices  modules  pcm      timers   version
/proc/asound # cd card0
/proc/asound/card0 # ls -l
-r--r--r--    1 root     root            0 Feb 10 00:39 id
dr-xr-xr-x    3 root     root            0 Feb 10 00:39 pcm0p
/proc/asound/card0 # cat id
AICA


There are no setup files, but the wiki says that aplay -D hw:0,0 ought
to get round that anyway. have I misunderstood that?





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
