From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: ice1712,how to use all 10 channels
Date: Thu, 5 Feb 2004 23:44:12 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.58.0402052333310.295426@kosh.hut.fi>
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

Hi. If I understood correctly ice1712 is capable of hardware mixing 10
channels. How do I access these different channels from eg. aplay

Like sblive can do:

aplay -D front
aplay -D rear

simultaneously, without blocking each other (or can it?)

I would need access to Audiophile 2496's analog & digital channels
separately (channels 0,1 for analog; 8,9 for digital) without blocking.

And I think the driver can handle this, but how Joe User can accomplish
this without C++ knowledge. Or without .asoundrc knowledge..

Thanks!

Tommi Uimonen

ps. I know this can be done with JACK, but I'm not looking for that.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
