From: Clemens Ladisch <clemens@ladisch.de>
Subject: USB 2.0 high speed support
Date: Fri, 19 Mar 2004 09:20:51 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403190906500.14886-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
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

Hi all,

The latest version of the snd-usb-audio driver now supports USB 2.0
high speed devices.  (The driver will be in the public SourceForge CVS
in a few hours.)

I couldn't test it much because I don't have a high speed device.  If
you have an Audigy 2 NX, or an Edirol UA-1000, or some other high
speed audio device, please consider testing it.  (I have reports of
crackling with the Audigy2NX, but it seems this happens in full speed
mode, too.)

To see whether your card is in high speed mode, look into
/proc/asound/cards.  The entry will have "full speed" or "high speed"
for USB 1.x or 2.0, respectively.


Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
