From: Paul Davis <pbd@op.net>
Subject: Re: [ANNOUNCE] USB MIDI support for ALSA
Date: Tue, 14 May 2002 09:08:29 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205141307.PAA25858@alsa.alsa-project.org>
References: <s5h3cwv85k7.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA25858
	for <alsa-devel@alsa-project.org>; Tue, 14 May 2002 15:07:18 +0200
In-Reply-To: Your message of "Tue, 14 May 2002 11:03:20 +0200."
             <s5h3cwv85k7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> I've written a daemon which connects the ALSA sequencer with the
>> usbdevfs device file of a USB MIDI device. You can get it at
>> <http://www.informatik.uni-halle.de/~ladischc/usbmidid.html>.
>> 
>> It requires a kernel with USB and usbdevfs support (obviously), and
>> with hotplugging support and hotplugging scripts installed correctly.
>
>great!
>
>it's a very clean solution.  definitely the right way for usb midi,
>rather than writing a driver module for each.

it is? isn't the right way to redirect into USB-aware code within
alsa-lib? going through a daemon seems totally wrong to me ...

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
