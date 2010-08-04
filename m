From: David Henningsson <david.henningsson@canonical.com>
Subject: Muting of the "Front" mixer control
Date: Wed, 04 Aug 2010 16:42:50 +0200
Message-ID: <4C597C6A.3070300@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 82FDE10387D
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Aug 2010 16:42:53 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1OgfBE-0002xU-Vu
	for <alsa-devel@alsa-project.org>; Wed, 04 Aug 2010 15:42:53 +0100
Received: from [88.83.60.91] (helo=[192.168.8.103])
	by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1OgfBE-0003Z1-SL
	for alsa-devel@alsa-project.org; Wed, 04 Aug 2010 15:42:52 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Here's an interesting problem which I'm not sure whether it should be
fixed in PulseAudio or the driver, but I'm starting here.

I have a laptop with a HDA VIA VT1708 chip and would like auto-muting.
VIA advertises auto-muting by changing the "Front Playback Switch" (see
sound/pci/hda/patch_via.c:2023, via_hp_automute).

Now PulseAudio's default mixer path, "analog-output", treats "Front" as
part of the volume merge chain, which in this case is incorrect, and so
when the switch gets muted, PA thinks that the chain is muted and gets
confused (as in: no sound output, and PA advertises to g-v-c and others
that it is now muted).

It seems to me like from PA's perspective the name should have been
"Speaker Playback Switch" instead, but VIA does not seem to use
"Speaker" at all, and BIOS seems to have set up my caps for Speaker as
"Line out", so I'm not sure if this is the right way to do it.

For reference, here's my alsa-info:
http://launchpadlibrarian.net/53047763/alsa-info.txt.JUhgxH8rDZ

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
