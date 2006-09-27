From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Feature needed for EMU1820m driver
Date: Wed, 27 Sep 2006 19:15:45 +0100
Message-ID: <451ABFD1.5030206@superbug.co.uk>
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

The E-MU 1820m consists of a PCI card with a connector on it.
A cable then runs to an external box called the AudioDock with all the
audio IO on it.
The AudioDock is hot pluggable.
The problem is that no interrupts occur if one connects the AudioDock.
One would have to poll the device until one saw a certain bit being set.
One would then know the AudioDock was there. The driver then needs to
load some firmware into the AudioDock.

My question is, what should I use to monitor for the plug/unplug of the
AudioDock? I would expect some user land app could do the polling, but
that might require some new ALSA api to support it.

James

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
