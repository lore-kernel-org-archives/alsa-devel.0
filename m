From: David Henningsson <david.henningsson@canonical.com>
Subject: Kernel 3.2, and "speaker" controlling headphone path
Date: Wed, 11 Jul 2012 12:50:20 +0200
Message-ID: <4FFD5A6C.1060401@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 4117524363
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2012 12:50:22 +0200 (CEST)
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
Cc: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
List-Id: alsa-devel@alsa-project.org

It seems like on one machine the "Speaker Playback Volume" was part of 
the headphone path, in combination with PulseAudio this is leading to 
muted headphones.

One of my colleagues wrote a workaround for that specific machine - I'm 
providing links in case you're interested:

The patch:
https://launchpadlibrarian.net/109499922/restrict_bass.patch

Alsa-info:
https://launchpadlibrarian.net/109251353/bad-kernel-yes-headphones.txt

Bug link:
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/994685


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
