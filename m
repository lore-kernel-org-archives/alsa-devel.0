From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Priming buffer
Date: Mon, 15 Sep 2003 19:26:49 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309151917560.24294-100000@studcom.urz.uni-halle.de>
References: <oprvd9xln2q1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <oprvd9xln2q1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Arve Knudsen wrote:
> On Fri, 12 Sep 2003 16:51:26 +0200 (METDST), Clemens Ladisch
> <clemens@ladisch.de> wrote:
> Maybe I should rephrase my question, now that I've got some time to think
> about it. Exactly what gets started when the start threshold is reached,
> the transfer of frames to the audio card (assuming we're writing frames)?
> Obviously it doesn't affect the state of the pcm, like snd_pcm_start does
> (SND_PCM_STATE_RUNNING).

When at least start_threshold frames have been written to the buffer,
the pcm will be started. This _will_ affect the pcm's state.

To quote alsa-kernel/core/pcm_lib.c (in snd_pcm_lib_write1):

  if (runtime->status->state == SNDRV_PCM_STATE_PREPARED &&
      snd_pcm_playback_hw_avail(runtime) >= (snd_pcm_sframes_t)runtime->start_threshold) {
          err = snd_pcm_start(substream);

> It seems to me a start threshold equal to buffer size would mean
> no transfer of data goes on before the buffer is filled?

Yes.

> If this is correct, what would it mean in the case of capture
> (reading frames from the card).

When, in the prepared state, you want to read at least start_threshold
frames in one call to xxx_read, the pcm will be started.


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
