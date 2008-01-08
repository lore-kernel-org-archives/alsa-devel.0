From: John Stile <john@stilen.com>
Subject: Re:
	snd-hda-intel	support	for	SPDIF-in	wiht	vt1708	card?
Date: Tue, 08 Jan 2008 08:38:48 -0800
Message-ID: <1199810328.10421.55.camel@genx.localdomain>
References: <010720081840.4095.47827221000A2BAB00000FFF220702455305029A06039A9D0100@comcast.net>
	<1199777722.10421.29.camel@genx.localdomain>
	<s5hejcs931e.wl%tiwai@suse.de>
	<1199780495.10421.32.camel@genx.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mother.stilen.com (dsl027-182-089.sfo1.dsl.speakeasy.net
	[216.27.182.89]) by alsa0.perex.cz (Postfix) with ESMTP id DCED024B37
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 17:38:50 +0100 (CET)
In-Reply-To: <1199780495.10421.32.camel@genx.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Darryl House <forumjunk@comcast.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2008-01-08 at 00:21 -0800, John Stile wrote:
> On Tue, 2008-01-08 at 08:42 +0100, Takashi Iwai wrote: 
> > Do you have any ~/.asoundrc or /etc/asound.conf or whatever?
> > Remove this once.
> > 
> I had a /etc/conf.d/alsasound which I removed, but no ~/.asoundrc
> or /etc/asound.conf.
Thank you for all this help.

Is the problem with recording digital-in because both digital and analog
capture devices have the same identity (i.e. both are hw:0,1)?

Below, /proc/asound/card0/pcm1c/info is the digtial capture device, but
can it be referenced via a '-D' parameter to arecord.

cat /proc/asound/cards
 0 [VT82xx         ]: HDA-Intel - HDA VIA VT82xx
                      HDA VIA VT82xx at 0x9fffc000 irq 20
cat /proc/asound/devices
  0: [ 0]   : control
  1:        : sequencer
  4: [ 0- 0]: hardware dependent
 16: [ 0- 0]: digital audio playback
 17: [ 0- 1]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 33:        : timer
cat /proc/asound/pcm
  00-01: VT1708 Digital : VT1708 Digital : playback 1 : capture 1
  00-00: VT1708 Analog : VT1708 Analog : playback 1 : capture 2

NOTE: I don't see a pcm device i can play from

ls -alF /proc/asound/card0
   total 0
   dr-xr-xr-x 6 root root 0 Jan  8 08:23 ./
   dr-xr-xr-x 5 root root 0 Jan  8 08:19 ../
   -r--r--r-- 1 root root 0 Jan  8 08:23 codec#0
   -r--r--r-- 1 root root 0 Jan  8 08:23 id
   -rw-r--r-- 1 root root 0 Jan  8 08:23 oss_mixer
   dr-xr-xr-x 4 root root 0 Jan  8 08:23 pcm0c/
   dr-xr-xr-x 3 root root 0 Jan  8 08:23 pcm0p/
   dr-xr-xr-x 3 root root 0 Jan  8 08:23 pcm1c/
   dr-xr-xr-x 3 root root 0 Jan  8 08:23 pcm1p/

I need to reference either pcm0c or pcm1c, I think.
cat pcm1c/info
   card: 0
   device: 1
   subdevice: 0
   stream: CAPTURE
   id: VT1708 Digital
   name: VT1708 Digital
   subname: subdevice #0
   class: 0
   subclass: 0
   subdevices_count: 1
   subdevices_avail: 1

This is the analog capture device:
cat /proc/asound/card0/pcm0c/info
   card: 0
   device: 0
   subdevice: 0
   stream: CAPTURE
   id: VT1708 Analog
   name: VT1708 Analog
   subname: subdevice #0
   class: 0
   subclass: 0
   subdevices_count: 2
   subdevices_avail: 2

This is the digital capture device:
cat /proc/asound/card0/pcm1c/info
   card: 0
   device: 1
   subdevice: 0
   stream: CAPTURE
   id: VT1708 Digital
   name: VT1708 Digital
   subname: subdevice #0
   class: 0
   subclass: 0
   subdevices_count: 1
   subdevices_avail: 1
