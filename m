From: Konrad Schlichtherle <kconny@gmx.de>
Subject: alsa-sink.c: ALSA woke us up to write new data to the
 device, but there was actually nothing to write!
Date: Wed, 13 Jan 2010 19:43:48 +0100
Message-ID: <4B4E1464.3090801@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 1A5E7103843
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 19:43:59 +0100 (CET)
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

Hello,

sometimes it occure that my speakers do not play sound although the
speakers should play music with VLC. Then i took a look at
/var/log/messages and found this:

Jan 13 17:01:39 riker pulseaudio[3335]: alsa-sink.c: ALSA woke us up to
write new data to the device, but there was actually nothing to write!
Jan 13 17:01:39 riker pulseaudio[3335]: alsa-sink.c: Most likely this is
a bug in the ALSA driver 'snd_hda_intel'. Please report this issue to
the ALSA developers.
Jan 13 17:01:39 riker pulseaudio[3335]: alsa-sink.c: We were woken up
with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or
another value < min_avail.

The output of utils_alsa-info.sh is there:
http://www.alsa-project.org/db/?f=1767e9bc745724a67c908549d20c137375d0605e

I didn't know wether this is a bug or a misconfiguration of my openSUSE 11.2

Konrad
