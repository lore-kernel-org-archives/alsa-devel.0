From: Mathieu Geli <geli@enseirb.fr>
Subject: Re: snd-usb-audio hang when rmmoding after unplugging
 midisport1x1
Date: Thu, 11 Mar 2004 21:31:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040311213144.7b5ef095.geli@enseirb.fr>
References: <20040311151651.217ccc07.geli@enseirb.fr>
	<Pine.HPX.4.33n.0403111635570.18812-100000@studcom.urz.uni-halle.de>
	<20040311204610.3766f038.geli@enseirb.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040311204610.3766f038.geli@enseirb.fr>
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

sorry about my fuzzy observations, my bad, even with the last CVS I got those errors line when rmmoding snd-usb-audio, while the device is on. (I didn't redo the same actions than before)
Is there any way to maybe unplug the device safely (usbfs point of view) ? I was guessing smtgh like a fxUNload programm.
There is obviously something from the midisport1x1 who bugs snd-usb-audio. Indepandently they works both fine :)

Maybe I've a easy view 'bout how the things are working, but I would expect from snd-usb-audio a timeout, after which he gives up, trying to communicate with the device if nothnig happens.

Cheers,

Mathieu


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
