From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Mon, 16 Jun 2008 14:07:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806161329250.1798@tm8103-a.perex-int.cz>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hd4mlhlau.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806130958000.1798@tm8103-a.perex-int.cz>
	<s5hr6b1qrri.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806131733180.1798@tm8103-a.perex-int.cz>
	<s5hmylpqq9z.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806131813150.1798@tm8103-a.perex-int.cz>
	<4852D095.1000508@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 24A9C2458B
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jun 2008 14:07:27 +0200 (CEST)
In-Reply-To: <4852D095.1000508@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

Hi all,

	I tried to describe expressions for all values as Lennart proposed 
with current snd_pcm_avail_update() / snd_pcm_delay() functions and add 
some more comments to things noted in this discussion. I do not think that 
we should make internal ring buffer pointers external for applications.

Lennart's proposal (marked with *, my reply marked with -)

* ABSOLUTE_WRITE: the current absolute write counter in samples, since
  the device was opened.
- the application can calculate this value itself without too much pain

* ABSOLUTE_READ:  the current absolute read counter in samples, since
  the device was opened.
- if it's value 'how much samples consumer (driver) read':
  ABSOLUTE_WRITE - (buffer_size - snd_pcm_avail_update())
  
* ABSOLUTE_HEAR: the current absolute hear counter in samples, since
  the device was opened 
- ABSOLUTE_WRITE - snd_pcm_delay()

* WRITE_TO_READ:  the current fill level of the playback buffer
- buffer_size - snd_pcm_avail_update()

* WRITE_TO_HEAR:  if i write a sample immediately after this call, how
  much time takes it to be played.
- snd_pcm_delay()

* READ_TO_HEAR:   the 'fifo' latency, i.e. the time that passes
  after a sample was read form the playback buffer that it is actually played.
- snd_pcm_delay() - (buffer_size - snd_pcm_avail_update())

* CAN_WRITE:      how much can be written into the buffer right
  now  (buffer_size - WRITE_TO_READ)
- snd_pcm_avail_update()

* LEFT_TO_PLAY:   similar to WRITE_TO_HEAR but callable *after* we
  wrote something, and it will return how much of what we wrote has not
  been heard yet. In contrast to WRITE_TO_HEAR this will return 0
  eventually.
- this accouting can be easily done in app using snd_pcm_delay() - 
  application know how many samples were written


Atomicity of 'avail / delay' values:

It's not actually guaranteed. But I'm not sure if it's required to have
these values "in exact sync". Both values have different meaning. While
avail value should be used for the ring buffer filling / draining,
the purpose of delay value is for sync with other timing source. In time
of call, both functions (snd_pcm_avail_update() and snd_pcm_delay())
return correct value.

Only the READ_TO_HEAD expression uses both delay + avail values. I'm not 
sure for which purpose application will use this value. It seems to me 
only purely informational and we should offer this "internal queue size" 
value using another API.

But I am open to implement atomic call in alsa-lib:

Original functions:

snd_pcm_avail_update()		/* light version - not forced ptr sync */
snd_pcm_delay()			/* already includes hwsync() */
snd_pcm_hwsync()		/* might be osoleted by snd_pcm_avail() ? */

New:

snd_pcm_sframes_t snd_pcm_avail(snd_pcm_t *);	/* adds hwsync() */
int snd_pcm_avail_and_delay(snd_pcm_t *,
			    snd_sframes_t *avail, 
			    snd_sframes_t *delay);
	/* hwsync() + avail_update() + delay() - atomic operation */

This extension will allow us to optimize case when both avail and delay 
values are required by application and we can remove "problematic" 
snd_pcm_hwsync() function by snd_pcm_avail() function.


Exposing appl_ptr / hw_ptr / curr_ptr to applications

More complicated buffer state description. Applications must do pointer
wrap calculations itself, including underrun / overrun detection. It's
far more complicated that current avail / delay scheme.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
