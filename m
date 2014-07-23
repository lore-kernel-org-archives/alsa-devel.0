From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: A report about an enhancement for ALSA firewire stack
Date: Wed, 23 Jul 2014 18:17:18 +0900
Message-ID: <53CF7D9E.2050908@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ffado-devel@lists.sf.net" <ffado-devel@lists.sf.net>, JACK <jack-devel@lists.jackaudio.org>, linux1394-devel@lists.sourceforge.net, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
Cc: Maximilian Engelhardt <maxi@daemonizer.de>, Daniel Wagner <wagi@monom.org>, Darren Anderson <darrena092@gmail.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Dear all,

My work for ALSA firewire stack was pulled into Linux 3.16, therefore
Linux 3.16 newly supports 60-70 firewire sound devices. The work may
affects user-space applications such like FFADO. Additionally, I leave
some issues for the stack.

So I wrote a report about my work.

PDF:
https://github.com/takaswie/alsa-firewire-report/blob/master/firewire.pdf

Repository:
https://github.com/takaswie/alsa-firewire-report

Table of contents
 1. Introduction
 2. Common Specifications
 3. Device features
 4. Existing drivers
 5. Investigation for user-land driver
 6. Investigation for kernel-land driver
 7. Enhancement of ALSA firewire stack
 8. Driver implementation
 9. Rest of issue

I hope ALSA maintainers to read section 8 and 9.

For FFADO developers, section 3, 5, 8 will be good information.

For JACK/PulseAudio and Linux firewire subsystem developers, section 4,
5, 6, 7, 9 will be good information.

I'm not a good English writer and have a little experiences to write
technical documents. It's my glad to receive some corrections,
indications, supplements and so on from you.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
