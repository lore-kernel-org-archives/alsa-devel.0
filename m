From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: hardware channel mixing
Date: Fri, 03 Sep 2004 14:59:26 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0409031451550.24397-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0408291058200.4131@pat.dumaisnet.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.58.0408291058200.4131@pat.dumaisnet.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Dumais <pat@dumaisnet.ca>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Dumais wrote:
> When I read a description of what the soundblaster Live features, I notice
> they say "131 hardware channels". Now is this what I think it is? does it
> mean that I can actualy write multiple (upto 131) sounds and let the card
> mix it by itself?

Essentially, yes, but the real number is 64 voices, and each stereo
stream needs two of them, so you can play 32 streams simultaneously.

> If so, I haven't seen any documentation about this.

On the SB Live, the PCM device has 32 subdevices.  The subdevice
number can be specified as the third number in the "hw:x,y,z" device
name when opening the device.  If you don't specify a subdevice
number, the default is -1 which means "pick the first free one".


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
