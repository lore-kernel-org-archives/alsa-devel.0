From: Thomas Charbonnel <thomas@undata.org>
Subject: HDSP driver : distortion at normal volume settings
Date: 31 Aug 2002 20:55:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1030820108.7184.46.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mel-rto2.wanadoo.fr (smtp-out-2.wanadoo.fr [193.252.19.254])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA00391
	for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2002 20:56:52 +0200
Received: from mel-rta10.wanadoo.fr (193.252.19.193) by mel-rto2.wanadoo.fr (6.5.007)
        id 3D5392B60091F40D for alsa-devel@alsa-project.org; Sat, 31 Aug 2002 20:56:15 +0200
Received: from satellite.undata.org (193.252.186.224) by mel-rta10.wanadoo.fr (6.5.007)
        id 3D6EE88E000C6B08 for alsa-devel@alsa-project.org; Sat, 31 Aug 2002 20:56:15 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Paul,

I've been testing the hdsp driver for two days now, and noticed some
distortion in the audio signal at normal to high volume levels (roughly
above 80%). Playing a 0db sine in pd (using OSS emulation), I could even
hear distortion above 50% (sine turning to square). I'm using the
multiface, and didn't change the factory jumper settings. This is not
the first time I notice distortion at high level with alsa drivers
(other times were with pci soundblaster and intel810). Is this the
normal alsa behavior (50% = 0db, more actively boosting the signal, in
which case I should reconsider my definition of "normal volume setting")
?

Thomas

p.s: [slightly OT] Is there a totalmix linux equivalent on the way ?





-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
