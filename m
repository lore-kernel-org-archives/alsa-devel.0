From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Fri, 15 Oct 2010 19:19:41 +0200
Message-ID: <201010151919.41810.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<1287153698.3730.7.camel@laptop-alex>
	<201010151916.26003.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id C71CA1038C1
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 19:19:43 +0200 (CEST)
In-Reply-To: <201010151916.26003.julian@jusst.de>
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
Cc: Alex Lee <lee188@singnet.com.sg>, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Am Freitag, 15. Oktober 2010, 19:16:25 schrieb Julian Scheel:
> Am Freitag, 15. Oktober 2010, 16:41:38 schrieb Alex Lee:
> > On Fri, 2010-10-15 at 16:24 +0200, Julian Scheel wrote:
> > > Don't see any syncpipe related errors. Only thing I see is:
> > > usb 1-1.3: new full speed USB device using ehci_hcd and address 11
> > > 11:1:1: endpoint lacks sample rate attribute bit, cannot set.
> > > 11:1:1: endpoint lacks sample rate attribute bit, cannot set.
> > > 
> > > Does not seem to be feedback related... Although it would be nice to
> > > know, what's wrong there?
> > 
> > You probably need to fix that sample rate attribute bit for rate
> > feedback to work.
> > 
> > It is in the bmAttribute of the
> > 
> > 	//Audio endpoint specific descriptor
> > 
> > #define AUDIO_EP_ATRIBUTES	UAC_EP_CS_ATTR_SAMPLE_RATE	 // sampling freq,
> > no pitch, no pading
> > 
> > #define AUDIO_EP_DELAY_UNIT	0x00	 	// Unused
> > #define AUDIO_EP_LOCK_DELAY	0x0000		// Unused
> 
> You mean in the class specific endpoint descriptor for the audio streaming
> endpoint?
> Actually I added it there (bmAttributes = 0x01), but this stops alsa from
> detecting the device at all. Attaches is the new lsusb out.

Correcting myself. It detects the card, but playback is not possible anymore:

LC_ALL=en speaker-test -Dusb -c 2 -t sine -f 1000

speaker-test 1.0.23

Playback device is usb
Stream parameters are 48000Hz, S16_LE, 2 channels
Sine wave rate is 1000.0000Hz
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 96 to 262144
Period size range from 48 to 131072
Using max buffer size 262144
Periods = 4
Unable to set hw params for playback: Broken pipe
Setting of hwparams failed: Broken pipe

Is this a hint to not-working feedback? (c:
