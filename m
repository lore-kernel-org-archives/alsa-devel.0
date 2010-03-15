From: Dan Armbrust <daniel.armbrust.list@gmail.com>
Subject: Configuration help please?
Date: Mon, 15 Mar 2010 09:11:35 -0500
Message-ID: <82f04dc41003150711m53b675f6g59c54d142cca77b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 91ACD10380D
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 15:11:37 +0100 (CET)
Received: by bwz20 with SMTP id 20so8257336bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 07:11:35 -0700 (PDT)
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

Hi,

I'm trying to configure a mythtv box to send sound to my spdif port
AND my analog stereo speakers.

In order to make the spdif port work, I found I needed this in /etc/asound.conf:


#----
pcm.!default {
    type plug
    slave.pcm "spdif"
 }

#----

I thought maybe this would work to send the sound to both....

#----
pcm.!default {
    type plug
    slave.pcm "front"
    slave.pcm "spdif"
 }
#----

But that was a little naive... apparently.  The sound just goes to
whichever item I put last.

I know right next to nothing about writing alsa config files... and
every example I find is very large, very complicated looking, and
doesn't do what I want.

Can someone tell me how to configure alsa for this?

What I want - exactly - Sound to always go to both the "front" (my 2
channel stereo speakers), and my spdif output, with anywhere between 1
and 5.1 channels... depending on what my source audio has.  I also
want mythtv to pass the full 5.1 channels from HD to the spdif port,
while sending the stereo sound to the analog.

Some info:

# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC888 Analog [ALC888 Analog]
 Subdevices: 1/1
 Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC888 Digital [ALC888 Digital]
 Subdevices: 0/1
 Subdevice #0: subdevice #0


#aplay -L
front:CARD=Intel,DEV=0
   HDA Intel, ALC888 Analog
   Front speakers
surround40:CARD=Intel,DEV=0
   HDA Intel, ALC888 Analog
   4.0 Surround output to Front and Rear speakers
surround41:CARD=Intel,DEV=0
   HDA Intel, ALC888 Analog
   4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Intel,DEV=0
   HDA Intel, ALC888 Analog
   5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Intel,DEV=0
   HDA Intel, ALC888 Analog
   5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Intel,DEV=0
   HDA Intel, ALC888 Analog
   7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Intel,DEV=0
   HDA Intel, ALC888 Digital
   IEC958 (S/PDIF) Digital Audio Output
null
   Discard all samples (playback) or generate zero samples (capture)


Thanks!

Dan
