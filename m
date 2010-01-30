From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH 0/5] Echoaudio - add suspend/resume support
Date: Sat, 30 Jan 2010 16:31:23 +0100
Message-ID: <20100130163123.54d60739@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out112.alice.it (smtp-out112.alice.it [85.37.17.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 60CEE103846
	for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2010 16:36:26 +0100 (CET)
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


The following patch set adds suspend/resume support to all echoaudio drivers.
It has been tested on an IndigoIOx and a Gina3G. Rawmidi device has been
tested partially. PCM and controls interfaces have been tested more and I
think it's reasonably safe. I also have a Gina24 and a Gina3G, but I didn't
test suspend/resume with them because I couldn't manage to make PM test
system work on my pmac.

Echoaudio soundcards do not support power management and Dx PCI states.
Anyway, the card can enter a "comatose" state by sending a command to the
DSP that is supposed to turn parts of the hardware off and reduce power
consumption. Doing that causes the loss of the card's internal state, thus
it is impossible, upon resume, to make the card continue from the exact
point where it was suspended. The driver restores all controls and PCM
settings and the applications have to call prepare() to restart the
substreams. Rawmidi is restarted automatically, but some data in the i/o
buffers may be lost.


-- 
Giuliano.
