From: Carlos Pita <carlosjosepita@yahoo.com.ar>
Subject: virmidi, hotplug and udev
Date: Sun, 28 Nov 2004 18:51:29 -0300
Message-ID: <200411281851.29845.carlosjosepita@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp203.mail.sc5.yahoo.com (smtp203.mail.sc5.yahoo.com [216.136.129.93])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 49F49297
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2004 22:47:40 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

I'm using kernel 2.6.8 with hotplug enabled and udev
(distro: debian sarge).

I need to use the snd-virmidi to create a virtual sound card
with its raw midi devices.

I do:
  modprobe snd-virmidi

Does this generate a hotplug event? Or at least an udev event?

I ask it because here the order is somewhat inverted. Normally
a device is cold/hot plugged and modprobe is run in
response to a subsequent hotplug event. But here the device is
added as the effect of a previous modprobe. One thing I see
is that modprobe would be retried as part of the event processing,
that's innocuous but ugly.

Finally, do you know how to write the udev rules to generate
the OSS raw midi devices. Currently, the only rules related
to ALSA in my /etc/udev/rules.d/udev.rules are:

# ALSA devices
KERNEL="controlC[0-9]*", NAME="snd/%k"
KERNEL="hw[CD0-9]*",    NAME="snd/%k"
KERNEL="pcm[CD0-9cp]*", NAME="snd/%k"
KERNEL="midi[CD0-9]*",  NAME="snd/%k"
KERNEL="timer",         NAME="snd/%k"
KERNEL="seq",           NAME="snd/%k"

Most of the OSS devices are generated at boot time by
udevstart. But /dev/midi10.../dev/midi13 are missing after
modprobing snd-virmidi.

Thank you in advance.
Regards,
Carlos


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
