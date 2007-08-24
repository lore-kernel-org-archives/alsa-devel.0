From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: please test the beta CMI8788 driver
Date: Fri, 24 Aug 2007 16:19:56 +0200
Message-ID: <1187965196.14935.1207097713@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 6DEA810388B
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Aug 2007 16:19:58 +0200 (CEST)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B741623429
	for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2007 10:19:56 -0400 (EDT)
Content-Disposition: inline
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

If you have a card based on the C-Media CMI8788 chip (Asound A-8788,
Asus Xonar D2, Auzentech X-Meridian, Bgears b-Enspirer, Club3D
Theatron DTS, HTOmega Claro, Razer Barracuda AC-1, or Sondigo Inferno),
please help testing the new snd-cmi8788 driver.

To test it, get the source from the Hg repository, or download this
beta package:
http://www.informatik.uni-halle.de/~ladischc/alsa-driver-1.0.14-cl1.tar.bz2

To compile, run "./configure", then "make", then, as root,
"make install-modules".  (If you don't want to compile all the other
drivers, use "./configure --with-cards=cmi8788" instead.)

What should work:
* analog playback (2/4/6/8 channels) and capture
* digital playback/capture (device name "plughw:CMI8788,1")
* all sample rates (32-192 kHz)
Not yet implemented:
* front panel playback/capture
* capture source selection
* SPDIF controls (for AC-3, copyright bit etc.)
* MIDI
Known bugs:
* PCM volume on Asus Xonar doesn't work
Unknown bugs:
* That's for you to find out!


I'm not sure about the channel order.  Please try
        speaker-test -D hw:CMI8788,0 -c 8 -t wav
and report if it works correctly.


*WARNING*: I don't have the hardware; I cannot run this driver myself.
It's quite possible that it crashes your computer or that it causes the
speakers to fall onto your cat.  ;-)


Clemens
