From: Ove Kaaven <ovek@transgaming.com>
Subject: PCM questions
Date: Thu, 04 Mar 2004 17:02:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078416129.1865.868.camel@renegade>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Okay, whoever says ALSA is greater than OSS, I'm trying to act on your
assertions, so here are a few questions.

I have the primary PCM configured with silence_threshold set to zero and
silence_size set to MAXINT. This condition is documented as "The whole
ring buffer is filled with silence at start. Later, only just processed
area is filled with silence."

When is "start"? Is it snd_pcm_prepare, or snd_pcm_start? If it's the
latter, it's not too useful, as I currently snd_pcm_prepare, fill the
mmap buffer with sounds, then run snd_pcm_start. Right now when I do
that, the beginning of the sound effect that triggers snd_pcm_start is
silent (but more gets streamed into the mmap buffer later on, and that
is heard). With ALSA's oddball mmap scheme it's not like I could just
easily do the silence processing myself, so it would be nice if ALSA's
would do the right thing.

And is there a way to query what the current application frame position
is, without tracking it myself? Have to do a lot of rewinds (and
forwards) here to add more sound effects to the mmap buffer and such,
and being able to sanity-check the offsets would probably be nice.

And for sound cards capable of hardware mixing, is there a way to have
two PCMs that share a buffer, but can be still be started and stopped
independently? For example, if I've loaded an explosion sound into a PCM
buffer, how can I start a lot of explosion sounds, without wasting a lot
of RAM? Perhaps there's also a way to specify that this sound should be
loaded into the sound card's onboard memory, instead of streamed from
system RAM?




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
