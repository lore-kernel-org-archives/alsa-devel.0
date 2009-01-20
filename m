From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Misusing snd_pcm_avail_update()
Date: Tue, 20 Jan 2009 03:57:28 +0100
Message-ID: <20090120025727.GA30499@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id DAF672435D
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 03:57:29 +0100 (CET)
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

Heya!

Currently in the 'glitch-free' logic of PulseAudio I use
snd_pcm_avail_update() to estimate how I need to program my system
timers for the next wake-up for the next buffer fill-up. For that I
assume that the current fill level of the hardware buffer is the
hardware buffer size minus what s_p_a_u() returns. I then convert that
fill level from sample units to time units, and fix it up by the
deviation of the sound card time from the system time. Finally I
substract some extra margin just to make sure.

This I assumed would tell me how much time will pass until an underrun
happens if I don't write anything. 

Mostly this logic works fine. But on some setups and cases it
doesn't. ALSA will signal an underrun much much earlier than what I
estimated like this.

I am now wondering why? One possibility of course is that s_p_a_u() is
not reliable, due to driver issues (there were problems in the HDA
driver about this, right?). Also, s_p_a_u() might simply lag behind
quite a bit, or -- what I think is most likely -- because samples are
popped in larger blocks form the hw playback buffer we reach the
underrun much earlier than expected.

I do acknowledge that the way i use s_p_a_u() is probably a misuse of
the API. I make asssumptions I probably shouldn't make.

Now, considering all this I'd like to ask for a new API function that
tells me how much time I really have before the next underrun. It
probably should just return a value in sample units, leaving it for
the application to deal with system/sound card clock deviations.

Any opinions on this?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
