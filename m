From: pl bossart <bossart.nospam@gmail.com>
Subject: UCM questions
Date: Thu, 20 Jan 2011 16:06:55 -0600
Message-ID: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0973824459
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 23:06:58 +0100 (CET)
Received: by iye19 with SMTP id 19so1131743iye.38
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2011 14:06:55 -0800 (PST)
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

Hello all,
I've been looking at the UCM code in
git://git.alsa-project.org/alsa-lib.git branch ucm. Looks both
simple/powerfl/useful, still I have a couple of questions (most likely
for Liam and Mark):

- how would a USB device be handled? An audio use case is defined by a
verb and device parameter. My understanding is for a USB headset used
for music playback, we would still use the 'HiFi' verb, but then we
would need a 'USB' device added in include/use-case.h ? Then how would
I make a difference between a USB headset and USB speakers?
- same question for remote displays/display port.
- how useful is the notion of 'card list'? Seems to me that the verbs
are the main entry points, and the notion of card is abstracted away.
For a given use case, the application can query the string containing
the device name. Or I am misled and verbs are only related to a given
card?
- If I want to enable a camcorder use case, possibly with multiple
microphones, do I still use the 'HiFi' verb? Or do we need a new verb
for capture cases? I don't see any mics as capture devices hence the
question.
- how would IEC-formatted data be handled for HDMI/SPDIF? It could be
a different physical device for PCM and IEC-formatted data, and you
would need to enable IEC-related switches in the alsa controls. Or
would a modifier be more appropriate to provide additional information
on the content type?
- has anyone generated a typical configuration file for USB and
HDAudio? I only see an OMAP conf.

Thanks for your feedback
-Pierre
