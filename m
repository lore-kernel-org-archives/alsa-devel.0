From: "Robert Rozman" <rozman@fri.uni-lj.si>
Subject: What does underrun mean with aplay ?
Date: Fri, 9 Apr 2004 10:41:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <004d01c41e0e$6cfa1280$fbf7a8c0@Lapitopi>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have some problems with 6 channel sis 7012 device - I'm using it as 3
stereo channels. I trigger 3 different instances of aplay at once and I get
underrun messages from aplay.

What does this mean ?
How to solve this  (bigger buffer? ) ?

It sounds like it is interleaved in short chunks (all channels are heard on
all channels) - so it's not really bearable.

Regards,

Robert.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
