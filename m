From: Daniel Mack <daniel@caiaq.de>
Subject: usbaudio: Support for USB audio v2.0 devices
Date: Mon, 22 Feb 2010 23:49:08 +0100
Message-ID: <1266878953-9184-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 674B424468
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 23:49:40 +0100 (CET)
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
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Here's a new version of the patchset to start support for USB audio
v2.0 devices. I moved all the definitions to linux/usb/audio.h.

As I did that, I realized that there's actually many definitions in
sound/usb/usbaudio.h which don't need to be there at all. Most of them
are already defined in audio.h and ch9.h. Hence, I added a 5th patch
to consolidate things and ease the chaos a bit. Hope I didn't break
anything :)

Daniel
