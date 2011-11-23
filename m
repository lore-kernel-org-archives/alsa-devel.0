From: Trent Piepho <tpiepho@gmail.com>
Subject: snd_pcm_drain and partial periods
Date: Wed, 23 Nov 2011 18:44:24 -0500
Message-ID: <CA+7tXii1Ah5Z7UxyHr0=jNALt-qORQ0fG8WcNiAGWuSxbMq=7g@mail.gmail.com>
References: <CA+7tXihfkZd6+UmnwJiyLgwo+6PoU9fWvzNhz7FKzy7DNgAWMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DD724103B31
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 00:44:25 +0100 (CET)
Received: by ggnq2 with SMTP id q2so2076833ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 15:44:25 -0800 (PST)
In-Reply-To: <CA+7tXihfkZd6+UmnwJiyLgwo+6PoU9fWvzNhz7FKzy7DNgAWMw@mail.gmail.com>
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

Say an application does not write a full multiple of the period size
with snd_pcm_writei(). =A0It's playing a clip and the clip ends and it
doesn't happen to end on a multiple of 6000 frames or whatever the
period size is.

Now the application calls snd_pcm_drain() to wait for the clip to finish.

How does the driver know to stop when it gets to the end of the
supplied data? =A0I don't see anywhere where this will get taken care
of. =A0It seems like the driver will keep playing until it calls
snd_pcm_period_elapsed() at the end of the final period. =A0Then the
alsa pcm layer will call the ->trigger() method and stop the stream.
Hopefully before the driver has started the next DMA for the next
period! =A0The application only wrote data for part of the final
period, so the driver will have played past the end of the supplied
data.

I don't see any documentation that says you must always supply a
multiple of the period size with snd_pcm_write[in](). =A0Nor about how
to deal with non-blocking mode and only part of the data getting
written.

I don't see any documentation for snd_pcm_drain() that says it will
keep playing until it finishes a period, even if the data runs out
before hand. =A0"For playback wait for all pending frames to be played
and then stop the PCM." =A0Seems pretty clear that only the pending
frames are played and not the rest of a period.

Yet the driver I'm working on definitely keeps playing to the end of
the period on drain. =A0Could be a driver problem, but I don't see how
any other drivers do anything differently here.
