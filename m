From: Hartmut Geissbauer <nwgbh@swissonline.ch>
Subject: Re: [fixed] snd-usb-audio and midisport1x1 little
	hack fixes hotplug pb
Date: Tue, 23 Mar 2004 19:24:19 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1080066259.2406.1.camel@chief.local>
References: <Pine.HPX.4.33n.0403170857070.10179-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0403170857070.10179-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> Apparently, snd_usb_audio_disconnect is called recursively, caused by
> the call to usb_driver_release_interface, and then deadlocks.
> 
> The USB core will release all interfaces automatically, so we don't
> need this call.  Please remove the usb_driver_release_interface line.

Sorry, in case of your're awaiting any response. It works.

Regards, Hartmut



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
