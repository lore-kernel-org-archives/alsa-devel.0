From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Priming buffer
Date: Fri, 12 Sep 2003 16:51:26 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309120933080.3372-100000@studcom.urz.uni-halle.de>
References: <oprvciajj2q1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <oprvciajj2q1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Arve Knudsen <aknuds-1@broadpark.no>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Arve Knudsen wrote:
> I did a little test where I set start threshold to buffer size,
> acquire memory using snd_pcm_mmap_begin (number of returned frames
> equals buffer size), fill the buffer and do a snd_pcm_mmap_commit.
> After the commit I check the state of the card, which is
> SND_PCM_STATE_PREPARED (a started pcm would be in the running
> state?).

In theory, what you do sounds correct. (I assume you've used frames,
not bytes, for the start threshold.)

Maybe you want to compare your code with aplay.c, which uses start
threshold, too. (It calls snd_pcm_mmap_writei, which calls
snd_pcm_write_areas, which calls snd_pcm_mmap_write_areas (defined in
alsa-lib/src/pcm/pcm_mmap.c), which calls snd_pcm_mmap_begin and
snd_pcm_mmap_commit.

> Back to my original goal: I did an explicit start of the pcm after filling
> the buffer, but the output still sounds muted for some reason. If I start
> the pcm *before* writing to the buffer however (like I normally would),
> the output is like expected. Any idea what causes this initial muting of
> the output?

In theory, starting the pcm with an empty buffer causes an underrun to
occur immediately.

If I understand you correctly, the first buffer of audio data is
replaced by silence. Maybe you've set a silence threshold?


Regards,
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
