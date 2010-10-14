From: Alex Lee <lee188@singnet.com.sg>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 23:28:19 +0800
Message-ID: <1287070099.2975.19.camel@laptop-alex>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<20101014104855.GI10432@buzzloop.caiaq.de>
	<3879AFD1-61E6-47FB-8ECB-8A7D7B233B3B@singnet.com.sg>
	<201010141358.27706.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp41.singnet.com.sg (smtp41.singnet.com.sg [165.21.103.142])
	by alsa0.perex.cz (Postfix) with ESMTP id CAC19103B1D
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 17:28:24 +0200 (CEST)
In-Reply-To: <201010141358.27706.julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-10-14 at 13:58 +0200, Julian Scheel wrote:
> 
> One more question on the feedback: In your project you fo 10.14 for Full Speed 
> devices (which mine is - the AT91SAM7A3 can't do High Speed) and 12.13 for 
> highspeed. Why do you distinguish that way? Is your device initialised in High 
> Speed mode whenever it's connected to a Linux host?
> 

I started off with the assumption that with UAC1 in FS, the specs says
10.14.  However, I'm running the widget in HS (but still UAC1), so
according to USB2.0 spec, the ISO feedback should be in 16.16 format.
Later I found out that Linux uses 12.13 (for whatever reasons), so I
changed the HS format to 12.13, leaving the FS format at 10.14.

My project uses the AT32UC3A3, which can operate it both HS and FS.  So
it can enumerate to be either a HS or a FS device depending on the PC/
USB Hub's capabilities.  So the firmware has to cater to both cases.  We
are also doing compatibility testing with Vista and Win7 (WinXP does not
support rate feedback).  So we need to test HS and FS as well.  OSX can
accept either 10.14 or 16.16 format, depending on whether the firmware
sends it 3 bytes or 4 bytes in the feedback pipe, so it will work with
FS or HS.

We are also developing a version of the firmware for UAC2.  So we will
have to figure out what format to use for UAC2 as well - most likely
16.16.  However, for Linux, we will need to wait for Clemens' patch to
reach the distributions.  btw, there are other bugs in the alsa UAC2
driver that Daniel has fixed, but the patches are not in the 2.6.35
kernel - probably in 2.6.36 or 2.6.37.  So currently we have workarounds
in the widget firmware for UAC2.

There are other incompatibilities as well.  For example, my current UAC1
firmware has workable mute controls when running in Windows.  But in
Linux, alsamixer cannot interpret the mute/volume controls.  The UAC2
controls are interpreted correctly by alsamixer, though.

I looked at your scope traces.  DATA seems to be valid at the falling
edges of SCLK.  According to i2S specs, they are supposed to be valid at
the rising edges.  The relationship between LRCK and DATA looks OK (ie
one SCLK delay from the LRCK edge), though.

Do you get any analog output at all from the DAC?  Any noise at all?

Alex
