From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Priming buffer
Date: Fri, 12 Sep 2003 18:11:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprvd9xln2q1sf88@mail.broadpark.no>
References: <Pine.HPX.4.33n.0309120933080.3372-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0309120933080.3372-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Sep 2003 16:51:26 +0200 (METDST), Clemens Ladisch=20
<clemens@ladisch.de> wrote:

> Arve Knudsen wrote:
>> I did a little test where I set start threshold to buffer size,
>> acquire memory using snd_pcm_mmap_begin (number of returned frames
>> equals buffer size), fill the buffer and do a snd_pcm_mmap_commit.
>> After the commit I check the state of the card, which is
>> SND_PCM_STATE_PREPARED (a started pcm would be in the running
>> state?).
>
> In theory, what you do sounds correct. (I assume you've used frames,
> not bytes, for the start threshold.)
>
> Maybe you want to compare your code with aplay.c, which uses start
> threshold, too. (It calls snd_pcm_mmap_writei, which calls
> snd_pcm_write_areas, which calls snd_pcm_mmap_write_areas (defined in
> alsa-lib/src/pcm/pcm_mmap.c), which calls snd_pcm_mmap_begin and
> snd_pcm_mmap_commit.
>
>> Back to my original goal: I did an explicit start of the pcm after=20
>> filling
>> the buffer, but the output still sounds muted for some reason. If I=20
>> start
>> the pcm *before* writing to the buffer however (like I normally would)=
,
>> the output is like expected. Any idea what causes this initial muting =
of
>> the output?
>
> In theory, starting the pcm with an empty buffer causes an underrun to
> occur immediately.
>
> If I understand you correctly, the first buffer of audio data is
> replaced by silence. Maybe you've set a silence threshold?

Maybe I should rephrase my question, now that I've got some time to think=
=20
about it. Exactly what gets started when the start threshold is reached,=20
the transfer of frames to the audio card (assuming we're writing frames)?=
=20
Obviously it doesn't affect the state of the pcm, like snd_pcm_start does=
=20
(SND_PCM_STATE_RUNNING). Basically, before I've just used 0 as the start=20
threshold and filled the buffer with zeros prior to starting the pcm. It=20
seems to me a start threshold equal to buffer size would mean no transfer=
=20
of data goes on before the buffer is filled? If this is correct, what=20
would it mean in the case of capture (reading frames from the card).

Again thanks

Arve Knudsen


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
