From: Kris Modrak <u9514439@anu.edu.au>
Subject: .asoundrc file
Date: Fri, 16 Aug 2002 13:17:34 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D5C6ECE.721D748C@anu.edu.au>
Reply-To: u9514439@anu.edu.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

The start of my .asoundrc file is as follows:

pcm.rme9652 {
type hw
card 0
device 0
}

ctl.rme9652 {
type hw
card 0
}

What is the purpose of the ctl.rme9652 declaration? My plugin devices
seem to work without it.

Regards
Kris Modrak


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
