From: Trent Piepho <tpiepho@gmail.com>
Subject: Problems with rate plugin and writing sizes other than
	the period size
Date: Thu, 26 Jan 2012 20:08:38 -0500
Message-ID: <CA+7tXigkC0f7DkbKsjNbJD2exAeK0HgK8abRSBWHgDs+ZaQOCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D37DC243B7
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2012 02:08:39 +0100 (CET)
Received: by iaby26 with SMTP id y26so1524706iab.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2012 17:08:38 -0800 (PST)
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

This is a problem I've been able to duplicate on multiple systems with
different hardware.

If one sets up rate conversion, from 22050 Hz to 48000 Hz, which is a
non-integer ratio, then a hw params with two periods doesn't work if
you write greater than the period size.  An audio underrun occurs
after each period.

Tracing with both strace and inside the driver reveals what's going
on.  The first snd_pcm_writei() goes through and the driver receives
the appropriate number of rate converted frames.  On the next
snd_pcm_writei() alsa-lib calls poll() to wait for space to be
available in the buffer.  avail_min is set to one period, and there is
less than one period left in the buffer, since the first write wrote
more than one period.  Eventually avail is greater than avail_min and
poll returns.  So far as expected.  Now here's the problem, rather
than writing a period alsa-lib just calls poll() again.  Which returns
immediately since there is still greater than avail_min available
space in the buffer.  And this continues, with alsa-lib in a tight
loop calling poll() and poll() returning immediately, until the buffer
empties and underflow occurs.

If the number of periods is increased the same thing happens, without
the underflow each period.  Alsa-lib will wait until there are TWO
empty periods in the buffer, in a tight loop calling poll() which
returns immediately while avail is greater avail_min and less than two
periods worth.  It's basically like the avail_min setting has been
changed to period_size*2 as far as alsa-lib is concerned, so of course
two periods will always cause underruns.  More than two work without
certain underruns, but alsa-lib is sitting in a tight loop because it
keeps calling poll() even though avail > avail_min.

Anyone know what's going on here?  Seems like a bug in alsa-lib, but I
find it hard to believe no one would have noticed this before.
