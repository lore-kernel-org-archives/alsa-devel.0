From: David Henningsson <launchpad.web@epost.diwic.se>
Subject: snd_device_name_hint problems
Date: Fri, 11 Sep 2009 11:45:47 +0200
Message-ID: <4AAA1C4B.5000806@epost.diwic.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp02.sth.basefarm.net (ch-smtp02.sth.basefarm.net
	[80.76.149.213]) by alsa0.perex.cz (Postfix) with ESMTP id CEBF7245EE
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 11:46:17 +0200 (CEST)
Received: from c83-254-134-5.bredband.comhem.se ([83.254.134.5]:55171
	helo=[192.168.0.200])
	by ch-smtp02.sth.basefarm.net with esmtp (Exim 4.68)
	(envelope-from <launchpad.web@epost.diwic.se>) id 1Mm2hR-0001GV-9R
	for alsa-devel@alsa-project.org; Fri, 11 Sep 2009 11:45:51 +0200
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

Hello,

First; I'm not completely sure how much of this is your issue, and how
much is my distribution's fault (Ubuntu). If you believe my problems is
due to bugs in the distribution, please say so.

I'm working with a small recording application and I want to enumerate
possible recording sources/devices, just to put in a combobox. In my
computer I have two soundcards, one on the motherboard and one PCI
soundcard (ESI Juli@). I also have Pulseaudio installed, so the devices
I want to show up are those three - and possibly alternatives under
these, such as analog/digital inputs.

According to Lennart's guide to sound API's, snd_device_name_hint is the
way to go, as both snd_card_xxx and snd_config_xxx are deprecated.
(Speak up if you don't agree.)

So assuming I do about the same as "arecord -L" does, I get the
following output (descriptions omitted) :

front:CARD=Juli,DEV=0
surround40:CARD=Juli,DEV=0
surround41:CARD=Juli,DEV=0
surround50:CARD=Juli,DEV=0
surround51:CARD=Juli,DEV=0
surround71:CARD=Juli,DEV=0
iec958:CARD=Juli,DEV=0
null
front:CARD=CK804,DEV=0
surround40:CARD=CK804,DEV=0
surround41:CARD=CK804,DEV=0
surround50:CARD=CK804,DEV=0
surround51:CARD=CK804,DEV=0
surround71:CARD=CK804,DEV=0

I have two problems with this: first thing is that the "pulse" device is
not listed. I think that could be solved either by setting
"defaults.namehint.showall" to on, or by setting the name hint of the
pulse device to be included in the "basic" devices. Would you recommend
doing either one of those, and if so, which one?

Second problem is that I don't have surround input on either of my
soundcards, so most of the device options above do not make any sense.
Even if I try, I have a hard time recording from them (arecord fails to
record it with various errors, such as "Sample format non available").
If I instead use "plughw:CARD=name", recording works.

To sum it up, the output I would like to have, is at least these three:

plughw:CARD=Juli
plughw:CARD=CK804
pulse

How do I/we get there?

// David
