From: Hartmut Geissbauer <nwgbh@swissonline.ch>
Subject: Re: snd-usb-audio hang when rmmoding after unplugging
	midisport1x1
Date: Fri, 12 Mar 2004 01:17:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1079050652.5139.68.camel@chief.local>
References: <20040311151651.217ccc07.geli@enseirb.fr>
	 <Pine.HPX.4.33n.0403111635570.18812-100000@studcom.urz.uni-halle.de>
	 <20040311204610.3766f038.geli@enseirb.fr>
	 <20040311213144.7b5ef095.geli@enseirb.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040311213144.7b5ef095.geli@enseirb.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I've the same symptom. Even with kernel 2.6.4 and the patch provided by Clemens. 
I own a Midisport 4x4. So it seems not to be model specific.
Initialzing is fine. But unplugin/replugin will request a reboot with sysrq intervention. 
First I've had enabled the USB 2.0 features on my motherboard with the same effect. 
But with the disadvantage not _receiving_ any MIDI messages. Sending was quite fine.
So I switched to USB 1.1 in the BIOS and receiving was been although possible.

Regards, Hartmut




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
