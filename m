From: Martin Langer <martin-langer@gmx.de>
Subject: hdsp bugfix
Date: Tue, 14 May 2002 12:48:15 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020514104815.GA17117@localhost>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id MAA23942
	for <alsa-devel@alsa-project.org>; Tue, 14 May 2002 12:48:45 +0200
Content-Disposition: inline
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


Hi,

there is a small bug in alsa-kernel/pci/Config.help
The right name for the new hdsp should be "CONFIG_SND_HDSP", or?

martin



--- Config.help.ORIGINAL	Tue May 14 12:35:56 2002
+++ Config.help	Tue May 14 12:37:50 2002
@@ -30,7 +30,7 @@
   Say 'Y' or 'M' to include support for RME Hammerfall (RME Digi9652 /
   Digi9636) soundcards.
 
-CONFIG_SND_RME9652
+CONFIG_SND_HDSP
   Say 'Y' or 'M' to include support for RME Hammerfall DSP Audio
   soundcards.


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
