From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: New mixer api.
Date: Mon, 23 Jun 2003 16:36:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EF71E76.5070708@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA12508
	for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2003 17:36:25 +0200
Received: from superbug.demon.co.uk ([158.152.58.16])
	by anchor-post-32.mail.demon.net with esmtp (Exim 3.35 #1)
	id 19UTMk-000676-0W
	for alsa-devel@alsa-project.org; Mon, 23 Jun 2003 16:36:22 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

If a user has a 5.1 sound card, but only has 2 speakers connected, it 
would be nice if the user could tell alsa this fact.
Then the amount of sliders in the mixer could be reduced, and also, an 
application could detect what the user has set up.
It would be nice for the user to only have to tell one application(maybe 
the mixer app) that they only have 2 speakers connected to a 5.1 sound 
card, and then all other applications run by the user would 
automatically pick up that information.
It seems to me, that the best place to store this infomation is in alsa 
somewhere.
It would also be nicer to have a better description language for the 
mixer elements, so that a single GUI mixer, could draw a diagram of how 
each mixer element effects which other ones. This idea could probably be 
expanded for some sound cards, whereby the mixer GUI could be used to 
let the user design their own mixer setup. E.g. The SB Live could be 
programmed for all sorts of different mixing setups.
So, as a suggestion, each mixer element should have extra meta info like 
this: -
Entry: 1
Type: output
Description: Front Speakers.

Entry: 2
Type: Mixer
Description: Volume
Range: 1-100
Channels: Left and Right
Input comes from (3)
Output goes to (1).

Entry: 3
Type: input
Description: PCM stream from computer.

One could have multiple "Input comes from" and "output goes to" for each 
mixer element.

With this sort of information, a GUI could draw a nice diagram of the mixer.



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
