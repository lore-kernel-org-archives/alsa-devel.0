From: Phil Gorbett <pgorbett@usc.edu.au>
Subject: DELL SP2309W Monitor with Integrated microphone
Date: Sat, 11 Apr 2009 10:50:42 +1000
Message-ID: <1239411042.15067.41.camel@sundance.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail10.syd.optusnet.com.au (mail10.syd.optusnet.com.au
	[211.29.132.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 73BCA24345
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Apr 2009 02:50:47 +0200 (CEST)
Received: from [220.236.219.124] (d220-236-219-124.dsl.nsw.optusnet.com.au
	[220.236.219.124])
	by mail10.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id
	n3B0oh4P016512
	for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2009 10:50:44 +1000
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

Any luck anyone with this one yet?  I too have the same issue as that
posted previously (last month), and get the same results with the
indicative testing.  I have tried several fixes via googling - module
loading and sound "card" indexing via alsa.base modprobe file and LOTS
of others.  Still no luck.  I am running FC10 with pulse, but think it's
probably a snd-usb-audio problem as the driver appears to be correctly
loading and the webcam is clearly indicated in the sound prefs app and
gconf/gstreamer.  I have run thru the usb audio device classes, and all
of the reported class values reported via lsusb -v seem to correctly
correspond to possible values from the audio class parameters.  I'm now
stumped.  I do get the following errors in the gnome sound recorder:
"Could not negotiate format" followed by "Could not get/set settings
from/on resource.". This jives with the error from the sound preference
panel: "gconfaudiosrc ! audioconvert ! audioresample ! gconfaudiosink
profile=chat: Could not get/set settings from/on resource." which does
not reveal anything specific enough to track down the problem from
searching the net.  All other sound devices and services are performing
correctly via pulseaudio.  I have at one time removed p/a, but this did
not correct the problem.  I am running the webcam mic as device 0, but
changing that to any other device number fails to solve the problem.
Alsamixer shows the card "Monitor Webcam" mic, the chip "USB mixer", the
recording levels at 74, the capture enabled, and the AGC and loudness
parameters enabled, and although I have tried various combinations of
these, none have worked.

I am running version 1.0.19 of the alsa drivers, and compiled these
directly with all everything enabled as well as using the rpm builds.
Alsainfo has been uploaded to:


http://www.alsa-project.org/db/?f=803829378929c58bcc86351c091719a12c79075e


The video portion of the camera functions entirely correctly via uvc and
v4l, but the audio listing from the video test app gucveiw does not list
the webcam mic at all under the audio device list.  The uvc dev group
sent me here, naturally.

Cheers,
PG
