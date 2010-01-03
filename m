From: Giuliano Pochini <pochini@shiny.it>
Subject: Echoaudio, suspend/resume question on rawmidi device
Date: Sun, 3 Jan 2010 21:55:45 +0100
Message-ID: <20100103215545.1e76385e@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out01.alice.it (smtp-out01.alice.it [85.33.2.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C07F24350
	for <alsa-devel@alsa-project.org>; Sun,  3 Jan 2010 21:56:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have some patches that add PM support to all echoaudio drivers. It seems
to work fine, but it has been tested on two cards only and the rawmidi
device hasn't been tested at all. I can't test it because
suspend-to-anything does not work on my pmac. I want to be sure at least it
cannot deadlock.

 * On suspend:

Rawmidi input is interrupt-driven. The driver tells the card to stop
accepting data.

Rawmidi output is timer-driven. The driver uses a timer to check if the
card's output buffer has room for more data to send. Do del_timer_sync()
and wait until all buffered data is sent, which may take 20ms (64 bytes at
31250bps).

 * On resume:

Input: Re-enable midi in.

Output: Restart the timer.


Do you see any race condition or weak points in this scheme, especially in
the midi-out part ? Is del_timer_sync() safe ?


-- 
Giuliano.
