From: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>
Subject: PCM Rate Plugin
Date: Mon, 8 Apr 2002 19:24:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.44.0204081917280.22112-100000@fest.stud.fee.vutbr.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

do you know about some example for $SUBJ. I need to be able to work with
all sampling rates in UDA1341 driver for iPAQ. When I use "rec & play"
from OSS with OSS emulation, it looks, there is some resampling in
oss-emulation part of ASLA kernel code.

But for native ALSA recoding on frequency other that defined in card ends
with "arecord" saying everything is fine, but created file contains just
header. My driver is requested to capture on some near rate in this case.

Resampling on user-level is enough for me, so if ALSA has some usable
support it will be fine, but I'm not able to find it and get it running.

Thanks for your help.

--

	Tomas Kasparek (sioux, xkaspa06)
 	 tomas.kasparek@[seznam.cz,volny.cz]
	 linux@fit.vutbr.cz
	student FIT VUT Brno
