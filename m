From: James Courtier-Dutton <James@superbug.co.uk>
Subject: alsa driver and udev.
Date: Thu, 07 Dec 2006 11:11:01 +0000
Message-ID: <4577F6C5.2050206@superbug.co.uk>
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

Hi,

How much work would it be to get alsa driver to work nicely with udev, 
so that a specific udev config could be used to decide which sound card 
is card 0 etc.
How about a global config interface whereby userland processes could 
modify the sound card order and possibly provide other general sound 
card related services to userspace. In this way, even if a sound card 
booted up as card 0, we could swap it with card 1 without having to 
unload it.
This might require the device naming in /dev/snd to change so that the 
card number was not included in the device name. Maybe use an extra 
subdirectory for each card, much like the /proc filesystem uses.

James

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
