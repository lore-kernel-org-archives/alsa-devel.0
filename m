From: vanDongen/Gilcher <gml@xs4all.nl>
Subject: rme96 and adat, problems opening for capture when clock-master
Date: Mon, 1 Jul 2002 12:29:09 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0ChZyM167A140000.gml@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
Cc: Anders.Torger@xs4all.nl, torger@ludd.luth.se
List-Id: alsa-devel@alsa-project.org

Hello,
I am using a rme 96/8 card.
I encounter a problem whenever I try to open the adat device, which is the 
second device on the card, for capture. I get an input/output error.
The problem occurs when I switch from spdif to adat (from hw:0,0 to hw:0,1 
in my case) _and_ the clock mode is master. If I set the card to slave mode 
and change the settings on my adda converter, there is no problem.
Playback only will always work.
So f.i. if I start pd, with hw:0,1 as audio device, I have to start once , 
with an error message that it can't open the card for capture. Then I quit, 
and start pd again. 
The second time it works for capture as well as for playback.

Is this a bug in the driver?

regards

Gerard


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
