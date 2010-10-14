From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 17:43:08 +0200
Message-ID: <201010141743.08662.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141358.27706.julian@jusst.de>
	<1287070099.2975.19.camel@laptop-alex>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 521CC2414D
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 17:43:10 +0200 (CEST)
Received: from [127.0.0.1] (helo=juli-workstation.localnet)
	by smtp2.work.de with esmtpa (Exim 4.69)
	(envelope-from <julian@jusst.de>) id 1P6PxV-0006HF-Jd
	for alsa-devel@alsa-project.org; Thu, 14 Oct 2010 17:43:09 +0200
In-Reply-To: <1287070099.2975.19.camel@laptop-alex>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 14. Oktober 2010, 17:28:19 schrieb Alex Lee:
> On Thu, 2010-10-14 at 13:58 +0200, Julian Scheel wrote:
> > One more question on the feedback: In your project you fo 10.14 for Full
> > Speed devices (which mine is - the AT91SAM7A3 can't do High Speed) and
> > 12.13 for highspeed. Why do you distinguish that way? Is your device
> > initialised in High Speed mode whenever it's connected to a Linux host?
> 
> I started off with the assumption that with UAC1 in FS, the specs says
> 10.14.  However, I'm running the widget in HS (but still UAC1), so
> according to USB2.0 spec, the ISO feedback should be in 16.16 format.
> Later I found out that Linux uses 12.13 (for whatever reasons), so I
> changed the HS format to 12.13, leaving the FS format at 10.14.

Ah ok, I see...
Linux uses 12.13 in any case though? (Without the new patch of course)

> My project uses the AT32UC3A3, which can operate it both HS and FS.  So
> it can enumerate to be either a HS or a FS device depending on the PC/
> USB Hub's capabilities.  So the firmware has to cater to both cases.  We
> are also doing compatibility testing with Vista and Win7 (WinXP does not
> support rate feedback).  So we need to test HS and FS as well.  OSX can
> accept either 10.14 or 16.16 format, depending on whether the firmware
> sends it 3 bytes or 4 bytes in the feedback pipe, so it will work with
> FS or HS.

Ok, being compatible with al OSes seems to be a non-trivial task...

> We are also developing a version of the firmware for UAC2.  So we will
> have to figure out what format to use for UAC2 as well - most likely
> 16.16.  However, for Linux, we will need to wait for Clemens' patch to
> reach the distributions.  btw, there are other bugs in the alsa UAC2
> driver that Daniel has fixed, but the patches are not in the 2.6.35
> kernel - probably in 2.6.36 or 2.6.37.  So currently we have workarounds
> in the widget firmware for UAC2.

Good to know. So far I only do UAC1, but for 192kHz I will have to switch to 
UAC2... May I come back to you with some questions about UAC2 then?

> There are other incompatibilities as well.  For example, my current UAC1
> firmware has workable mute controls when running in Windows.  But in
> Linux, alsamixer cannot interpret the mute/volume controls.  The UAC2
> controls are interpreted correctly by alsamixer, though.

Odd... I only have one control so far, a PCM mute control... That one seems to 
work well in Linux.

> I looked at your scope traces.  DATA seems to be valid at the falling
> edges of SCLK.  According to i2S specs, they are supposed to be valid at
> the rising edges.  The relationship between LRCK and DATA looks OK (ie
> one SCLK delay from the LRCK edge), though.

Ok, fixed both issues. Uploaded a new capture:
http://jusst.de/files/i2s_plot2.png
This seems to be ok for what I can say... Do you agree?

> Do you get any analog output at all from the DAC?  Any noise at all?

Actually the module has a constant DC voltage of between 1.2 V on R+, 1.4 V on 
L+ outputs and between 2.2 V on R- and 2.6V on L- output....
Which actually is really odd as the I/V stage has DC block capacitors in it... 
This is the schematic of the DAC module: 
http://www.twistedpearaudio.com/docs/digital/cod_schematic.pdf

Regards,
Julian
