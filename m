From: Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: 1.0.5a on VIA 8235 breaks mplayer
Date: Sat, 12 Jun 2004 16:30:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406121630.40754.bero@arklinux.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
after updating from ALSA 1.0.4 to 1.0.5a on a VIA EPIA-M board (VIA 
8235/ICEnsemble VT1616i chip), mplayer starts acting really oddly 
(complaining about "alsa-space: xrun of at least 29.847 msecs. resetting 
stream" after every other frame).

Switching mplayer to use ALSA's OSS emulation rather than native ALSA still 
works.

Any ideas?

LLaP
bero


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
