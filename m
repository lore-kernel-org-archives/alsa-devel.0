From: Patrick Shirkey <kotau@firstlinux.net>
Subject: Re: [ANNOUNCE] USB MIDI support for ALSA
Date: Tue, 14 May 2002 20:11:04 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020515031105.1BD8D2757@sitemail.everyone.net>
Reply-To: pshirkey@boosthardware.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from omta01.mta.everyone.net (sitemail3.everyone.net [216.200.145.37])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id FAA06005
	for <alsa-devel@alsa-project.org>; Wed, 15 May 2002 05:11:21 +0200
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: linux-usb-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm starting to wonder if it isn't better to write native ALSA support into the usb audio driver. Currently it does this with OSS so why not just add ALSA to it and be done with it?

Surely that is the easiest approach. The only reason I see against it is latency requirements are better served by having ALSA connect to usb instead of usb connect to ALSA. 

--
Patrick Shirkey - Boost Hardware Ltd
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/


--- Takashi Iwai <tiwai@suse.de> wrote:
>At Tue, 14 May 2002 09:08:29 -0400,
>Paul Davis wrote:
>> 
>> >> I've written a daemon which connects the ALSA sequencer with the
>> >> usbdevfs device file of a USB MIDI device. You can get it at
>> >> <http://www.informatik.uni-halle.de/~ladischc/usbmidid.html>.
>> >> 
>> >> It requires a kernel with USB and usbdevfs support (obviously), and
>> >> with hotplugging support and hotplugging scripts installed correctly.
>> >
>> >great!
>> >
>> >it's a very clean solution.  definitely the right way for usb midi,
>> >rather than writing a driver module for each.
>> 
>> it is? isn't the right way to redirect into USB-aware code within
>> alsa-lib? going through a daemon seems totally wrong to me ...
>
>i agree that the library-plugin would be fine and effective, but it's
>only if a single application shares the device.  then the device
>end-point is directly bound to the application.
>
>however, when two applications access to the device (or when arbitrary
>connection is allowed), then the situation would be complicated.
>there must be an end-point mixer before the device output.
>i think the daemon is the easiest way to be implemented on behalf of
>kernel driver.
>
>
>Takashi
>
>_______________________________________________________________
>
>Have big pipes? SourceForge.net is looking for download mirrors. We supply
>the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel

_____________________________________________________________
Want a new web-based email account ? ---> http://www.firstlinux.net

_____________________________________________________________
Promote your group and strengthen ties to your members with email@yourgroup.org by Everyone.net  http://www.everyone.net/?btn=tag

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
