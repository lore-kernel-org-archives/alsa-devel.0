From: David Lloyd <dmlloyd@tds.net>
Subject: dmix and full-duplex
Date: Wed, 17 Dec 2003 14:11:11 -0600 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312171402370.23689@tomservo.workpc.tds.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

After much frustration being stuck on intel8x0 and trying to run teamspeak 
at the same time as a game, I was looking at the dmix implementation and I 
had several questions.

What I want to do is modify dmix to do one of these things, in order of 
increasing desirability:

1) When capture stream is opened, let the open succeed, and all audio read 
from the capture stream is 0 (like the null plugin I guess).

2) Allow one client to open capture stream and just pipe data from the 
slave to the client (no multiplexing of any kind).

3) Combine dmix and dsnoop into a full-duplex sharing plugin.  This seems 
like the ideal setup to me.

The current implementation seems to me to handle capture stream in the 
worst possible way.  When I open TeamSpeak and a game with sound with 
dmix, TeamSpeak wont even open the sound device for playback because 
capture returns an error.

The thing is, dmix seems to have been around for years and nobody has 
addressed the shared full duplex issue, although it is talked about from 
time to time.

So I will make a deal... if you all give me support and help with my
questions, I'll tackle the problem myself, probably in the order I've
liested above. :)

Otherwise, if you all think this is not a worthwhile avenue to pursue, I 
will try to convince my wife to let me buy a sblive and call it a day. :)

- D


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
