From: Ed Sweetman <safemode@speakeasy.net>
Subject: pcm_peak code in aplay
Date: 02 Jun 2002 03:11:53 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1023001914.10073.9.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

It seems to me that the pcm_peak code in aplay doesn't work or maybe i
dont understand it's actual function.  It shows the same thing over and
over no matter what the volume of the audio going through it (captured
from mic).  


I want to return the decibel level of audio being captured from my
soundcard in alsa 0.9x and it seemed an easy enough hack to make in
aplay since it found the max peak.  should I look somewhere else? Can
anyone show me something that maybe does this already or at least finds
the max peak of any given interval (console)?   




_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
