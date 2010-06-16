From: Daniel Mack <daniel@caiaq.de>
Subject: usb-audio: some cleanup patches for 2.6.36
Date: Wed, 16 Jun 2010 17:57:26 +0200
Message-ID: <1276703851-22199-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A78C22413A
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 17:57:42 +0200 (CEST)
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
Cc: tiwai@suse.de, alexlee188@gmail.com, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Here are five patches that mostly do some basic cleanups. They're
unurgent and should be queued for 2.6.36.

I'm still pondering about the clock topology and how to fully support
all corner cases. That might take awhile to sort out.

Daniel

[PATCH 1/5] ALSA: usb-audio: clean up includes in clock.c
[PATCH 2/5] ALSA: usb-audio: unify UAC macros and struct names
[PATCH 3/5] ALSA: usb-midi: whitespace fixes
[PATCH 4/5] ALSA: usb-audio: move and add some comments
[PATCH 5/5] ALSA: usb-audio: simplify control interface access
