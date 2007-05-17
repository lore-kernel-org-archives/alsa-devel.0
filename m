From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: Linux 2.6.21 regression with hda-intel (Conexant 5045)
Date: Thu, 17 May 2007 12:04:14 +0200
Message-ID: <f2h9a9$d15$1@sea.gmane.org>
Reply-To: G.Ohrner@post.rwth-aachen.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BBE024442
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2007 13:00:03 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HodiD-0006lt-V7
	for alsa-devel@alsa-project.org; Thu, 17 May 2007 13:00:01 +0200
Received: from bras-co-85-197-6-232.westend.de ([85.197.6.232])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 17 May 2007 13:00:01 +0200
Received: from G.Ohrner by bras-co-85-197-6-232.westend.de with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 17 May 2007 13:00:01 +0200
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

Hi!

First of all: Sorry if this question is dumb or a fix should be obvious, but
as a non-ALSA_expert I'm a bit a a loss at the moment... I searched the
bugtracker and this list but could not find anything appropriate - most
probably I missed a relevant post or didn't recognize it as being
relevant...

Any pointers are greatly appreciated!

The situation is as follows: Using Linux 2.6.20.4, my laptop's soundcard
works just fine. Using 2.6.21.1, it also works, but the headphone socket is
dead. Plugging a headphone into it correctly mustes the internal speakers,
but no sound is output via the headphones.

Details:

- Fujitsu Simens Amilo Si1520
- Codec: Conexant ID 5045 (as reported by Linux 2.6.20.4)

Alsa device details between both Linux kernels differ completely, with Linux
2.6.20.4 only reporting a single a single analog PCM device and Linux
2.6.21.1 reporting a Conexant Analog and a Conexant Digital device. Should
I still post the complete information from /proc/asound/* for both kernels?

I tried applying conexant-test22.patch by Tobin Davis, but it does not seem
to match the in-kernel ALSA code. It also does not seem to be related to
the 5045 chip...

Any ideas?

Greetings,

  Gunter
