From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Problems with snd-hda-intel on hp 6930p (2.6.30)
Date: Mon, 29 Jun 2009 20:37:09 +0200
Message-ID: <200906292037.09597.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 1184F103814
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Jun 2009 20:37:13 +0200 (CEST)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I have a problem with snd-hda-intel from 2.6.30 on an hp EliteBook 6930p, which
is that the sound is not audible, although everything appears to work just
fine.  Except maybe that when the box is rebooted and KDE (3.5) is started,
the master control is "muted" and the led indicator next to the keyboard shows
"no sound".  Then, changing the "muted" status of the master control doesn't
change the state of the led indicator and vice versa (the two things appear to
be totally independent of each other).

Can you please tell me what I can do to debug this issue?

Best,
Rafael
