From: Mathieu Geli <geli@enseirb.fr>
Subject: Re: snd-usb-audio hang when rmmoding after unplugging
 midisport1x1
Date: Thu, 11 Mar 2004 20:46:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040311204610.3766f038.geli@enseirb.fr>
References: <20040311151651.217ccc07.geli@enseirb.fr>
	<Pine.HPX.4.33n.0403111635570.18812-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0403111635570.18812-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks for your reply,

ok, what I did, is first to apply your patch to my source tree (1.0.3rc2), clean, compile, install, and even reboot.
That doesn't output anymore the two lines "urb status -104", and "usb_submit_urb: -32" but still hang after printing:
"drivers/usb/core/usb.c: deregistering driver snd-usb-audio"

So I have dl the CVS and reinstalled alsa-driver. That just have the same effect :/

Mathieu


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
