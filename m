From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] let SND_SUPPORT_OLD_API depend on SND_PCM
Date: Tue, 10 Jan 2006 17:44:49 +0100
Message-ID: <20060110164449.GN3911__18615.8999371857$1136911635$gmane$org@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id A9E50135
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2006 17:44:50 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

SND_SUPPORT_OLD_API only has an effect if SND_PCM is set.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm2-full/sound/core/Kconfig.old	2006-01-10 17:35:35.000000000 +0100
+++ linux-2.6.15-mm2-full/sound/core/Kconfig	2006-01-10 17:36:07.000000000 +0100
@@ -124,7 +124,7 @@
 
 config SND_SUPPORT_OLD_API
 	bool "Support old ALSA API"
-	depends on SND
+	depends on SND_PCM
 	default y
 	help
 	  Say Y here to support the obsolete ALSA PCM API (ver.0.9.0 rc3



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
