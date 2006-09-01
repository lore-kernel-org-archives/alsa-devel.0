From: Harald Gutmann <harald.gutmann@gmx.net>
Subject: joining 2 mixer ports with .asoundrc?
Date: Fri, 01 Sep 2006 15:24:30 +0200
Message-ID: <44F8348E.2040200@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hello!

i've here a m-audio 1010lt with an ice1712 chip.
on this card, there is no pcm mixer channel per default, but i think it 
should be possible to add on in the .asoundrc file.

the problem is, that the documentation about the ctl.NAME is verry barely.
in the alsa wiki/documentation i only find the:

ctl.NAME {
type hw
card 0
}

but i'd like to create a mixer which is called pcm (at the moment a 
mixer with that name doesn't exist),
and this mixer should join the mixer DAC1 and the DAC2 to one mixxer, 
called pcm.

what has to be insert in the .asoundrc, to get this working?
any hint on a documentation/newsgrouppost/maillinglistarchive for 
controlling mixer devices in the .asoundrc?


best regards,
harald gutmann

ps: i post it also in the deve-list, because in the user list, it seems 
that nobody knows whow it works, eg. what i want. :)

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
