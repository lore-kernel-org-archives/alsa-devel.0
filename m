From: Jaroslav Kysela <perex@perex.cz>
Subject: switch to new PCM API for 1.0 release
Date: Wed, 5 Nov 2003 11:47:58 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0311051141250.1187@F137.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA19777
	for <alsa-devel@alsa-project.org>; Wed, 5 Nov 2003 11:48:02 +0100
Received: from pnote.perex-int.cz (F137.suse.de [10.10.102.137])
	by perex.home.suse.cz (Perex's E-mail Delivery System) with ESMTP id D3157120
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2003 11:48:00 +0100 (MET)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

	I decided to switch to new PCM API (values are returned using an
indirect pointer rather as return value, so error codes are not mixed with
values). The binary compatibility is kept. So, you can use old
applications with new libraries and you can even use applications compiled
against 1.0 alsa-lib with 0.9 library binaries.
	The only change for developers or package maintainers are two
defines for old (not updated) applications:

#define ALSA_PCM_OLD_HW_PARAMS_API
#define ALSA_PCM_OLD_SW_PARAMS_API
#include <alsa/asoundlib.h>

	Also note that these defines might be removed for updated
applications (altough the code will not compile with 0.9 libraries):

#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
