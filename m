From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Status of snd_pcm_rewind()
Date: Sat, 22 Dec 2007 19:33:01 +0100
Message-ID: <20071222183301.GA3733@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id C58072446D
	for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2007 19:33:02 +0100 (CET)
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi!

What's the status of snd_pcm_rewind()? Is it available on all devices?
I assume not (at least dmix doesn't...). But I guess I can safely
assume it is available when mmap is used? Is there any API function to
test if it is available?

I am working on adding "glitch-free" support to PulseAudio. I.e. have
a huge playback buffer (> 2s), and schedule playback based on system
timers instead of sound card interrupts, thus allowing us to
dynamically adjust the inetrrupt frequency to the clients that are
connected, and thus save power. I can enable this technique only if I
can rewrite the playback buffer whenever I need to, thus I need to in
advance if snd_pcm_rewind() will work or not.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
