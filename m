From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Priming buffer
Date: Thu, 11 Sep 2003 19:16:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprvciajj2q1sf88@mail.broadpark.no>
References: <oprtfwlccjwl3raa@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <oprtfwlccjwl3raa@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Sep 2003 14:17:59 +0200 (METDST), Clemens Ladisch=20
<clemens@ladisch.de> wrote:

> Arve Knudsen wrote:
>> What's the purpose of set_start_threshold?
>
> The stream will automatically start when the buffer has been filled up
> to the amount specified by start_threshold.
Ok, obviously there's something I don't understand (no surprise). I did a=
=20
little test where I set start threshold to buffer size, acquire memory=20
using snd_pcm_mmap_begin (number of returned frames equals buffer size),=20
fill the buffer and do a snd_pcm_mmap_commit. After the commit I check th=
e=20
state of the card, which is SND_PCM_STATE_PREPARED (a started pcm would b=
e=20
in the running state?). Or do you mean actual transfer of data, by start=20
of stream?

Back to my original goal: I did an explicit start of the pcm after fillin=
g=20
the buffer, but the output still sounds muted for some reason. If I start=
=20
the pcm *before* writing to the buffer however (like I normally would),=20
the output is like expected. Any idea what causes this initial muting of=20
the output?

Thanks

Arve Knudsen


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
