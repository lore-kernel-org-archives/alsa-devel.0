From: "Adrian McMenamin" <adrian@mcmen.demon.co.uk>
Subject: Some quick pointers requested
Date: Thu, 26 Jan 2006 12:41:38 -0000 (GMT)
Message-ID: <33237.217.150.108.178.1138279298.squirrel@newgolddream.dyndns.info>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 69FBD19E
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 13:41:46 +0100 (MET)
Received: from newgolddream.dyndns.info (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.1) with ESMTP id k0QCfcx1029927
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 12:41:38 GMT
References: 
In-Reply-To: 
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

I am writing a driver for the sound card on the Dreamcast (I have been fo=
r
about three years now, but i am actually making progress now).

I have a shell of a driver which doesn't do very much (you can see the
sources at http://newgolddream.dyndns.info/repos) but I have now built an=
d
installed alsalib and alsa-utils against uClibc to test what I have.

However a quick use of aplay generates a number of errors:


/sys/devices/platform/snd_card_aica # aplay -L
aplay: pcm_list:280: snd_config_update: Invalid argument
/sys/devices/platform/snd_card_aica # aplay -v
aplay: main:533: audio open error: Invalid argument
/sys/devices/platform/snd_card_aica # aplay -vvv
aplay: main:533: audio open error: Invalid argument
/sys/devices/platform/snd_card_aica # aplay -v -L
aplay: pcm_list:280: snd_config_update: Invalid argument
/sys/devices/platform/snd_card_aica # aplay -v -l
**** List of PLAYBACK Hardware Devices ****
aplay: device_list:226: control open (0): Invalid argument


Could somebody point me as to what is likely to be wrong to get me starte=
d
on fixing it? Thanks

Adrian



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
