From: Stephen Hassard <steve=2aNvSAj8LErR7s880joybQ@public.gmane.org>
Subject: Re: [linux-audio-user] M-Audio MobilePre/Sonica/Transit/Ozone testers wanted
Date: Sat, 20 Sep 2003 08:38:26 -0700
Sender: linux-audio-dev-admin=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Message-ID: <20030920153826.GA29033@www.angiotech.com>
References: <Pine.HPX.4.33n.0309091119290.5853-100000@studcom.urz.uni-halle.de>
Reply-To: linux-audio-dev=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-audio-dev-admin@music.columbia.edu>
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0309091119290.5853-100000@studcom.urz.uni-halle.de>
Errors-To: linux-audio-dev-admin@music.columbia.edu
List-Help: <mailto:linux-audio-dev-request@music.columbia.edu?subject=help>
List-Post: <mailto:linux-audio-dev@music.columbia.edu>
List-Subscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request@music.columbia.edu?subject=subscribe>
List-Unsubscribe: <http://music.columbia.edu/mailman/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request@music.columbia.edu?subject=unsubscribe>
List-Archive: <http://music.columbia.edu/pipermail/linux-audio-dev/>
To: Clemens Ladisch <clemens=P6GI/4k7KOmELgA04lAiVw@public.gmane.org>
Cc: usb-midi-fw-user=5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, alsa-devel=5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-audio-dev=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org, linux-audio-user=oG0YroN0ZiqENrSoib9kfje48wsgrGvP@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hey Clemens,

I just tried out the madfu loader with my Sonica and ran into a problem.

usbfs is mounted on /proc/bus/usb

lsusb shows:
Bus 002 Device 003: ID 0763:2805 Midiman

I tried running:
./madfuload -f ma005101.bin -n -D /proc/bus/usb/002/003
and I get:
downloading block 1 failed - No such file or directory

It's definitely finding /proc/bus/usb/002/003, and if I point to a non-existant file I get:
cannot open /foo - No such file or directory

I get the same error if I point it at a non-existant firmware.

I'm running everything as root, running a 2.6.0-test5 kernel.

Anything else I should try?

Thanks,
Stephen Hassard

On Tue, Sep 09, 2003 at 11:21:46AM +0200, Clemens Ladisch wrote:
> 
> The M-Audio MobilePre/Sonica/Transit/Ozone devices need a firmware
> download before they can be used with Linux.
> 
> I've released a first beta of the madfu-firmware package which tries
> to accomplish this.
> 
> Please note that I do not have any of these devices, and that the
> loader is not tested at all. That's why I'm searching for volunteers.
> :-)
> 
> To download the beta, go to
> http://sourceforge.net/project/showfiles.php?group_id=87777&release_id=183375
> 
> Please send any success/failure reports to
> usb-midi-fw-user=TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
> 
> 
> Regards,
> Clemens
> 
> 
