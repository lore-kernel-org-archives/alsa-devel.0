From: Carlos Pita <carlosjosepita@yahoo.com.ar>
Subject: oss raw midi emulation
Date: Sun, 28 Nov 2004 12:14:24 -0300
Message-ID: <200411281214.24321.carlosjosepita@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp206.mail.sc5.yahoo.com (smtp206.mail.sc5.yahoo.com [216.136.129.96])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 53C021E7
	for <alsa-devel@alsa-project.org>; Sun, 28 Nov 2004 16:10:33 +0100 (MET)
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

What should be /dev/midi??   ?
Symlimks to /dev/snd/midiC?D?  ?
Or devices with the correct major/minor numbers specified by the oss manual ?

I'm asking because I need to use snd-virmidi in order to connect pd (which has no support
for alsa midi yet) with muse or vkeybd. So I'm doing:

> modprobe snd-virmidi
> cat /proc/asound/devices
  [...]
  43: [1- 3]: raw midi
  42: [1- 2]: raw midi
  41: [1- 1]: raw midi
  40: [1- 0]: raw midi
> ln -s /dev/snd/midiC1D0 /dev/midi10
> pd -midiindev 11
(with -midiindev N,  pd will open /dev/midiM with M=N-1, just a quirk)
Then I aconnect muse or vkeybd to alsa client VirMIDI 1-0.

It works fine, but is this the right way to do it? For me it was
a matter of trial and error.

Also, debian sarge predefines the following four devices:

crw-rw----  1 root audio 14,  2 2004-10-26 21:40 /dev/midi00
crw-rw----  1 root audio 14, 18 2004-10-26 21:40 /dev/midi01
crw-rw----  1 root audio 14, 34 2004-10-26 21:40 /dev/midi02
crw-rw----  1 root audio 14, 50 2004-10-26 21:40 /dev/midi03

which suggests that /dev/midi?? shouldn't be symlinked as I'm
doing with /dev/midi10.

Thank you.
Regards,
Carlos


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
