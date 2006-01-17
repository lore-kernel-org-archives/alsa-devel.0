From: Lee Revell <rlrevell@joe-job.com>
Subject: SBLive! change of front channel routing broke wavetable synth?
Date: Tue, 17 Jan 2006 16:32:31 -0500
Message-ID: <1137533552.19678.38.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Mikael Magnusson <mikaelmagnusson@glocalnet.net>, Peter Zubaj <pzad@pobox.sk>
List-Id: alsa-devel@alsa-project.org

Several SBLive! users are reporting that the wavetable synth is silent
in recent ALSA versions.  I know that the wavetable synth output is
routed by the driver to the front channels (as we have had user requests
to allow it to output to the rear channels or all speakers in a 5.1
setup).

Is it possible that the recent change in the routing of front channels
from FXBUS 0,1 to FXBUS 8,9 has broken the wavetable synth?  It would
explain why I cannot reproduce the problem on my Audigy.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
