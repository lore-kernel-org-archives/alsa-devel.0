From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [ALSA - driver 0000955]: CN-126 - USB 5.1 Audio
 adapter
Date: Thu, 3 Mar 2005 12:35:06 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503031232110.20007-100000@studcom.urz.uni-halle.de>
References: <1109842477.13896.32.camel@ghanima>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1109842477.13896.32.camel@ghanima>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fruhwirth Clemens wrote:
> My USB audio class device doesn't show all mixer controls in ALSA.
> For reference, for other users searching this archive, it's a "Creative
> USB Sound Blaster Live! 24-bit External".
> ...
> I wonder why the snd_usb_create_mixer code does only loop over the
> OUTPUT_TERMINAL class,

Because all other units are (indirectly) connected to an output
terminal.  We get them when we recursively inspect the respective
source units.

> My aim is to have controls available for the Line-in mixer, both for
> recording and for direct re-mixing into the Main Out Plug.

Your device probably doesn't have such controls.  What is the output
of "lsusb -v" for it?


Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
