From: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
Subject: HP dv series mute LED problems?
Date: Wed, 12 May 2010 00:25:07 +0530
Message-ID: <201005120025.07730.kunal.gangakhedkar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C95DE1037EA
	for <alsa-devel@alsa-project.org>;
	Tue, 11 May 2010 20:55:19 +0200 (CEST)
Received: by wyf19 with SMTP id 19so455108wyf.38
	for <alsa-devel@alsa-project.org>; Tue, 11 May 2010 11:55:19 -0700 (PDT)
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
Cc: thoralf.freitag@cactus-online.de, ALSA Devel List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

The commit 26ebe0a28986f4845b2c5bea43ac5cc0b9f27f0a seems to undo the mute LED
gpio fixes - at least on my dv6 series laptop.

Maybe, we need to come up with a better solution to accommodate the problem 
reported in this thread:
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-May/027352.html
I believe, that's the reason for the commit, right?

Let me do a bit more digging.
 
Thanks,
Kunal
