From: Paul Davis <pbd@op.net>
Subject: Re: Fwd: Re: USB Quattro Linux support
Date: Mon, 15 Apr 2002 09:30:31 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E16x6Xa-0005ci-00@usw-sf-list1.sourceforge.net>
References: <20020415124905.C37D73ECC@sitemail.everyone.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Mon, 15 Apr 2002 05:49:05 PDT."
             <20020415124905.C37D73ECC@sitemail.everyone.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: pshirkey@boosthardware.com
Cc: James Tappin <sjt@star.sr.bham.ac.uk>, linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>>I think a more exact description of the gphoto approach is:
>>application<->gphoto-lib<->usb-lib<->low-level-generic-USB driver.
>>
>>Only the low-level kernel USB drivers and the usbdevfs filesystem are in 
>>kernel space, beyond that the hardware driving is done via the user-space 
>>libusb. I'm not sure whether this would have low-enough latency for audio 
>>use, after all, digital cameras aren't timing-critical for the sort of things
>>that gphoto aims to do.

If usb-lib is written properly and low-level-generic-USB-driver is
written correctly, there are no latency issues. Latency issues don't
arise from the number of layers of code unless one of the layers of
code is astonishingly badly written. They arise from designs that
buffer data along the way or delay execution of a thread. The system
outlined above doesn't inherently have any such problems.

>I think that there is support in gphoto for capturing video streams but I have
>n't used it so I don't know if that is correct. Anyway if I am correct then la
>tency issues would have been solved already.

Not at all. arecord(1) can capture audio, but it can't capture 26
channels of audio at 64 frames/interrupt. Handling latency is partly
an application issue, partly a kernel issue, and partly a requirement
that libraries in the way don't get in the way. It has very little to
do with whether you can do certain generic tasks or not.

--p
