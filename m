From: Matt Flax <flatmax@ieee.org>
Subject: init.d stopping modules
Date: Tue, 21 Jan 2003 00:00:20 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030120130020.GA17562@ee.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.unsw.edu.au (smtp3.unsw.EDU.AU [149.171.96.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA01627
	for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2003 13:22:56 +0100
Received: from smtp.unsw.edu.au (antivirus-02.services.comms.unsw.EDU.AU [149.171.193.81])
	by smtp3.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h0KCMbn13101
	for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2003 23:22:37 +1100 (EST)
Received: from maillationax ([149.171.37.159])
	by smtp.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h0KCMbc13097
	for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2003 23:22:37 +1100 (EST)
Received: from flatmax by maillationax with local (Exim 3.36 #1 (Debian))
	id 18abXJ-0004aU-00
	for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2003 00:00:21 +1100
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I have several alsa modules running (see below) and would like to stop 
them and restart them because I run 'alsa rc6' and sound appears to stop 
during testing of my applications (due to my own segfaults).
The problem (see below) is that the init.d script tries to rmmod the 
alsa modules, but they don't get unloaded !

I use the alsa-driver-0.9.0rc6/utils/alsasound init.d script.
when I type :
# /etc/init.d/alsasound stop
Shutting down sound driver: snd-cmipci: Device or resource busy
snd-pcm: Device or resource busy
snd-mpu401-uart: Device or resource busy
snd-rawmidi: Device or resource busy
snd-opl3-lib: Device or resource busy
snd-timer: Device or resource busy
snd-seq-device: Device or resource busy
snd-hwdep: Device or resource busy
snd: Device or resource busy
done

The modules don't get unloaded so they can't re-load.
Any ideas as to how to fix the problem with the init.d script ???

thanks
Matt

_________________ running modules ___________________________
snd-cmipci             14436   1 
snd-pcm                53600   1  [snd-cmipci]
snd-mpu401-uart         2624   0  [snd-cmipci]
snd-rawmidi            11616   0  [snd-mpu401-uart]
snd-opl3-lib            5280   0  [snd-cmipci]
snd-timer               9312   0  [snd-pcm snd-opl3-lib]
snd-seq-device          3696   0  [snd-rawmidi snd-opl3-lib]
snd-hwdep               3424   0  [snd-opl3-lib]
snd                    23848   3  [snd-cmipci snd-pcm snd-mpu401-uart 
snd-rawmid
i snd-opl3-lib snd-timer snd-seq-device snd-hwdep]
soundcore               3556   3  [snd]


-- 
http://mffm.darktech.org

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
