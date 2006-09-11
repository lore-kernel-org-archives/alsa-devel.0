From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: 2.6.18-rc6-mm1: endless loop in snd_hda_intel on HPC
	6325, sometimes
Date: Mon, 11 Sep 2006 22:20:04 +0200
Message-ID: <200609112220.04753.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C827527D
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Sep 2006 22:19:58 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On the HPC 6325 I'm currently using snd_hda_intel sometimes goes into an
endless loop in wich it plays the same chunk of sound (< 1 sec.) repeatedly
forever.

It helps to reload the snd_hda_intel module.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
