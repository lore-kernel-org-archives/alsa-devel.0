From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Compile errors with latest alsa releases
Date: Mon, 23 Feb 2004 18:49:50 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402231847520.18260-100000@studcom.urz.uni-halle.de>
References: <403632BC.20308@comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <403632BC.20308@comcast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: snookertb <snookertb@comcast.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

snookertb wrote:
> I am attempting to update the Sun JDS distro from alsa version 0.9.0 to
> a later version which supports newer Intel sound chips. I get the
> following errors in these two compiles.
>
> /home/tarpon/downloads/alsa-driver-1.0.2c/include/adriver.h:295:
> redefinition of `usb_make_path'

This is a function which doesn't exist in older 2.4 kernels, so ALSA
defines its own version.  It seems Sun backported some USB stuff from
a newer kernel.

Try to uncomment this function in adriver.h.


HTH
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
