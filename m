From: snookertb <snookertb@comcast.net>
Subject: Re: Compile errors with latest alsa releases
Date: Mon, 23 Feb 2004 13:59:53 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403A4DA9.8010408@comcast.net>
References: <Pine.HPX.4.33n.0402231847520.18260-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0402231847520.18260-100000@studcom.urz.uni-halle.de>
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

Thanks for responding. I had just about given up ...

Clemens Ladisch wrote:
> snookertb wrote:
> 
>>I am attempting to update the Sun JDS distro from alsa version 0.9.0 to
>>a later version which supports newer Intel sound chips. I get the
>>following errors in these two compiles.
>>
>>/home/tarpon/downloads/alsa-driver-1.0.2c/include/adriver.h:295:
>>redefinition of `usb_make_path'
> 
> 
> This is a function which doesn't exist in older 2.4 kernels, so ALSA
> defines its own version.  It seems Sun backported some USB stuff from
> a newer kernel.
> 
> Try to uncomment this function in adriver.h.

I commented out the function definition of usb_make_path() in the alsa-driver-xxx adriver.h file and now it compiles without errors. Since usb_make_path() is wrapped in a kernel version it probably is true that Sun back ported some of the usb functionality.

SND_CTL_READONLY does not appear to be declared anywhere. I assume that this is also a function of new kernels, or Sun's implementation, and if I added the declaration to the alsa-utils-xxx somewhere it would be proper. Where should the declaration go? Any idea how to get the proper values?

Are you part of the alsa development team?

tb



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
