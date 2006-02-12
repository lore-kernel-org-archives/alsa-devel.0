From: hurricane <hurricane@barmusic.com>
Subject: using more than 8 boards of the same kind, at once, on a single
 system
Date: Sun, 12 Feb 2006 09:43:07 -0500
Message-ID: <1139755387.25868.1.camel@lnx.rgptech.com>
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
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Folks!

        I have designed a video/audio USB2.0 board (WISIWYG 1.0), that I
use on
2.6.11-1.27_FC3smp that uses the WIS GO7007 chip, and have run into a
limit of 8 boards that can be recognized for audio by the WIS device
driver. I need to use up to 48 boards on one system. Video For Linux
works with this number, but I am at a loss for getting the audio system
to work with more than 8 boards at once. (My board uses stereo Audio,
raw pcm)

        I am not an expert on the Fedora Core 3 audio system, so any
help would
be greatly appreciated. If I am on the wrong list, I am sure someone
will be kind enough to point this out. My system seems to have version
1.08 of the Alsa kernel installed by default.

Thanks,

R. Gordon Price
RGP Technologies Inc.
(727) 859-0654 Port Richey FL
http://rgptech.com





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
